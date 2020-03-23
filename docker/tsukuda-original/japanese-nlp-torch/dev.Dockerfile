# build at https://github.com/pytorch/pytorch 

FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04
ARG PYTHON_VERSION=3.7
RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
	 wget \
         ca-certificates \
         libjpeg-dev \
         libpng-dev \
         software-properties-common \
         language-pack-ja \
         locales \
         file \
	 libssl-dev \
     && add-apt-repository ppa:kelleyk/emacs \
     && apt-get update && apt-get install -y --no-install-recommends emacs26 \
     && locale-gen ja_JP.UTF-8 \
     && echo "export LANG=ja_JP.UTF-8" >> ~/.bashrc \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/


# ----- #
# cmake #
# ----- #
WORKDIR /opt
RUN wget https://github.com/Kitware/CMake/releases/download/v3.16.1/cmake-3.16.1.tar.gz \ 
     && tar xvf cmake-3.16.1.tar.gz \
     && rm cmake-3.16.1.tar.gz
WORKDIR /opt/cmake-3.16.1
RUN ./bootstrap && make && make install


# ----- #
# kytea #
# ----- #
RUN mkdir -p /opt/kytea
WORKDIR /opt/kytea
RUN apt-get update \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev
RUN wget http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz \
    && tar xzf kytea-0.4.7.tar.gz
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


# ----- #
# mecab #
# ----- #
RUN mkdir -p /opt/mecab
WORKDIR /opt/mecab
RUN apt-get install -y mecab \
    libmecab-dev \
    mecab-ipadic-utf8 \
    && git clone https://github.com/neologd/mecab-ipadic-neologd.git \
    && sed -i -e 's/sudo make install/make install/' ./mecab-ipadic-neologd/libexec/install-mecab-ipadic-neologd.sh
RUN echo yes | ./mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -a -n


# ------- #
# juman++ #
# ------- #
RUN mkdir -p /opt/jumanpp
WORKDIR /opt/jumanpp
RUN wget https://github.com/ku-nlp/jumanpp/releases/download/v2.0.0-rc3/jumanpp-2.0.0-rc3.tar.xz
RUN tar xf jumanpp-2.0.0-rc3.tar.xz
WORKDIR /opt/jumanpp/jumanpp-2.0.0-rc3
RUN mkdir /opt/jumanpp/jumanpp-2.0.0-rc3/build
WORKDIR /opt/jumanpp/jumanpp-2.0.0-rc3/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local
RUN make
RUN make install

# --------- #
# juman knp #
# --------- #
RUN mkdir -p /opt/juman
WORKDIR /opt/juman
RUN wget http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/juman/juman-7.01.tar.bz2
RUN tar xvf juman-7.01.tar.bz2
WORKDIR juman-7.01
RUN ./configure
RUN make
RUN make install

RUN mkdir -p /opt/knp
WORKDIR /opt/knp
RUN wget http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/knp-4.19.tar.bz2
RUN tar xvf knp-4.19.tar.bz2
WORKDIR knp-4.19
RUN ./configure
RUN make
RUN make install


# ---------------- # 
# python conda pip # 
# ---------------- # 
RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include ninja cython typing && \
     /opt/conda/bin/conda install -y -c pytorch magma-cuda100 && \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH
# This must be done before pip so that requirements.txt is available
WORKDIR /opt/pytorch
COPY . .

RUN git submodule update --init --recursive
RUN TORCH_CUDA_ARCH_LIST="3.5 5.2 6.0 6.1 7.0+PTX" TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
    pip install -v .

RUN git clone https://github.com/pytorch/vision.git && cd vision && pip install -v .

RUN pip install virtualenv epc torchtext spacy mecab-python3 pyknp janome sentencepiece tinysegmenter3 "https://github.com/megagonlabs/ginza/releases/download/latest/ginza-latest.tar.gz" \
    && conda install -c anaconda swig 

WORKDIR /workspace
RUN chmod -R a+w .
