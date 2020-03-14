FROM debian:buster 

RUN  mkdir -p /home
WORKDIR /home
ENV HOME /home

RUN apt-get update \
    && apt-get -y install llvm \
    clang \
    libclang-dev \
    git \
    curl \
    lldb \
    gdb

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
ENV PATH $PATH:$HOME/.cargo/bin

RUN rustup component add rustfmt-preview
RUN rustup component add rls-preview rust-analysis rust-src
RUN cargo install racer

CMD ["/bin/bash"]
