syntax on
filetype plugin indent on

set number
set nopaste
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
set lazyredraw
set cursorline
set incsearch
set autoindent
set scrolloff=5
set sidescrolloff=5
set splitbelow
set splitright
set wildmenu
set showmatch

colorscheme habamax

let mapleader = " "
vnoremap <leader>y :w !xclip -sel c<CR><CR>
inoremap jj <Esc>
nnoremap <leader>e :Lexplore<CR>
nnoremap <leader>b :buffers<CR>
nnoremap <leader>c :bd<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>


let g:netrw_winsize = 25

