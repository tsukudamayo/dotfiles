FROM julia:rc-buster

RUN mkdir -p /workspace
WORKDIR /workspace

RUN apt-get update \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev \
    git \
    wget \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

CMD ["bin/bash"]
