FROM rockerjp/verse:latest

RUN mkdir -p /workspace
WORKDIR /workspace
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
    xdg-utils --fix-missing \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

RUN R -e 'install.packages("rlang", dependencies = TRUE)' \
    && R -e 'install.packages("tidyverse", dependencies = TRUE)' \
    && R -e 'install.packages("shiny", dependencies = TRUE)' 

EXPOSE 3838

CMD ["/bin/bash"]
