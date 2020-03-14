FROM debian:buster 

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

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
ENV PATH $PATH:$HOME/.cargo/bin

RUN rustup component add rustfmt-preview
RUN rustup component add rls-preview rust-analysis rust-src
RUN cargo install racer

RUN mkdir -p /workspace
WORKDIR /workspace

CMD ["/bin/bash"]
