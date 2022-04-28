FROM node:16-bullseye-slim

ENV LANG ja_JP.UTF-8
ENV HOST 0.0.0.0

ARG github_username
ARG github_password
ARG DB_USERNAME
ARG DB_PASSWORD
ARG DB_HOST
ARG DB_TABLENAME
ARG DB_INSTANCE_NAME

RUN apt-get update \
    && apt-get -y install git \
    yarn \
    curl \
    locales \
    && locale-gen ja_JP.UTF-8 \
    && localedef -f UTF-8 -i ja_JP ja_JP.utf8 \
    && git clone --depth 1 --branch emacs-28 https://git.savannah.gnu.org/git/emacs.git \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR emacs
RUN apt-get update && apt-get install -y vim \
    build-essential \
    libgccjit-10-dev \
    libjansson4 \
    libjansson-dev \
    libmagickcore-dev \
    libncurses-dev \
    libgnutls28-dev \
    texinfo \
    xsel \
    && ./autogen.sh \
    && ./configure --with-native-compilation \
    --with-json \
    --with-mailutils \
    --without-makeinfo \
    --with-x-toolkit=no \
    --with-xpm=ifavailable \
    --with-gif=no \
    --with-gnutls=yes \
    && make -j4 \
    && make install \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /workspace

#RUN npx create-next-app --example https://github.com/nikolasburk/blogr-nextjs-prisma/tree/main boaters_app
RUN git clone https://${github_username}:${github_password}@github.com/zizai-inc/boaters_app.git

WORKDIR /workspace/boaters_app
# deploy local docker-compose
#RUN `echo DATABASE_URL="mysql://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:3306/${DB_TABLENAME}?schema=public" > .env`
RUN `echo DATABASE_URL="postgresql://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:5432/${DB_TABLENAME}?schema=public" > .env`
# deploy GCP Cloud Run 
#RUN `echo DATABASE_URL="mysql://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:3306/${DB_TABLENAME}?host=/cloudsql/${DB_INSTANCE_NAME}" > .env`

# RUN npm install

EXPOSE 3000
# deploy GCP Cloud Run
#EXPOSE 8080

CMD ["/bin/bash"]
# deploy GCP Cloud Run
#CMD [ "npm", "run", "cloudrun" ]
