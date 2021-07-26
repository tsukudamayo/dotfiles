FROM debian:bullseye-slim

ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
ENV DISPLAY=host.docker.internal:0.0

RUN apt-get update \
    && apt-get install -y software-properties-common \
    gnupg2 \
    wget \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main" \
    && apt-get update \
    && apt-get install -y emacs-snapshot \
    llvm \
    clang \
    libclang-dev \
    make \
    libssl-dev \
    git \
    xclip \
    locales \
    && locale-gen ja_JP.UTF-8 \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && wget https://github.com/Kitware/CMake/releases/download/v3.16.1/cmake-3.16.1.tar.gz \ 
    && tar xvf cmake-3.16.1.tar.gz \
    && rm cmake-3.16.1.tar.gz \
    && cd cmake-3.16.1 \
    && ./bootstrap && make -j4 && make install \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["bin/bash"]
