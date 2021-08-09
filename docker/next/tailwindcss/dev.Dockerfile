FROM node:16.5-buster-slim

ENV LANG ja_JP.UTF-8
ENV HOST 0.0.0.0

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
    zip \
    unzip \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN npx create-next-app nextjs-ts-tailwind-example --use-npm --example "https://github.com/vercel/next-learn-starter/tree/master/basics-final"

WORKDIR /workspace/nextjs-ts-tailwind-example

RUN touch tsconfig.json \
    && mv components/date.js components/date.tsx \
    && mv components/layout.js components/layout.tsx \
    && mv lib/posts.js lib/posts.ts \
    && mv pages/_app.js pages/_app.tsx \
    && mv pages/index.js pages/index.tsx \
    && mv 'pages/posts/[id].js' 'pages/posts/[id].tsx' \
    && mv pages/api/hello.js pages/api/hello.ts \
    && npm install --save-dev typescript \
    @types/react \
    @types/node \
    eslint-config-prettier eslint-plugin-prettier \
    @typescript-eslint/parser @typescript-eslint/eslint-plugin \
    && npm install tailwindcss@latest postcss@latest autoprefixer@latest \
    && npx tailwindcss init -p

EXPOSE 3000

CMD ["/bin/bash"]
