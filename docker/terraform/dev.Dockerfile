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
    && git clone https://github.com/tfutils/tfenv.git ~/.tfenv \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && wget https://releases.hashicorp.com/terraform-ls/0.13.0/terraform-ls_0.13.0_linux_amd64.zip \
    && unzip terraform-ls_0.13.0_linux_amd64.zip \
    && rm terraform-ls_0.13.0_linux_amd64.zip \
    && mv terraform-ls /usr/local/bin \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

RUN wget https://golang.org/dl/go1.15.8.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.15.8.linux-amd64.tar.gz \
    && mkdir -p /go \
    && mkdir -p "$GOPATH/src" "$GOPATH/bin" \
    && chmod -R 777 "$GOPATH"

RUN go get -u golang.org/x/tools/gopls \
    && go get -u golang.org/x/tools/cmd/goimports \
    && go get -u golang.org/x/tools/cmd/godoc \
    && go get -u golang.org/x/lint/golint \
    && go get -u github.com/stamblerre/gocode \
    && go get -u github.com/rogpeppe/godef \
    && go get -u github.com/jstemmer/gotags \
    && go get -u github.com/kisielk/errcheck \
    && go get github.com/go-delve/delve/cmd/dlv

# git-secrets
RUN git clone https://github.com/awslabs/git-secrets.git
WORKDIR  git-secrets
RUN apt-get update && apt-get install make
RUN make && make install
RUN git secrets --register-aws --global
RUN git secrets --install /root/.git-templates/git-secrets
RUN git config --global init.templatedir '/root/.git-templates/git-secrets'

WORKDIR $GOPATH

EXPOSE 8080

CMD ["/bin/bash"]
