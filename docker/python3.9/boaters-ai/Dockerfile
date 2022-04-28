FROM python:3.9.9-slim-bullseye

ENV DISPLAY=host.docker.internal:0.0
ENV PATH $PATH:/root/.poetry/bin

RUN apt-get update && apt-get install -y \
    git \
    software-properties-common \
    curl \
    direnv \
    && echo 'eval "$(direnv hook bash)"' >> ~/.bashrc \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python \
    && pip install python-lsp-server \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
