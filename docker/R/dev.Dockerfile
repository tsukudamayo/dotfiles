FROM rockerjp/verse:latest

RUN mkdir -p /workspace
WORKDIR /workspace
ENV DISPLAY=host.docker.internal:0.0

RUN apt-get update \
    && apt-get install -y software-properties-common \
    gnupg2
RUN apt-get update  \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add
RUN add-apt-repository "deb http://emacs.ganneff.de/ buster main"

RUN apt-get update \
    && apt-get -y install emacs-snapshot \
    llvm \
    clang \
    libclang-dev \
    git \
    wget \
    curl \
    libx11-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

RUN R -e 'install.packages("rlang", dependencies = TRUE)' \
    && R -e 'install.packages("tidyverse", dependencies = TRUE)'

CMD ["bin/bash"]
