# FROM debian:bullseye 
FROM rust:slim-bullseye

ENV PATH $PATH:$HOME/.cargo/bin
ENV HOME /home

WORKDIR /home

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y software-properties-common \
    wget \
    curl \
    gnupg2 \
    git \
    libssl-dev \
    pkg-config \
    build-essential \
    gnutls-bin \
#     llvm \
#     clang \
#     libclang-dev \
#     lldb \
#     gdb \
    && rustup update \
    && rustup component add rustfmt clippy rls rust-analysis rust-src  \
    && mkdir -p ~/.cargo/bin \
    && curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.cargo/bin/rust-analyzer \
    && cargo install cargo-edit \
    && git clone --depth 1 --branch emacs-28 https://git.savannah.gnu.org/git/emacs.git \
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
    texinfo \
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

WORKDIR /workspace

CMD ["/bin/bash"]
# XXX USER
# emacs -nw --user ''
