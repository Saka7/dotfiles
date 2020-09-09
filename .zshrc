export ZSH=~/.oh-my-zsh

ZSH_THEME="laconic"

plugins=(
  z
  git
  docker
  docker-compose
)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH=~/.local/bin:$PATH
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
