FROM julia:rc-buster

RUN mkdir -p /workspace
WORKDIR /workspace
ENV PATH /opt/conda/bin:$PATH
ENV PYTHON_VERSION=3.7
ENV DISPLAY=host.docker.internal:0.0

RUN apt-get update \
    && apt-get -y install emacs \
    llvm \
    clang \
    libclang-dev \
    git \
    wget \
    curl \
    libx11-dev \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

# python
RUN curl -o ~/miniconda.sh -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x ~/miniconda.sh && \
    ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda install -y python=$PYTHON_VERSION matplotlib && \
    /opt/conda/bin/conda clean -ya

CMD ["bin/bash"]
