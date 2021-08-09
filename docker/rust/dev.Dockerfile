# FROM debian:bullseye 
FROM rust:slim-bullseye

ENV HOME /home
ENV PATH $PATH:$HOME/.cargo/bin

WORKDIR /home

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y software-properties-common \
    wget \
    gnupg2 \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main" \
    && apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get -y install emacs-snapshot \
    vim \
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
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["/bin/bash"]
# XXX USER
# emacs -nw --user ''
