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
    curl \
    zip \
    unzip \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

WORKDIR /workspace/app

# 8sing yarn
RUN npm install -g typescript \
    aws-cdk \
    && npm install -D eslint \
    @typescript-eslint/parser \
    @typescript-eslint/eslint-plugin \
    prettier \
    eslint-config-prettier \
    eslint-plugin-prettier


CMD ["/bin/bash"]
