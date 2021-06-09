FROM node:14-buster
ENV LANG ja_JP.UTF-8
ENV DISPLAY=host.docker.internal:0.0

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

RUN mkdir -p /app
WORKDIR /app
RUN npm install -g @vue/cli \
    @vue/cli-service-global \
    vls

ENV HOST 0.0.0.0
EXPOSE 3000
CMD ["/bin/bash"]
