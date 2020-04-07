FROM python:3.7.7-buster

ENV DISPLAY=host.docker.internal:0.0

RUN mkdir -p workspace

RUN apt-get update \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

WORKDIR /workspace

CMD ["/bin/bash"]
