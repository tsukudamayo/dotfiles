FROM ubuntu:20.04

ENV DISPLAY=host.docker.internal:0.0
ENV TZ=Asia/Tokyo

ARG USERNAME=tsukudamayo

RUN apt-get update && apt-get install -y --no-install-recommends \
    tzdata \
    && apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    gnupg2 \
    git \
    curl \
    && git clone --depth 1 --branch emacs-27 https://git.savannah.gnu.org/git/emacs.git \
    && git clone https://github.com/tsukudamayo/dotfiles.git \
    && cp -r ./dotfiles/linux/.emacs.d ~/ \
    && cp -r ./dotfiles/.fonts ~/

WORKDIR emacs
RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    build-essential \
    libgccjit-10-dev \
    libjansson4 \
    libjansson-dev \
    libmagickcore-dev \
    libncurses-dev \
    libgnutls28-dev \
    xsel \
    && ./autogen.sh \
    && ./configure --with-native-compilation \
    --with-json \
    --with-mailutils \
    --without-makeinfo \
    --with-x-toolkit=no \
    --with-xpm=ifavailable \
    --with-gif=no \
    --with-gnutls=yes \
    && make -j4 \
    && make install \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    llvm-7-dev \
    lld-7 \
    clang-7 \
    nasm \
    acpica-tools \
    uuid-dev \
    qemu-system-x86 \
    qemu-utils \
    xauth \
    unzip \
    # added
    qemu-system-gui \
    dosfstools \
    python3-distutils \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists

# set alternatives
RUN for item in \
llvm-PerfectShuffle \
llvm-ar \
llvm-as \
llvm-bcanalyzer \
llvm-cat \
llvm-cfi-verify \
llvm-config \
llvm-cov \
llvm-c-test \
llvm-cvtres \
llvm-cxxdump \
llvm-cxxfilt \
llvm-diff \
llvm-dis \
llvm-dlltool \
llvm-dwarfdump \
llvm-dwp \
llvm-exegesis \
llvm-extract \
llvm-lib \
llvm-link \
llvm-lto \
llvm-lto2 \
llvm-mc \
llvm-mca \
llvm-modextract \
llvm-mt \
llvm-nm \
llvm-objcopy \
llvm-objdump \
llvm-opt-report \
llvm-pdbutil \
llvm-profdata \
llvm-ranlib \
llvm-rc \
llvm-readelf \
llvm-readobj \
llvm-rtdyld \
llvm-size \
llvm-split \
llvm-stress \
llvm-strings \
llvm-strip \
llvm-symbolizer \
llvm-tblgen \
llvm-undname \
llvm-xray \
ld.lld \
    lld-link \
    clang \
    clang++ \
    clang-cpp \
    ; do \
    update-alternatives --install "/usr/bin/${item}" "${item}" "/usr/bin/${item}-7" 50 \
    ; done

# switch to unprivileged
RUN addgroup --system user
RUN adduser --system ${USERNAME} --ingroup user
USER ${USERNAME}
WORKDIR /home/${USERNAME}

# build EDK II
RUN git clone --recursive https://github.com/tianocore/edk2.git edk2 \
 && (cd edk2 && git checkout 38c8be123aced4cc8ad5c7e0da9121a181b94251) \
  && make -C edk2/BaseTools/Source/C
#  && rm -rf edk2

# clone mikanos devenv
RUN git clone https://github.com/uchan-nos/mikanos-build.git osbook

# download standard libraries
RUN curl -L https://github.com/uchan-nos/mikanos-build/releases/download/v2.0/x86_64-elf.tar.gz \
  | tar xzvf - -C osbook/devenv

# switch back to root
USER root

# add ~/osbook/devenv to PATH
ENV PATH="/home/${USERNAME}/osbook/devenv:${PATH}"

# override startup command, taken from VSCode Devcontainer logs
CMD ["/bin/sh", "-c", "echo Container started ; trap \"exit 0\" 15; while sleep 1 & wait $!; do :; done"]
