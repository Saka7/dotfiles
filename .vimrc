syntax on
filetype plugin indent on

set number
set paste
set tabstop=4 softtabstop=4
set shiftwidth=4
set noswapfile
set smartindent
set colorcolumn=120
set noerrorbells
set expandtab
set nowrap
set incsearch
set mouse=a

map <C-S-c> :w !xclip -sel c <CR><CR>
imap jj <Esc>
set timeoutlen=300

call plug#begin('~/.vim/plugged')
Plug 'doums/darcula'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
call plug#end()


colorscheme darcula

let g:airline_theme='raven'
let g:gitgutter_async=0

