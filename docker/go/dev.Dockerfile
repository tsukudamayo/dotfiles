FROM golang:buster

ENV GO111MODULE=on

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-get update \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main" \
    && apt-get update \
    && apt-get install -y emacs-snapshot \
#    llvm \
#    clang \
#    libclang-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && rm -rf /var/lib/apt/lists/*

RUN go get -u golang.org/x/tools/gopls
#     && go get -u golang.org/x/tools/cmd/goimports \
#     && go get -u golang.org/x/tools/cmd/godoc \
#     && go get -u golang.org/x/lint/golint \
#     && go get -u github.com/stamblerre/gocode \
#     && go get -u github.com/rogpeppe/godef \
#     && go get -u github.com/jstemmer/gotags \
#     && go get -u github.com/kisielk/errcheck \
#     && go get github.com/go-delve/delve/cmd/dlv 

EXPOSE 8080

CMD ["/bin/bash"]
