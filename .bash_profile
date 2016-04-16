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

#node
export PLENV_ROOT=$HOME/.plenv
export PATH=$PLENV_ROOT/bin:$PATH
eval "$(plenv init -)"
