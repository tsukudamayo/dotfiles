FROM golang:buster AS builder

ENV GO111MODULE=on

RUN go get -u golang.org/x/tools/gopls
#     && go get -u golang.org/x/tools/cmd/goimports \
#     && go get -u golang.org/x/tools/cmd/godoc \
#     && go get -u golang.org/x/lint/golint \
#     && go get -u github.com/stamblerre/gocode \
#     && go get -u github.com/rogpeppe/godef \
#     && go get -u github.com/jstemmer/gotags \
#     && go get -u github.com/kisielk/errcheck \
#     && go get github.com/go-delve/delve/cmd/dlv 

FROM golang:buster
ENV GO111MODULE=on

COPY --from=builder /go/bin/gopls /go/bin/gopls

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    software-properties-common \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    emacs-snapshot \
#    llvm \
#    clang \
#    libclang-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && rm -rf /var/lib/apt/lists/*

#RUN git clone git://git.savannah.gnu.org/emacs.git
#WORKDIR emacs
#RUN apt-get update \
#    && apt-get install -y autoconf \
#    gcc \
#    texinfo \
#    zlib1g-dev \
#    libgccjit-8-dev \
#    libncurses-dev \
#    && ./autogen.sh \
#    && ./configure --with-native-compilation --with-gnutls=no \
#    && make -j$(nproc) \
#    && make install \
#    && git clone https://github.com/tsukudamayo/dotfiles.git \
#    && cp -r ./dotfiles/linux/.emacs.d ~/ \
#    && cp -r ./dotfiles/.fonts ~/ \
#    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /go

EXPOSE 8080

CMD ["/bin/bash"]
