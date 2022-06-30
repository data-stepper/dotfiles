" This is what used to be called .vimrc
" And what will soon be gone when everyone moved to init.lua

" set nocompatible
" filetype off

" Map leader key to ','
" let mapleader=","
" nmap <leader>w :w!<CR>

" For nvim-cmp
set completeopt=menu,menuone,noselect

" New split open below / to the right
set splitbelow
set splitright

set noswapfile

" This way the terminal displays the colors correctly
set termguicolors

" Set default colorscheme and dark background
set background=light
colorscheme NeoSolarized
" colorscheme melange

" Unicode encoding for everything
set encoding=utf-8

filetype plugin indent on

" Tabs should be 2 spaces always.
set tabstop=2
set shiftwidth=2

set showmatch
set hidden
set nobackup
set nowritebackup

set shortmess+=c

" Set python docstyle for linting and docstring generation
" Always use numpy docstyle as it is the best
" let g:ultisnips_python_style = 'numpy'
" let g:pydocstring_formatter = 'numpy'

" Cursor never gets closer than n lines to the top / bottom of the split
" set scrolloff=10

" Activate syntax highlighting
syntax on

" Powerline fonts
set guioptions=

" Closetag plugin
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.is"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb,*.js'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" Spelling correction for German and English
setlocal spell
set spelllang=en,de

" When in insert mode, ctr-L corrects spelling mistakes on the current line
" inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Load the plugins and lua stuff here
lua require('main')
