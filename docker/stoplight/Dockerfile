FROM debian:bullseye as base

ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
ENV DISPLAY=host.docker.internal:0.0

RUN apt-get update \
    && apt-get install -y wget \
    llvm \
    clang \
    libclang-dev \
    make \
    libssl-dev \
    git \
    locales \
    # dependencies 
    libfuse-dev \
    libgtk-3-dev \
    libgtkglextmm-x11-1.2-dev \
    libxss-dev \
    libgconf2-dev \
    libnss3-dev \
    && locale-gen ja_JP.UTF-8

FROM base as install-emacs
RUN apt-get install -y software-properties-common \
    gnupg2
RUN wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add
RUN add-apt-repository "deb http://emacs.ganneff.de/ buster main"
RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y emacs-snapshot

FROM install-emacs as fetch-dotfiles
RUN git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ 

WORKDIR /workspace
RUN wget https://github.com/stoplightio/desktop/releases/download/v4.10.7/stoplight-next-4.10.7-x86_64.AppImage
RUN chmod a+x ./stoplight-next-4.10.7-x86_64.AppImage
RUN ./stoplight-next-4.10.7-x86_64.AppImage --appimage-extract

CMD ["./squashfs-root/app/stoplight-next"] 
