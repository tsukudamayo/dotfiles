FROM php:buster

ENV DISPLAY=host.docker.internal:0.0

RUN mkdir -p /workspace

RUN apt-get update \
    && apt-get -y install emacs \
    git \
    llvm \
    clang \
    libclang-dev \
    curl \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

WORKDIR /workspace

EXPOSE 8000

CMD ["/bin/bash"]
