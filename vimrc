
set nocompatible
filetype off

call plug#begin()

Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'altercation/vim-colors-solarized'
Plug 'kien/ctrlp.vim'
" Plug 'valloric/youcompleteme'
Plug 'mattn/emmet-vim'
Plug 'tmhedberg/SimpylFold'
Plug 'jnurmine/Zenburn'
Plug 'Lokaltog/powerline'

call plug#end()

set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99
syntax on

set number

colorscheme solarized
set background=dark

let mapleader=","
nmap <leader>w :w<CR>
nmap <C-N> :NERDTreeToggle<CR>

" Enable folding with the spacebar
nnoremap <space> za

let g:SimpylFold_docstring_preview=1

set encoding=utf-8

filetype plugin indent on
