mkdir ~/lib
mkdir ~/local
mkdir ~/etc
mkdir ~/opt
mkdir ~/.fonts
mkdir ~/lib/src

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
cp -r ~/dotfiles/.vim/ ~/

# docker
brew install docker
brew install --cask docker
open /Applications/Docker.app

# x11 client
brew install --cask xquartz

# tmux
brew install tmux

# emacs
brew install --cask emacs

## for gpu install(cuda, cudnn, bazel, coreutils)
#brew install coreutils
#brew install bazel
#echo "cuDNN Library for OSX downloads and copy /usr/local/cuda"


# vlc
brew install --cask vlc

# libreoffice
brew install --cask libreoffice

# lua
brew install lua

# vim
mkdir ~/vimfiles
mkdir ~/vimfiles/swp
mkdir ~/vimfiles/backup
mkdir ~/vimfiles/undo

## TODO vim install error
# brew install vim ¥
# --with-lua
# --with-luajit
# --override-system-vi
# --with-tcl

# wget
xcode-select --install
brew install wget

# fonts(monaco bold)
git clone https://github.com/vjpr/monaco-bold.git ~/.fonts/

# google-chrome
brew install --cask google-chrome

# firefox
brew install --cask firefox

# pandoce
brew install pandoc 

# make
brew install make

# cmake
brew install cmake

# llvm
brew install llvm

# miniconda(python)
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda.sh
chmod +x ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda
source ~/miniconda/bin/activate
conda init

# leveldb(for neo-python)
brew install leveldb

# sqlite
brew install sqlite3

# postgre
brew install postgresql

# go
brew install go
mkdir ~/go
echo 'export GOPATH=~/go' >> ~/.bash_profile
source ~/.bash_profile
chmod +x ~/dotfiles/go/go-get.sh
./dotfiles/go/go-get.sh

# nodejs
brew install anyenv
anyenv init
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile
exec $SHELL -l
anyenv install --force-init
anyenv install nodenv

npm install -g tern

# common lisp
brew install roswell
ros setup
ros install clisp
ros install slime

# scheme
brew install --cask racket
raco pkg install sicp

# rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
cargo install rustfmt --force
rustup install nightly
cargo +nightly install racer --force
rustup component add rls-preview rust-analysis rust-src

# git clone https://github.com/hugoduncan/flycheck-cargo.git
# cp flycheck-cargo/flycheck-cargo.el ~/.emacs.d/elpa/
# rm -rf flycheck-cargo
# git clone https://github.com/rust-lang/rust.git ~/lib/src/rust

# R
brew install r
brew install --cask rstudio
git clone https://https://github.com/myuhe/auto-complete-acr.el.git ~/dotfiles/.emacs.d/elpa

# julia
brew install --cask julia

# gcp sdk
curl https://sdk.cloud.google.com > gcp-sdk-install.sh
bash gcp-sdk-install.sh --disable-prompts
rm gpc-sdk-install.sh 

# circleci/cli
curl -fLSs https://circle.ci/cli | bash

# stoplight-studio
brew install --cask stoplight-studio
