FROM python:3.7.7-buster

ENV DISPLAY=host.docker.internal:0.0
ENV PATH $PATH:/root/.poetry/bin

RUN mkdir -p /workspace

RUN apt-get update \
    && apt-get install -y git \
    curl \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

WORKDIR /workspace

CMD ["/bin/bash"]
