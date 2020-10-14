
set nocompatible
filetype off

call plug#begin()

Plug 'tpope/vim-surround'
" Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/syntastic'
Plug 'altercation/vim-colors-solarized'
Plug 'kien/ctrlp.vim'
" Plug 'mattn/emmet-vim' " Only needed for html editing

" Only use for python editing
Plug 'majutsushi/tagbar'
Plug 'universal-ctags/ctags'
Plug 'psf/black'
Plug 'tmhedberg/SimpylFold' 
Plug 'jnurmine/Zenburn'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'mkitt/tabline.vim'
Plug 'tomasr/molokai'
Plug 'klen/python-mode'
Plug 'valloric/youcompleteme'

call plug#end()

" set splitbelow
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

" airline Settings
set laststatus=2                             " for airline

" vim-airline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_powerline_fonts = 1

filetype plugin indent on

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l

noremap <leader>t :vert ter<CR>
noremap <leader>v <C-W>v
noremap <leader>s <C-W>s

tnoremap <C-X> clear<CR>
tnoremap <C-Q> exit<CR>
noremap <C-Q> <C-W>c
noremap <C-R> :registers<CR>

noremap <Down> <C-W>-
noremap <Up> <C-W>+
noremap <Left> <C-W>>
noremap <Right> <C-W><

noremap <leader>1 :1buffer<CR>
noremap <leader>2 :2buffer<CR>
noremap <leader>3 :3buffer<CR>
noremap <leader>4 :4buffer<CR>

nnoremap <leader>n :tabnew<CR>
nnoremap <leader>N :bNext<CR>

noremap <F8> :TagbarToggle<CR>

nnoremap <leader>b :buffers<CR>
noremap <leader>c <C-W>c
noremap <leader>q :q!<CR>

cnoreabbrev H vert h

" set guifont=Hack:h22
" set guifont=Source\ Code\ Pro:h21
set guifont=Fira\ Code:h21
