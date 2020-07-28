FROM debian:bullseye

RUN mkdir -p /workspace
WORKDIR /workspace

RUN apt-get update --allow-releaseinfo-change \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev \
    git \
    gcc \
    automake \
    libcurl4-openssl-dev \
    zlib1g-dev \
    make \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && rm -rf ./dotfiles \
    && git clone -b release https://github.com/roswell/roswell.git

WORKDIR /workspace/roswell
RUN ./bootstrap \
    && ./configure \
    && make \
    && make install

WORKDIR /workspace
    
CMD ["/bin/bash"]
