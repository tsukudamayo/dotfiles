FROM python:3.11.0-slim-bullseye

ENV DISPLAY=host.docker.internal:0.0
ENV PATH $PATH:/root/.local/bin

RUN apt-get update && apt-get install -y \
    git \
    curl \
    && curl -sSL https://install.python-poetry.org | python3 - \
    && pip install python-lsp-server pyright \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["/bin/bash"]
