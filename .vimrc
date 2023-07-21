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

call plug#begin('~/.vim/plugged')
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jremmen/vim-ripgrep'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
call plug#end()

colorscheme codedark

set timeoutlen=300
imap jj <Esc>
map <C-S-c> :w !xclip -sel c <CR><CR>
nnoremap <Space>f :Files <CR>
nnoremap <Space>e :NERDTreeToggle <CR>
nnoremap <Space>u :UndotreeToggle <CR>

let g:airline_theme='raven'
let g:gitgutter_async=0

