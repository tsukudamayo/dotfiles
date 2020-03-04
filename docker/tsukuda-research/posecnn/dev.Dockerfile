FROM tensorflow/tensorflow:1.2.1-gpu

RUN mkdir -p /workspace
WORKDIR /workspace
COPY . .
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


RUN git clone https://github.com/tsukudamayo/dotfiles.git \
  && cp -r ./dotfiles/linux/.emacs.d/ ~/ \
  && cp -r ./dotfiles/.fonts ~/


RUN pip install virtualenv \
  epc

WORKDIR /workspace/lib
RUN sh make.sh

mkdir -p data/imagenet_models
WORKDIR /workspace/data/imagenet_models
RUN wget https://drive.google.com/open?id=1UdmOKrr9t4IetMubX-y-Pcn7AVaWJ2bL

WORKDIR /workspace/lib/synthesize
RUN mkdir build
WORKDIR /workspace/lib/synthsize/build
RUN cmake ..
RUN make

ENV PYTHONPATH=$PYTHONPATH:/workspace/lib/synthsize/build 

WORKDIR /workspace
CMD chmod -R a+w .


