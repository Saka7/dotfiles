export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="laconic"

plugins=(
    z
    git
    docker
    docker-compose
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=~/.local/bin:$PATH

[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

