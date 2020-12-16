FROM golang:buster

RUN apt-get update \
    && apt-get install -y software-properties-common
RUN apt-get update \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main"
RUN apt-get update \
    && apt-get install -y emacs-snapshot \
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

EXPOSE 8080

CMD ["/bin/bash"]
