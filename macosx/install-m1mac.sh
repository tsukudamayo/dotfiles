#!/bin/bash

mkdir ~/bin
mkdir ~/lib
mkdir ~/local
mkdir ~/etc
mkdir ~/opt
mkdir ~/.fonts
mkdir ~/lib/src

# vim
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swp
mkdir -p ~/.vim/undo

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew doctor

# git
brew install git

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

# Rosseta2
softwareupdate --install-rosetta --agree-to-license

# kindle(x86)
brew install --cask kindle

# docker deamon and multipass install(install go)
brew install docker
brew install docker-compose
brew install --cask multipass

# docker client install
curl -O https://download.docker.com/mac/static/stable/aarch64/docker-20.10.17.tgz
tar xzvf docker-20.10.17.tgz 

mv docker/* $HOME/bin
rm -rf docker/
rm docker-20.10.17.tgz

# tmux
brew install tmux

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

# multipass launch and using docker context
# XXX launch failed: cannot connect to the multipass socket
# Need to wait restart multipass deamon
multipass launch --name docker-vm --cpus 8 --mem 8G --disk 200G --cloud-init $HOME/dotfiles/macosx/cloud-config-$(uname -m).yml 20.04
multipass mount /Users docker-vm:/Users
multipass mount /private/tmp docker-vm:/tmp

docker context create docker-vm --docker "host=tcp://$(multipass list | grep docker-vm | awk '{print $3}'):2375"
docker context use docker-vm
