# mkdir
mkdir ~/bin
mkdir ~/lib
mkdir ~/local
mkdir ~/opt
mkdir ~/etc
mkdir ~/vimfiles
mkdir ~/vimfiles/undo
mkdir ~/vimfiles/backup
mkdir ~/vimfiles/swp

cp -r ~/dotfiles/.emacs.d ~/
cp -r ~/dotfiles/go ~/go
cp ~/dotfiles/.tern-config ~/
cp -r ~/dotfiles/.fonts ~/
cp ~/dotfiles/.vimrc ~/

# apt update
sudo apt-get update

# exfat filesystem is not installed exfat filesystems is not installed in Ubuntu by default.
sudo apt-get -y install exfat-fuse exfat-utils 

# for input japanese mozc, ibus
sudo apt-get -y install language-pack-ja-base language-pack-ja ibus-mozc

# setting for japanese
sudo update-locale LANG="en_US.UTF-8" LANGUAGE="en_US:"
source /etc/default/locale
echo $LANG

# ibus reboot
killall ibus-daemon
ibus-daemon -d -x &

# html5 video
sudo apt-get install ubuntu-restricted-extras

# install terminator
sudo apt-get -y install terminator

# install tmux
sudo apt-get -y install tmux

# curl install
sudo apt-get -y install curl

# git install
sudo apt-get -y install git
sudo apt-get -y git-flow

# git settings
git config --global user.name "tsukudamayo"
git config --global user.email "tsukudamayo@gmail.com"

# vim install
sudo apt-get -y build-dep vim
sudo apt-get -y install build-essential
sudo apt-get -y install libxmu-dev libgtk2.0-dev libxpm-dev
sudo apt-get -y install libperl-dev python-dev python3-dev ruby-dev
sudo apt-get -y install lua5.2 liblua5.2-dev
sudo apt-get -y install luajit libluajit-5.1
sudo apt-get -y install autoconf automake cproto

git clone https://github.com/vim/vim.git ~/opt/vim
git pull

cd ~/opt/vim

./configure \
--with-features=huge \
--enable-gui=gtk2 \
--enable-perlinterp \
--enable-pythoninterp \
--enable-python3interp \
--enable-rubyinterp
--enable-luainterp \
--with-luajit \
--enable-fail-if-missing

make 

sudo make install

# emacs install
cd ~/opt
wget http://ftp.gnu.org/gnu/emacs/emacs-26.1.tar.xz
tar xvf emacs-26.1.tar.xz

cd ~/opt/emacs-26.1

./configure \
--with-jpeg=no \
--with-gif=no \
--with-tiff=no \
--with-gnutls=no

make
sudo make install 

cd ~/opt
rm emacs-26.1.tar.xz

# ffmpeg install
sudo add-apt-repository ppa:jonathonf/ffmpeg-3
sudo apt update
sudo apt install ffmpeg libav-tools x264 x265

# google chrome install
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable

# kindle wine install
sudo dpkg --add-architecture i386
sudo add-apt-repository -y ppa:wine/wine-builds
sudo apt update
sudo apt install winehq-devel
wineboot

# bazel install
sudo apt-get -y install openjdk-8-jdk
echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get -y install bazel
sudo apt-get -y upgrade bazel

# python install
chmod +x ~/Downloads/Miniconda3-latest-Linux-x86_64.sh
sh ~/Downloads/Miniconda3-latest-Linux-x86_64.sh

# go install
sudo snap install --classic go
#source .bashrc
cp ~/dotfiles/.go ~/
chmod +x .go/go-get.sh 
bash $HOME/.go/go-get.sh

# rust install
curl https://sh.rustup.rs -sSf | sh
cargo install rustfmt
cargo install racer

# c++ settings
sudo apt-get install -y llvm-dev clang libclang-dev cmake