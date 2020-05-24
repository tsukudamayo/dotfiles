FROM r-base:latest

RUN mkdir -p /workspace
WORKDIR /workspace
ENV DISPLAY=host.docker.internal:0.0

RUN apt-get update \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev \
    git \
    wget \
    curl \
    libx11-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

CMD ["bin/bash"]
