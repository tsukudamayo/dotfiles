FROM julia:1.7-buster

#ENV PATH /opt/conda/bin:$PATH
ENV PYTHON_VERSION=3.9
ENV DISPLAY=host.docker.internal:0.0

RUN apt-get update \
    && apt-get install -y software-properties-common \
    wget \
    gnupg2 \
    && apt-get -y install git \
#    llvm \
#    clang \
#    libclang-dev \
    wget \
    curl \
    libx11-dev \
    make \
    libssl-dev \
    # for Plots.jl #####
    qt5-default \
    libqt5gui5 \
    ####################
    && julia -e 'using Pkg; Pkg.add("LanguageServer")' \
    && julia -e "using LanguageServer, LanguageServer.SymbolServer; runserver()" \
    && git clone --depth 1 --branch emacs-27 https://git.savannah.gnu.org/git/emacs.git \
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

WORKDIR emacs
RUN apt-get update && apt-get install -y vim \
    build-essential \
    libjansson4 \
    libjansson-dev \
    libmagickcore-dev \
    libncurses-dev \
    libgnutls28-dev \
    xsel \
    && ./autogen.sh \
    && ./configure --with-native-compilation \
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

CMD ["bin/bash"]
