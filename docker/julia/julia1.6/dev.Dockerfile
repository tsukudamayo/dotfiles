FROM julia:1.6-buster

#ENV PATH /opt/conda/bin:$PATH
ENV PYTHON_VERSION=3.9
ENV DISPLAY=host.docker.internal:0.0

RUN apt-get update \
    && apt-get install -y software-properties-common \
    wget \
    gnupg2 \
    && wget -q http://emacs.ganneff.de/apt.key -O- | apt-key add \
    && add-apt-repository "deb http://emacs.ganneff.de/ buster main" \
    && apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get -y install emacs-snapshot \
#    llvm \
#    clang \
#    libclang-dev \
    git \
    wget \
    curl \
    libx11-dev \
    make \
    libssl-dev \
    # for Plots.jl #####
    qt5-default \
    libqt5gui5 \
    ####################
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/ \
#    && wget https://github.com/kitware/cmake/releases/download/v3.16.1/cmake-3.16.1.tar.gz \ 
#    && tar xvf cmake-3.16.1.tar.gz \
#    && rm cmake-3.16.1.tar.gz
    && rm -rf /var/lib/apt/lists/*

# workdir /workspace/cmake-3.16.1
# run ./bootstrap && make && make install

# # python
# WORKDIR /workspace
# RUN curl -o ~/miniconda.sh -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
#     chmod +x ~/miniconda.sh && \
#     ~/miniconda.sh -b -p /opt/conda && \
#     rm ~/miniconda.sh && \
#     /opt/conda/bin/conda install -y python=$PYTHON_VERSION matplotlib && \
#     /opt/conda/bin/conda clean -ya
WORKDIR /workspace

CMD ["bin/bash"]
