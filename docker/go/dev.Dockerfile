FROM golang:buster

ENV GO111MODULE=on

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

RUN go get -u golang.org/x/tools/gopls
RUN go get -u golang.org/x/tools/cmd/goimports
RUN go get -u golang.org/x/tools/cmd/godoc
RUN go get -u golang.org/x/lint/golint
RUN go get -u github.com/stamblerre/gocode
RUN go get -u github.com/rogpeppe/godef
RUN go get -u github.com/jstemmer/gotags
RUN go get -u github.com/kisielk/errcheck
RUN go get github.com/go-delve/delve/cmd/dlv 

EXPOSE 8080

CMD ["/bin/bash"]
