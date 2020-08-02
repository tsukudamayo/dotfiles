FROM golang:buster
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
    && go get -u golang.org/x/tools/cmd/goimports

CMD ["/bin/bash"]
