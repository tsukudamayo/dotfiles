#!/bin/bash

mkdir ~/bin
mkdir ~/lib
mkdir ~/local
mkdir ~/etc
mkdir ~/opt
mkdir ~/.fonts
mkdir ~/lib/src

# vim
mkdir ~/.vim
mkdir ~/.vim/swp
mkdir ~/.vim/backup
mkdir ~/.vim/undo

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

# docker deamon and multipass install(install go)
brew install docker
brew install docker-compose
brew install --cask multipass

# docker client install
curl -O https://download.docker.com/mac/static/stable/aarch64/docker-24.0.7.tgz
tar xzvf docker-24.0.7.tgz

mv docker/* $HOME/bin
rm -rf docker/
rm docker-24.0.7.tgz

# tmux
brew install tmux

# make
brew install make

# pandoc
brew install pandoc 

# emacs(native compile)
brew install autoconf gnutls texinfo
brew install --build-from-source libgccjit automake
cd ~/opt
git clone git://git.sv.gnu.org/emacs.git
cd emacs
./autogen.sh
./configure --with-native-compilation --with-ns --without-x
make install
sudo cp -r nextstep/Emacs.app /Applications/
