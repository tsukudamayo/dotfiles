FROM rockerjp/tidyverse:latest

ENV DISPLAY=host.docker.internal:0.0

RUN apt-get update \
    && apt-get install -y software-properties-common \
    gnupg2 \
    curl

RUN apt-get update && apt-get -y install git \
#    llvm \
#    clang \
#    libclang-dev \
#    libx11-dev \
    && git clone --depth 1 --branch emacs-27 https://git.savannah.gnu.org/git/emacs.git \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \

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

RUN R -e 'install.packages("rlang", dependencies = TRUE)' \
    && R -e 'install.packages("tidyverse", dependencies = TRUE)'\
    && rm -rf emacs && rm -rf dotfiles

WORKDIR /workspace

CMD ["bin/bash"]
