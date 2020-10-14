
set nocompatible
filetype off

call plug#begin()

Plug 'tpope/vim-surround'
" Plug 'christoomey/vim-tmux-navigator'
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

colorscheme solarized
set background=dark
set number

let mapleader=","
nmap <leader>w :w<CR>
nmap <C-N> :NERDTreeToggle<CR>

" Enable folding with the spacebar
nnoremap <space> za

let g:SimpylFold_docstring_preview=1

set encoding=utf-8

filetype plugin indent on

noremap <C-h> <C-\><C-n><C-w>h
noremap <C-j> <C-\><C-n><C-w>j
noremap <C-k> <C-\><C-n><C-w>k
noremap <C-l> <C-\><C-n><C-w>l

tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
