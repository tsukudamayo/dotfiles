FROM python:3.7.8-buster

# kytea
RUN mkdir -p /kytea
WORKDIR /kytea
RUN apt-get update \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
    && wget https://github.com/Kitware/CMake/releases/download/v3.16.1/cmake-3.16.1.tar.gz \ 
    && tar xvf cmake-3.16.1.tar.gz \
    && rm cmake-3.16.1.tar.gz

RUN pip install -r requirements.txt \
    && wget http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz \
    && tar xzf kytea-0.4.7.tar.gz

WORKDIR /kytea/cmake-3.16.1
RUN ./bootstrap && make && make install

WORKDIR /kytea
RUN rm -rf cmake-3.16.1

WORKDIR kytea-0.4.7

RUN ./configure \
    && make \
    && make install \
    && ldconfig

RUN wget http://www.ar.media.kyoto-u.ac.jp/mori/research/topics/NER/2014-05-28-RecipeNE-sample.tar.gz \
    && tar xvf 2014-05-28-RecipeNE-sample.tar.gz

RUN mkdir -p model

WORKDIR model
RUN wget http://www.phontron.com/kytea/download/model/jp-0.4.7-1.mod.gz \
    && gzip -d jp-0.4.7-1.mod.gz

WORKDIR /kytea

# mecab
RUN mkdir -p /mecab
WORKDIR /mecab
RUN apt-get install -y mecab \
    libmecab-dev \
    mecab-ipadic-utf8 \
    && git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git

WORKDIR /mecab/mecab-ipadic-neologd
RUN ./bin/install-mecab-ipadic-neologd -n -a \
    && sed -i 's/dicdir.*/dicdir = \/usr\/lib\/x86_64-linux-gnu\/mecab\/dic\/mecab-ipadic-neologd/' /etc/mecabrc
    && pip install mecab-python3
    

CMD ["bin/bash"]
