FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
ARG PYTHON_VERSION=3.6
RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         ca-certificates \
         libjpeg-dev \
         libpng-dev \
         software-properties-common \
         language-pack-ja \
         locales \
         file \
         mecab \
         libmecab-dev \
         mecab-ipadic-utf8 \
     && add-apt-repository ppa:kelleyk/emacs \
     && apt-get update && apt-get install -y --no-install-recommends emacs26 \
     && locale-gen ja_JP.UTF-8 \
     && echo "export LANG=ja_JP.UTF-8" >> ~/.bashrc \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*


RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include ninja cython typing && \
     /opt/conda/bin/conda install -y -c pytorch magma-cuda100 && \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH
# This must be done before pip so that requirements.txt is available
WORKDIR ~
RUN git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r dotfiles/linux/.emacs.d ./ \
    && cp -r dotfiles/.fonts ./

WORKDIR /opt/pytorch
COPY . .

RUN git submodule update --init --recursive
RUN TORCH_CUDA_ARCH_LIST="3.5 5.2 6.0 6.1 7.0+PTX" TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
    pip install -v .

RUN git clone https://github.com/pytorch/vision.git && cd vision && pip install -v .

RUN pip install virtualenv janome mecab-python3 torchtext spacy \
    && conda install -c anaconda swig

WORKDIR /workspace
RUN chmod -R a+w .
