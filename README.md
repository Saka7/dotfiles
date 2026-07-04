# Dotfiles

Dotfiles for a Zsh, Vim/Neovim, Kitty, Vifm, and Tig workflow.

## Contents

- `.zshrc`, `.variables.sh`, `.scripts.sh` - Zsh environment, Oh My Zsh plugins, helper commands, and SSH agent setup through `keychain`.
- `.oh-my-zsh/themes/laconic.zsh-theme` - minimal two-line prompt with git status.
- `.config/nvim` - Lua Neovim config using `lazy.nvim`, VS Code colors, LSP, completion, Telescope, Treesitter, Git tools, DAP, Jest tests, folding, sessions, and Sidekick/Copilot CLI integration.
- `.vimrc` - fallback Vim config using vim-plug, fzf, NERDTree, GitGutter, Airline, and Undotree.
- `.config/kitty/kitty.conf` - Kitty terminal settings and VS Code-like color palette.
- `.config/vifm` - Vifm file manager config and colors.
- `.tigrc` - compact Tig layout preferences.

## Dependencies

Core tools expected by the configs:

- `zsh`, `oh-my-zsh`, `keychain`, `fzf`, `neovim`, `git`, `ripgrep`, `make`

Neovim bootstraps `lazy.nvim` on first start. Mason installs configured LSP servers for Lua, CSS, HTML, TypeScript, Python, Bash, JSON, YAML, and Copilot. Formatters such as `prettier`, `stylua`, `shfmt`, and `sql-formatter` should be installed separately if formatting is needed.
