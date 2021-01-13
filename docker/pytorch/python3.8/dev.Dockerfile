FROM pytorch/pytorch
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        ccache \
        cmake \
        curl \
        git \
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

