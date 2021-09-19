# # mkdir
# mkdir ~/bin
# mkdir ~/lib
# mkdir ~/local
# mkdir ~/opt
# mkdir ~/etc
# mkdir ~/vimfiles
# mkdir ~/vimfiles/undo
# mkdir ~/vimfiles/backup
# mkdir ~/vimfiles/swp

# apt update
sudo apt-get update

# tmux
sudo apt-get -y install tmux

# git install
sudo apt-get -y install git
# sudo apt-get -y install git-flow
git config --global user.name "tsukudamayo"
git config --global user.email "tsukudamayo@gmail.com"

git clone https://github.com/tsukudamayo/dotfiles.git

# input method japanese
sudo apt install ibus-mozc 
ibus restart 
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'jp'), ('ibus', 'mozc-jp')]"

#cp -r ~/dotfiles/.emacs.d ~/
#cp -r ~/dotfiles/go ~/go
#cp ~/dotfiles/.tern-config ~/
#cp -r ~/dotfiles/.fonts ~/
cp ~/dotfiles/.vimrc ~/

# docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# nvidia-driver
sudo apt install -y nvidia-driver-470

# nvidia-container-toolkit
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)    && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -    && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

# # x11 client
# sudo apt-get -y install x11-apps

# # curl install
# sudo apt-get -y install curl
# 
# # wget 
# sudo apt-get -y install wget


# # exfat filesystem is not installed exfat filesystems is not installed in Ubuntu by default.
# sudo apt-get -y install exfat-fuse exfat-utils 

# # for input japanese mozc, ibus
# sudo apt-get -y install language-pack-ja-base language-pack-ja ibus-mozc

# # setting for japanese
# sudo update-locale LANG="en_US.UTF-8" LANGUAGE="en_US:"
# source /etc/default/locale
# echo $LANG

# # ibus reboot
# sudo apt-get -y install ibus-mozc
# killall ibus-daemon
# ibus-daemon -d -x &
# sudo apt-get install -y fcitx fcitx-mozc

# # html5 video
# sudo apt-get -y install ubuntu-restricted-extras

# # vim install
# sudo apt-get -y build-dep vim
# sudo apt-get -y install build-essential
# sudo apt-get -y install libxmu-dev libgtk2.0-dev libxpm-dev
# sudo apt-get -y install libperl-dev python-dev python3-dev ruby-dev
# sudo apt-get -y install lua5.2 liblua5.2-dev
# sudo apt-get -y install luajit libluajit-5.1
# sudo apt-get -y install autoconf automake cproto
# 
# git clone https://github.com/vim/vim.git ~/opt/vim
# git pull
# 
# cd ~/opt/vim
# 
# ./configure \
# --with-features=huge \
# --enable-gui=gtk2 \
# --enable-perlinterp \
# --enable-pythoninterp \
# --enable-python3interp \
# --enable-rubyinterp
# --enable-luainterp \
# --with-luajit \
# --enable-fail-if-missing
# 
# make 
# 
# sudo make install
# 
# # emacs install
# cd ~/opt
# wget http://ftp.gnu.org/gnu/emacs/emacs-26.1.tar.xz
# tar xvf emacs-26.1.tar.xz
# 
# cd ~/opt/emacs-26.1
# 
# ./configure \
# --with-jpeg=no \
# --with-gif=no \
# --with-tiff=no \
# --with-gnutls=no
# 
# make
# sudo make install 
# 
# cd ~/opt
# rm emacs-26.1.tar.xz

# # ffmpeg install
# sudo add-apt-repository ppa:jonathonf/ffmpeg-3
# sudo apt update
# sudo apt install ffmpeg libav-tools x264 x265
# 
# # google chrome install
# sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
# sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# sudo apt-get update
# sudo apt-get install google-chrome-stable
# 
# # kindle wine install
# sudo dpkg --add-architecture i386
# sudo add-apt-repository -y ppa:wine/wine-builds
# sudo apt update
# sudo apt install winehq-devel
# wineboot
# 
# # bazel install
# sudo apt-get -y install openjdk-8-jdk
# echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
# curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
# sudo apt-get update && sudo apt-get -y install bazel
# sudo apt-get -y upgrade bazel
# 
# # python install
# chmod +x ~/Downloads/Miniconda3-latest-Linux-x86_64.sh
# sh ~/Downloads/Miniconda3-latest-Linux-x86_64.sh
# 
# # go install
# sudo snap install --classic go
# #source .bashrc
# cp ~/dotfiles/.go ~/
# chmod +x .go/go-get.sh 
# bash $HOME/.go/go-get.sh
# 
# # rust install
# curl https://sh.rustup.rs -sSf | sh
# cargo install rustfmt
# cargo install racer
# 
# # c++ settings
# sudo apt-get install -y llvm-dev clang libclang-dev cmake
# 
# # docker install
# sudo apt-get install -y \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo apt-key fingerprint 0EBFCD88
# sudo add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"
# sudo apt-get update
# sudo apt-get install -y docker-ce
# 
# # node.js install
# sudo apt install -y nodejs npm
# sudo npm install n -g
# sudo n stable
# 
# # gcp sdk
# # Add the Cloud SDK distribution URI as a package source
# echo "deb http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# # Import the Google Cloud Platform public key
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# # Update the package list and install the Cloud SDK
# sudo apt-get update && sudo apt-get install google-cloud-sdk
# 
# # direnv
# git clone https://github.com/direnv/direnv
# cd direnv/
# sudo make install
# cd ~
# rm -rf direnv/
# echo 'eval "$(direnv hook bash)"' >> ~/.bashrc


