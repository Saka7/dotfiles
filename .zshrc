source ~/.scripts.sh
source ~/.variables.sh

ZSH_THEME="laconic"

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
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

ssh-agent -k > /dev/null

keychain --quiet ~/.ssh/bitbucket_id_rsa
keychain --quiet ~/.ssh/google_compute_engine
keychain --quiet ~/.ssh/github_id_rsa

source ~/.keychain/`uname -n`-sh

