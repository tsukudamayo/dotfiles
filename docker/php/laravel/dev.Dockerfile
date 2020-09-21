FROM php:7.4-apache-buster

ENV DISPLAY=host.docker.internal:0.0

RUN mkdir -p /workspace

RUN apt-get update \
    && apt-get -y install emacs \
    vim \
    git \
    llvm \
    clang \
    libclang-dev \
    curl \
    wget \
    unzip \
    libmcrypt-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    libxml2-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

RUN docker-php-ext-install -j$(nproc) curl gd mbstring zip xml xmlrpc intl
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer 

RUN git clone https://github.com/tsufeki/tenkawa-php-language-server.git tenkawa/
WORKDIR tenkawa
RUN composer install --no-dev 
WORKDIR ../ 
RUN php ./tenkawa/bin/tenkawa.php

RUN rm -rf /var/lib/apt/lists/*
WORKDIR /workspace

EXPOSE 8000

CMD ["/bin/bash"]
