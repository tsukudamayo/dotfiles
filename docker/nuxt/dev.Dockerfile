FROM node:buster
ENV LANG ja_JP.UTF-8

RUN apt-get update \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev \
    vim \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

RUN mkdir -p /app
WORKDIR /app
RUN npm install -g @vue/cli \
    @vue/cli-service-global

ENV HOST 0.0.0.0
EXPOSE 3000
CMD ["/bin/bash"]
