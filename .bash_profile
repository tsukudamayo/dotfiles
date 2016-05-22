#vimのpathをHomebrewでインストールした時に/usr/local/bin/vimに変更
export PATH=/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin

#python3
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"

#virtualenv
eval "$(pyenv virtualenv-init -)"

#ruby
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

#perl
export PLENV_ROOT=$HOME/.plenv
export PATH=$PLENV_ROOT/bin:$PATH
eval "$(plenv init -)"

#node
export NODE_PATH=/usr/local/lib/node_modules
