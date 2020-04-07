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

# docker
brew install docker
brew cask install docker
open /Applications/Docker.app

# x11 client
brew cask install xquartz

# skype
brew cask install skype

# line
brew cask install line

# iterm2
brew cask install iterm2

# tmux
brew install tmux

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
brew install nodebrew
mkdir -p ~/.nodebrew/src
nodebrew install-binary latest
nodebrew list | awk -F'\t' '{print $1}' | xargs nodebrew use

npm install -g tern

# common lisp
brew install roswell
ros setup
ros install clisp
ros install slime

# scheme
brew cask install racket
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
brew cask install rstudio
git clone https://https://github.com/myuhe/auto-complete-acr.el.git ~/dotfiles/.emacs.d/elpa

# julia
brew cask install julia
