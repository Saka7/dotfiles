source ~/.variables.sh
source ~/.scripts.sh

plugins=(
	z
	git
	docker
    gcloud
	docker-compose
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ssh_agent_start

