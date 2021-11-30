FROM python:3.9.9-slim-bullseye

ENV DISPLAY=host.docker.internal:0.0
ENV PATH $PATH:/root/.poetry/bin

RUN apt-get update && apt-get install -y \
    git \
    software-properties-common \
    curl \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python \
    && pip install python-lsp-server \
    && git clone --depth 1 --branch emacs-27 https://git.savannah.gnu.org/git/emacs.git \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

WORKDIR emacs
RUN apt-get update && apt-get install -y vim \
    build-essential \
    libjansson4 \
    libjansson-dev \
    libmagickcore-dev \
    libncurses-dev \
    libgnutls28-dev \
    xsel \
    && ./autogen.sh \
    && ./configure --with-native-compilation \
    --with-mailutils \
    --without-makeinfo \
    --with-x-toolkit=no \
    --with-xpm=ifavailable \
    --with-gif=no \
    --with-gnutls=yes \
    && make -j4 \
    && make install \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
