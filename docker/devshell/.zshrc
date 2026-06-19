# completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
setopt auto_menu

# Google Cloud SDK completion
if [ -f /usr/share/google-cloud-sdk/path.zsh.inc ]; then
  source /usr/share/google-cloud-sdk/path.zsh.inc
fi

if [ -f /usr/share/google-cloud-sdk/completion.zsh.inc ]; then
  source /usr/share/google-cloud-sdk/completion.zsh.inc
fi

# kubectl completion
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

alias k=kubectl
compdef k=kubectl

# aliases
alias kgp='kubectl get pod'
alias kgs='kubectl get svc'
alias kgd='kubectl get deploy'
alias kgds='kubectl get ds'
alias bqq='bq query --use_legacy_sql=false'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# GitHub CLI completion
if command -v gh >/dev/null 2>&1; then
  eval "$(gh completion -s zsh)"
fi

alias gha='gh auth status'
alias gpr='gh pr list'
alias gprv='gh pr view'
alias gprd='gh pr diff'
alias gprc='gh pr checkout'
alias grl='gh run list'
alias grv='gh run view'
alias grw='gh run watch'
