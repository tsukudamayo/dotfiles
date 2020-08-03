FROM golang:rc-buster
ENV GOROOT /usr/local/go
#ENV GO111MODULE on

RUN apt-get update \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

RUN go get -u golang.org/x/tools/gopls \
    && go get -u golang.org/x/tools/cmd/goimports \
    && go get -u golang.org/x/tools/cmd/godoc \
    && go get -u golang.org/x/lint/golint \
    && go get -u github.com/stamblerre/gocode \
    && go get -u github.com/rogpeppe/godef \
    && go get -u github.com/jstemmer/gotags \
    && go get -u github.com/kisielk/errcheck \
    && go get github.com/derekparker/delve/cmd/dlv 

CMD ["/bin/bash"]
