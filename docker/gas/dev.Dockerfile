FROM node:buster
ENV LANG ja_JP.UTF-8

RUN mkdir -p /workspace/app

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y software-properties-common \
    wget \
    gnupg2 \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main" 

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get -y install emacs-snapshot \
    llvm \
    clang \
    libclang-dev \
    vim \
    yarn \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

WORKDIR /workspace/app

# using npm
# RUN npm init -y \
#     && npm install -g typescript \
#     tslint \
#     @google/clasp \
#     @types/google-apps-script \
#     && tslint --init

# 8sing yarn
RUN yarn init -y \
    && yarn add -D @google/clasp \
    @types/google-apps-script \
    @typescript-eslint/eslint-plugin \
    @types/jest \
    eslint \
    jest \
    ts-jest

CMD ["/bin/bash"]
