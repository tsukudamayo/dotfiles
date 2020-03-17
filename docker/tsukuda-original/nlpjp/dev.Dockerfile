FROM python:3.7.6-buster

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

RUN wget http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz \
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
    && git clone https://github.com/neologd/mecab-ipadic-neologd.git \
    && sed -i -e 's/sudo make install/make install/' ./mecab-ipadic-neologd/libexec/install-mecab-ipadic-neologd.sh
RUN echo yes | ./mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -a -n \
    && pip install mecab-python3

# juman knp
RUN mkdir -p /juman
WORKDIR /juman
RUN wget https://github.com/ku-nlp/jumanpp/releases/download/v2.0.0-rc3/jumanpp-2.0.0-rc3.tar.xz
RUN tar xf jumanpp-2.0.0-rc3.tar.xz
WORKDIR /juman/jumanpp-2.0.0-rc3
RUN mkdir /juman/jumanpp-2.0.0-rc3/build
WORKDIR /juman/jumanpp-2.0.0-rc3/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local
RUN make
RUN make install
RUN pip install pyknp
 

# GINZA(SUDACHI)
RUN mkdir -p /ginza
WORKDIR /ginza
RUN pip install "https://github.com/megagonlabs/ginza/releases/download/latest/ginza-latest.tar.gz"


RUN mkdir /workspace
WORKDIR /workspace

# janome
RUN pip install janome

CMD ["bin/bash"]
