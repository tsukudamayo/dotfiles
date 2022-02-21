FROM golang:1.18-rc-bullseye AS builder

ENV GO111MODULE=on
RUN go install golang.org/x/tools/gopls@latest
#     && go get -u golang.org/x/tools/cmd/goimports \
#     && go get -u golang.org/x/tools/cmd/godoc \
#     && go get -u golang.org/x/lint/golint \
#     && go get -u github.com/stamblerre/gocode \
#     && go get -u github.com/rogpeppe/godef \
#     && go get -u github.com/jstemmer/gotags \
#     && go get -u github.com/kisielk/errcheck \
#     && go get github.com/go-delve/delve/cmd/dlv 

FROM golang:1.18-rc-bullseye
ENV GO111MODULE=on
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
ENV PATH $PATH:/root/google-cloud-sdk/bin
COPY --from=builder /go/bin/gopls /go/bin/gopls

RUN apt-get update \
    && apt-get install -y git \
    gnupg \
    curl \
    software-properties-common \
    && curl https://sdk.cloud.google.com > install.sh \
    && bash install.sh --disable-prompts \
    && git clone --depth 1 --branch emacs-27 https://git.savannah.gnu.org/git/emacs.git \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

WORKDIR emacs
RUN apt-get update && apt-get install -y vim \
    build-essential \
    libgccjit-10-dev \
    libjansson4 \
    libjansson-dev \
    libmagickcore-dev \
    libncurses-dev \
    libgnutls28-dev \
    xsel \
    && ./autogen.sh \
    && ./configure --with-native-compilation \
    --with-json \
    --with-mailutils \
    --without-makeinfo \
    --with-x-toolkit=no \
    --with-xpm=ifavailable \
    --with-gif=no \
    --with-gnutls=yes \
    && make -j4 \
    && make install \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /go
RUN rm -rf emacs && rm -rf dotfiles

EXPOSE 8080

CMD ["/bin/bash"]
