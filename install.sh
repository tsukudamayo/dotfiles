# mkdir
mkdir ~/bin
mkdir ~/lib
mkdir ~/local
mkdir ~/opt
mkdir ~/etc

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

# git install
sudo apt-get -y install git

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
wget http://ftp.gnu.org/gnu/emacs/emacs-25.3.tar.xz
tar xvf emacs-25.3.tar.xz

cd ~/opt/emacs-25.3

./configure \
--with-jpeg=no \
--with-gif=no \
--with-tiff=no

make
sudo make install 

cd ~/opt
rm emacs-25.3.tar.xz

# python settings
LATEST_VERSION=$(pyenv install -list | grep anaconda3 | tail -n 1 | sed "s/\ //g")
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
pyenv install ${LATEST_VERSION}
pyenv rehash
pyenv global ${LATEST_VERSION}
conda update conda

