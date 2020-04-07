FROM golang:buster

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

CMD ["/bin/bash"]
