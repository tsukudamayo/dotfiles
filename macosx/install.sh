#!/usr/bin/bash

mkdir lib
mkdir local
mkdir etc
mkdir opt
mkdir .fonts
mkdir lib/src

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew doctor
brew doctor

# git
brew install git
brew install git-flow

git config --global user.name "tsukudamayo"
git congig --global user.email "tsukudamayo@gmail.com"

# dotfiles
git clone https://github.com/tsukudamayo/dotfiles.git
cp -r ~/dotfiles/.emacs.d ~/
cp ~/dotfiles/.vimrc ~/
cp -r .vim/ ~/
chmod +x ~/dotfiles/.go/go-get.sh
.~/dotfiles/.go/go-get.sh

# docker
brew cask install docker

# iterm2
brew cask install iterm2

# emacs
brew cask install emacs

## for gpu install(cuda, cudnn, bazel, coreutils)
#brew install coreutils
#brew install bazel
#echo "cuDNN Library for OSX downloads and copy /usr/local/cuda"


# vlc
brew cask install vlc

# libreoffice
brew cask install libreoffice

# lua
brew install lua

# vim
mkdir vimfiles
mkdir vimfiles/swp
mkdir vimfiles/backup
mkdir vimfiles/undo

brew install vim ¥
--with-lua
--with-luajit
--override-system-vi
--with-tcl

# wget
xcode-select --install
brew install wget

# fonts(monaco bold)
git clone https://github.com/vjpr/monaco-bold.git ~/.fonts/

# google-chrome
brew cask install google-chrome

# firefox
brew cask install firefox

# skype
brew install skype

# cmake
brew install cmake

# llvm
brew install llvm

# protobuf(object_detection)
brew install protoc

# opencv
brew install opencv3 --with-contrib --with-python3 --without-python
ln -s /usr/local/Cellar/opencv/3.4.2/lib/python3.7/site-packages/cv2.cpython-37m-darwin.so ~/lib/miniconda3/envs/ssd/lib/python3.6/site-packages

# miniconda(python)
chmod +x Miniconda3-latest-MacOSX-x86_64.sh
./Downloads/Miniconda3-latest-MacOSX-x86_64.sh

# leveldb(for neo-python)
brew install leveldb

# sqlite
brew install sqlite3

# postgre
brew install postgresql

# go
brew install go
mkdir ~/go

# nodejs
brew install nodebrew
mkdir -p ~/.nodebrew/src
nodebrew install-binary latest
nodebrew list | awk -F'\t' '{print $1}' | xargs nodebrew use

npm install -g tern

# common lisp
brew install clisp

# rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
cargo install rustfmt --force
cargo install racer --force
cp Downloads/flycheck-cargo.el ~/.emacs.d/elpa/
git clone https://github.com/rust-lang/rust.git ~/lib/src/rust

