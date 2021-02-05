FROM python:3.8.3-buster

ENV DISPLAY=host.docker.internal:0.0
ENV PATH $PATH:/root/.poetry/bin

RUN mkdir -p /workspace

RUN apt-get update \
    && apt-get install -y software-properties-common \
    gnupg2 \
    wget

RUN apt-get update  \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add
RUN add-apt-repository "deb http://emacs.ganneff.de/ buster main"

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get -y install emacs-snapshot \
    git \
    llvm \
    clang \
    libclang-dev \
    curl \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

WORKDIR /workspace

CMD ["/bin/bash"]
