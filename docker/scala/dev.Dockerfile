FROM debian:buster 
ENV LANG jp_JP.UTF-8

RUN apt-get update \
    && apt-get install -y software-properties-common \
    gnupg2 \
    wget \
    curl \
    git \
    zip \
    unzip
RUN apt-get update \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main"
RUN apt-get update \
    && apt-get install -y emacs-snapshot \
    llvm \
    clang \
    libclang-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

RUN curl -s "https://get.sdkman.io" | bash
RUN chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh"
RUN echo "bash $HOME/.sdkman/bin/sdkman-init.sh" >> $HOME/.bashrc

RUN echo "sdk install java" >> $HOME/.bashrc
RUN echo "sdk install scala" >> $HOME/.bashrc
RUN echo "sdk install sbt" >> $HOME/.bashrc

RUN mkdir -p /workspace
WORKDIR /workspace
CMD ["bin/bash"]
