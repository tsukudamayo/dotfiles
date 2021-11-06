FROM golang:1.17-bullseye

ENV GO111MODULE=on
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
ENV PATH /root/.tfenv/bin:$PATH

RUN apt-get update \
    && apt-get install -y git \
    && git clone --depth 1 --branch emacs-27 https://git.savannah.gnu.org/git/emacs.git \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

WORKDIR emacs
RUN apt-get update && apt-get install -y vim \
    build-essential \
    libjansson4 \
    libjansson-dev \
    libmagickcore-dev \
    libncurses-dev \
    libgnutls28-dev \
    && ./autogen.sh \
    && ./configure --with-native-compilation \
    --with-mailutils \
    --without-makeinfo \
    --with-x-toolkit=no \
    --with-xpm=ifavailable \
    --with-gif=no \
    --with-gnutls=yes \
    && make -j4 \
    && make install \
    && go get -u golang.org/x/tools/gopls \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /go

CMD ["/bin/bash"]
