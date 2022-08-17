FROM python:3.8-slim-bullseye

WORKDIR /app
RUN pip install --upgrade pip
RUN pip install pipenv
RUN mkdir log

COPY Pipfile ./
COPY Pipfile.lock ./

# RUN pipenv lock --keep-outdated -r --dev > requirements.txt \
#   && pip install -r requirements.txt

RUN pipenv requirements --dev > requirements.txt \
    && pip install -r requirements.txt

RUN apt update && apt install -y curl graphviz \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt install -y nodejs

RUN pip install python-lsp-server pyright

ENV PYTHONPATH  '/workspaces/algorithm-device-config/'

COPY . /app
