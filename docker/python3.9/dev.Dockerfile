FROM python:3.9.9-slim-bullseye

ENV DISPLAY=host.docker.internal:0.0
ENV PATH $PATH:/root/.poetry/bin

RUN apt-get update && apt-get install -y \
    git \
#    software-properties-common \
    curl \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python \
    && pip install python-lsp-server \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && rm -rf ./dotfiles \
    && rm -rf /var/lib/apt/lists/*

#WORKDIR emacs
#RUN apt-get update && apt-get install -y vim \
#    build-essential \
#    libgccjit-10-dev \
#    libjansson4 \
#    libjansson-dev \
#    libmagickcore-dev \
#    libncurses-dev \
#    libgnutls28-dev \
#    texinfo \
#    xsel \
#    && ./autogen.sh \
#    && ./configure --with-native-compilation \
#    --with-mailutils \
#    --without-makeinfo \
#    --with-x-toolkit=no \
#    --with-xpm=ifavailable \
#    --with-gif=no \
#    --with-gnutls=yes \
#    && make -j4 \
#    && make install \
#    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["/bin/bash"]
