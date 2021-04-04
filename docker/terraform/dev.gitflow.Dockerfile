FROM python:3.9-buster

ENV GO111MODULE=on
ENV DISPLAY=host.docker.internal:0.0
ENV PATH $PATH:/root/.poetry/bin
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
ENV PATH /root/.tfenv/bin:$PATH

RUN apt-get update \
    && apt-get install -y software-properties-common \
    gnupg2 \
    wget

RUN apt-get update \
    # emacs
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main" \
    # terraform
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - \
    && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y emacs-snapshot \
    llvm \
    clang \
    libclang-dev \
    terraform \
    unzip \
    make \
    && git clone https://github.com/tfutils/tfenv.git ~/.tfenv \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && wget https://releases.hashicorp.com/terraform-ls/0.13.0/terraform-ls_0.13.0_linux_amd64.zip \
    && unzip terraform-ls_0.13.0_linux_amd64.zip \
    && rm terraform-ls_0.13.0_linux_amd64.zip \
    && mv terraform-ls /usr/local/bin \
    && pip install awscli \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

# Golang
RUN wget https://golang.org/dl/go1.16.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.16.linux-amd64.tar.gz \
    && mkdir -p /go \
    && mkdir -p "$GOPATH/src" "$GOPATH/bin" \
    && chmod -R 777 "$GOPATH" \
    && go get -u golang.org/x/tools/gopls \
    && go get -u golang.org/x/tools/cmd/goimports \
    && go get -u golang.org/x/tools/cmd/godoc \
    && go get -u golang.org/x/lint/golint \
    && go get -u github.com/stamblerre/gocode \
    && go get -u github.com/rogpeppe/godef \
    && go get -u github.com/jstemmer/gotags \
    && go get -u github.com/kisielk/errcheck \
    && go get github.com/go-delve/delve/cmd/dlv

# git flow
RUN wget --no-check-certificate -q -O - https://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh | bash

# github flow
RUN curl https://raw.github.com/github-flow/github-flow/v1.1/install.sh | $(which bash)

# git completion
RUN curl -o ~/.git-prompt.sh \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh \
    && echo "source /root/.git-prompt.sh" >> /root/.bashrc

# git flow completion
RUN curl -o ~/.git-flow-completion.bash \ 
    https://raw.github.com/bobthecow/git-flow-completion/master/git-flow-completion.bash \
    && echo "source /root/.git-flow-completion.bash" >> /root/.bashrc

# display git branch in terminal
RUN echo 'PS1="[\u:\W\$(__git_ps1)]\$ "' >> /root/.bashrc

# git-secrets
RUN git clone https://github.com/awslabs/git-secrets.git
WORKDIR  git-secrets
RUN make && make install
RUN git secrets --register-aws --global \
    && git secrets --install /root/.git-templates/git-secrets \
    && git config --global init.templatedir '/root/.git-templates/git-secrets'


WORKDIR $GOPATH

EXPOSE 8080

CMD ["/bin/bash"]
