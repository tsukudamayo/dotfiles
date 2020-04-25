FROM python:3.7.7-buster

ENV DISPLAY=host.docker.internal:0.0

RUN useradd -G sudo -u 1000 --create-home user 

WORKDIR /home/user

RUN apt-get update \
    && apt-get -y install emacs \
    git \
    llvm \
    clang \
    libclang-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ./ \
    && cp -r ./dotfiles/.fonts ./


CMD ["/bin/bash"]
