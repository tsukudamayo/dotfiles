#!/bin/bash

mkdir ~/bin
mkdir ~/lib
mkdir ~/local
mkdir ~/etc
mkdir ~/opt
mkdir ~/.fonts
mkdir ~/lib/src

# vim
mkdir ~/vimfiles
mkdir ~/vimfiles/swp
mkdir ~/vimfiles/backup
mkdir ~/vimfiles/undo

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"


brew doctor

# git
brew install git
brew install git-flow

git config --global user.name "tsukudamayo"
git config --global user.email "tsukudamayo@gmail.com"
git config --global --add remote.origin.proxy ""
git config --global http.sslVerify "false"

# dotfiles
git clone https://github.com/tsukudamayo/dotfiles.git
cp -r ~/dotfiles/linux/.emacs.d ~/
cp ~/dotfiles/.vimrc ~/
cp -r ~/dotfiles/go .go
cp ~/dotfiles/.bash_profile ~/

# fonts(monaco bold)
git clone https://github.com/vjpr/monaco-bold.git ~/.fonts/

# xcode-select
xcode-select --install

# google-chrome
brew install --cask google-chrome

# firefox
brew install --cask firefox

# x11 client
brew install --cask xquartz

# docker (install go)
brew install docker
brew install docker-compose
brew install --cask multipass
multipass launch --name docker-vm --cpus 8 --mem 8G --disk 100G --cloud-init $HOME/dotfiles/macosx/cloud-config-$(uname -m).yml 20.04
multipass mount /Users docker-vm:/Users
multipass mount /private/tmp docker-vm:/tmp
curl -O https://download.docker.com/mac/static/stable/aarch64/docker-20.10.17.tgz
tar xzvf docker-20.10.17.tgz 

mv docker/* $HOME/bin
rm -rf docker/
rm docker-20.10.17.tgz 
docker context create docker-vm --docker "host=tcp://192.168.64.2:2375"
docker context use docker-vm

# # wget
# brew install wget

# tmux
brew install tmux

# # make
# brew install make

# # cmake
# brew install cmake

# # llvm
# brew install llvm

# emacs(native compile)
brew install autoconf gnutls texinfo
brew install --build-from-source libgccjit automake
## setting by .bash_profile
# echo 'export LIBRARY_PATH="$(brew --prefix libgccjit)/lib/gcc/10"' > ~/.bash_profile
# echo 'export PATH="/usr/local/opt/texinfo/bin:$PATH"' >  ~/.bash_profile
cd ~/opt
git clone git://git.sv.gnu.org/emacs.git
cd emacs
./autogen.sh
./configure --with-native-compilation --with-ns --without-x
make install
sudo cp -r nextstep/Emacs.app /Applications/

# # gcp sdk
# curl https://sdk.cloud.google.com > gcp-sdk-install.sh
# bash gcp-sdk-install.sh --disable-prompts
# rm gpc-sdk-install.sh 


## pandoc
#brew install pandoc 

## for gpu install(cuda, cudnn, bazel, coreutils)
#brew install coreutils
#brew install bazel
#echo "cuDNN Library for OSX downloads and copy /usr/local/cuda"


## vlc
#brew install --cask vlc
#
## libreoffice
#brew install --cask libreoffice
#
## lua
#brew install lua
#
## TODO vim install error
# brew install vim ¥
# --with-lua
# --with-luajit
# --override-system-vi
# --with-tcl

## miniconda(python)
#wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda.sh
#chmod +x ~/miniconda.sh
#bash ~/miniconda.sh -b -p $HOME/miniconda
#source ~/miniconda/bin/activate
#conda init

## leveldb(for neo-python)
#brew install leveldb
#
## sqlite
#brew install sqlite3
#
## postgre
#brew install postgresql
#
## go
#brew install go
#mkdir ~/go
#echo 'export GOPATH=~/go' >> ~/.bash_profile
#source ~/.bash_profile
#chmod +x ~/dotfiles/go/go-get.sh
#./dotfiles/go/go-get.sh
#
## nodejs
#brew install anyenv
#anyenv init
#echo 'eval "$(anyenv init -)"' >> ~/.bash_profile
#exec $SHELL -l
#anyenv install --force-init
#anyenv install nodenv
#
#npm install -g tern
#
## common lisp
#brew install roswell
#ros setup
#ros install clisp
#ros install slime
#
## scheme
#brew install --cask racket
#raco pkg install sicp
#
## rust
#curl https://sh.rustup.rs -sSf | sh
#source $HOME/.cargo/env
#cargo install rustfmt --force
#rustup install nightly
#cargo +nightly install racer --force
#rustup component add rls-preview rust-analysis rust-src

# git clone https://github.com/hugoduncan/flycheck-cargo.git
# cp flycheck-cargo/flycheck-cargo.el ~/.emacs.d/elpa/
# rm -rf flycheck-cargo
# git clone https://github.com/rust-lang/rust.git ~/lib/src/rust

## R
#brew install r
#brew install --cask rstudio
#git clone https://https://github.com/myuhe/auto-complete-acr.el.git ~/dotfiles/.emacs.d/elpa
#
## julia
#brew install --cask julia
#
## circleci/cli
#curl -fLSs https://circle.ci/cli | bash
#
## stoplight-studio
#brew install --cask stoplight-studio
