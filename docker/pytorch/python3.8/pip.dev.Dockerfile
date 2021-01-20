FROM nvidia/cuda:11.0-devel-ubuntu20.04

ENV PATH $PATH:/root/.poetry/bin
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libssl-dev \
        libffi-dev \
        ca-certificates \
        ccache \
        cmake \
        curl \
        wget \
        git \
        python3-dev \
        python3-pip \
        python3-venv \
        libjpeg-dev \
        libpng-dev \
        software-properties-common \
        language-pack-ja \
        locales \
    && add-apt-repository ppa:ubuntu-elisp/ppa \
    && apt-get update && apt-get install -y --no-install-recommends emacs-snapshot \
    && locale-gen ja_JP.UTF-8 \
    && echo "export LANG=ja_JP.UTF-8" >> ~/.bashrc \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN which python3 \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && which python 

RUN cd $HOME \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - \
    && pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio===0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

RUN mkdir -p /workspace
WORKDIR /workspace
