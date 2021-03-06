FROM python:3.8.3-buster

ENV DISPLAY=host.docker.internal:0.0
ENV PATH $PATH:/root/.poetry/bin

RUN mkdir -p /workspace

RUN apt-get update \
    && apt-get -y install emacs \
    git \
    llvm \
    clang \
    libclang-dev \
    curl \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

RUN pip install awscli

WORKDIR /workspace

CMD ["/bin/bash"]
