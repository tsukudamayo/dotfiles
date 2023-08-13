# mkdir
mkdir ~/bin
mkdir ~/lib
mkdir ~/local
mkdir ~/opt
mkdir ~/etc
mkdir ~/.vim
mkdir ~/.vim/undo
mkdir ~/.vim/backup
mkdir ~/.vim/swp

# apt update
sudo apt update

# tmux
sudo apt -y install tmux

# git install
sudo apt -y install git
# sudo apt-get -y install git-flow
git config --global user.name "tsukudamayo"
git config --global user.email "tsukudamayo@gmail.com"

git clone https://github.com/tsukudamayo/dotfiles.git ~/


# docker
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc;
do
    sudo apt remove $pkg;
done


sudo apt update
sudo apt install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install -y docker-ce \
     docker-ce-cli \
     containerd.io \
     docker-buildx-plugin \
     docker-compose-plugin
sudo service docker start
sudo usermod -aG docker $USER
sudo service docker restart

# emacs
sudo apt install -y autoconf \
     make \
     texinfo \
     gnutls-bin \
     libgccjit-12-dev \
     gcc \
     libgtk-3-dev \
     libgnutls28-dev \
     libtiff5-dev \
     libgif-dev \
     libjpeg-dev \
     libpng-dev \
     libxpm-dev \
     libncurses-dev \
     libjansson4 \
     libjansson-dev \
     libmagickcore-dev \
     libmagick++-dev \
     libtree-sitter-dev
cd ~/opt
git clone git://git.sv.gnu.org/emacs.git
cd emacs
./autogen.sh
CFLAGS='-I/usr/lib/gcc/x86_64-linux-gnu/12/include -L/usr/lib/gcc/x86_64-linux-gnu/12'
./configure \
    --with-native-compilation \
    --with-json \
    --with-tree-sitter \
    --with-imagemagick \
    --with-xwidets
make -j8
sudo make -j8 install
