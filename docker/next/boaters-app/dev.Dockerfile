FROM node:16.5-buster-slim

ENV LANG ja_JP.UTF-8
ENV HOST 0.0.0.0

ARG github_username
ARG github_password
ARG DB_USERNAME
ARG DB_PASSWORD
ARG DB_HOST
ARG DB_TABLENAME

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y software-properties-common \
    wget \
    gnupg2 \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main" 

RUN apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get -y install emacs-snapshot \
    vim \
    git \
    yarn \
    curl \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

#RUN npx create-next-app --example https://github.com/nikolasburk/blogr-nextjs-prisma/tree/main boaters_app
RUN git clone https://${github_username}:${github_password}@github.com/zizai-inc/boaters_app.git -b develop

WORKDIR /workspace/boaters_app
RUN `echo DATABASE_URL="mysql://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:3306/${DB_TABLENAME}?schema=public" > .env`
RUN npm install

EXPOSE 3000

CMD ["/bin/bash"]
