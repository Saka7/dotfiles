export ZSH=/home/saka7/.oh-my-zsh

ZSH_THEME="laconic"

plugins=(
  curl
  ssh
  z
  zsh-syntax-highlighting
  git
  postgres
  npm
  docker
  kubectl
  vim-interaction
  kubectl
  httpie
  jhipster
)

# User configuration
source $ZSH/oh-my-zsh.sh

# Aliases
# Workspaces
alias wsp="cd /mnt/data/wsp/"
alias jwsp="cd /mnt/data/wsp/java"
alias jswsp="cd /mnt/data/wsp/js"
alias pwsp="cd /mnt/data/wsp/python"
alias bwsp="cd /mnt/data/wsp/bash"
alias lwsp="cd /mnt/data/wsp/latex"
alias twsp="cd /mnt/data/wsp/trash"
alias dwn="cd /mnt/data/dwn"
# Virtualization
alias vb="virtualbox"
alias vbs="vboxmanage startvm $1"
# Tools
alias ipy="/usr/local/bin/ipython --profile=saka"
alias py="/usr/bin/python"
# Other
alias chrom="/usr/bin/chromium-browser"
alias open="dolphin $1"
alias suspend="sudo pm-suspend"

export CHROME_BIN=/usr/bin/chromium-browser 
export EDITOR=vim
export PATH="/home/saka/.npm-global/bin:$PATH"
source /home/saka/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

