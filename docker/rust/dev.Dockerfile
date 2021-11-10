# FROM debian:bullseye 
FROM rust:slim-bullseye

ENV HOME /home
ENV PATH $PATH:$HOME/.cargo/bin

WORKDIR /home

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y software-properties-common \
    wget \
    gnupg2 \
    git \
#     llvm \
#     clang \
#     libclang-dev \
#     lldb \
#     gdb \
    && rustup toolchain add nightly \
    && rustup update \
    && rustup component add rustfmt \
    && rustup component add rls rust-analysis rust-src \
    && cargo +nightly install racer \
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

WORKDIR /workspace

CMD ["/bin/bash"]
# XXX USER
# emacs -nw --user ''
