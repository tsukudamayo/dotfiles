FROM debian:buster

RUN mkdir -p /workspace
WORKDIR /workspace

RUN apt-get update \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev \
    git \
    wget \
    make \
    libssl-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && wget https://github.com/Kitware/CMake/releases/download/v3.16.1/cmake-3.16.1.tar.gz \ 
    && tar xvf cmake-3.16.1.tar.gz \
    && rm cmake-3.16.1.tar.gz

WORKDIR /workspace/cmake-3.16.1
RUN ./bootstrap && make && make install

CMD ["bin/bash"]
