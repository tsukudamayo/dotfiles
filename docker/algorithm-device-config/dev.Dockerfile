# FROM python:3.8-slim-bullseye
FROM public.ecr.aws/sam/build-python3.8:latest

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

# python:3.8-slim-bullseye
# RUN apt update && apt install -y curl graphviz \
#     && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
#     && apt install -y nodejs

# public.ecr.aws/sam/build-python3.8:latest
RUN yum -y update && yum -y install curl graphviz
RUN curl -sL https://rpm.nodesource.com/setup_16.x | bash -
RUN yum install -y nodejs npm
RUN curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
RUN rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
RUN yum install -y yarn

RUN pip install python-lsp-server pyright

ENV PYTHONPATH  '/workspaces/algorithm-device-config/'

COPY . /app
