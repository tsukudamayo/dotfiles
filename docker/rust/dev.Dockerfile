FROM debian:bullseye 

RUN  mkdir -p /home
WORKDIR /home
ENV HOME /home

RUN apt-get update \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev \
    git \
    curl \
    lldb \
    gdb \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH $PATH:$HOME/.cargo/bin

RUN rustup toolchain add nightly
RUN rustup update 
RUN rustup component add rustfmt
RUN rustup component add rls rust-analysis rust-src
RUN cargo +nightly install racer

RUN mkdir -p /workspace
WORKDIR /workspace

CMD ["/bin/bash"]
# XXX USER
# emacs -nw --user ''
