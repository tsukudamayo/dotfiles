FROM node:16.5-buster-slim

ENV LANG ja_JP.UTF-8
ENV HOST 0.0.0.0

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y software-properties-common \
    wget \
    gnupg2 \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main" 

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get -y install emacs-snapshot \
    vim \
    git \
    yarn \
    curl \
    zip \
    unzip \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && rm -rf /var/lib/apt/lists/*

RUN yarn global add typescript-language-server --prefix /usr/local

WORKDIR /workspace

EXPOSE 3000

CMD ["/bin/bash"]
