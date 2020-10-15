
set nocompatible
filetype off

call plug#begin()

" Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
" Plug 'mattn/emmet-vim' " Only needed for html editing
Plug 'tpope/vim-commentary'
" Plug 'scrooloose/syntastic'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Only use for python editing
Plug 'majutsushi/tagbar'
Plug 'universal-ctags/ctags'
Plug 'psf/black'
" Plug 'tmhedberg/SimpylFold' 
Plug 'jnurmine/Zenburn'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'klen/python-mode'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bling/vim-bufferline'
Plug 'mkitt/tabline.vim'
Plug 'tomasr/molokai'

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

set encoding=utf-8

" airline Settings
set laststatus=2                             " for airline

" vim-airline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 1

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

nnoremap <leader>1 :registers<CR>
nnoremap <leader>2 :TagbarToggle<CR>

" Git commands
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>ga :G add *<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gf :Git fetch<CR>

noremap <Down> <C-W>-
noremap <Up> <C-W>+
noremap <Left> <C-W>>
noremap <Right> <C-W><

nnoremap <leader>n :tabnew<CR>
nnoremap <leader>m :bnext<CR>
nnoremap <leader>M :bNext<CR>

nnoremap <leader>q <C-W>c
nnoremap <leader>c :bw<CR>

nnoremap <leader>e :e 
nnoremap <leader>E :tabe 

cnoreabbrev H vert h
cnoreabbrev E vert e

nnoremap J 5j
nnoremap K 5k
nnoremap H 3h
nnoremap L 3l

vnoremap J 5j
vnoremap K 5k
vnoremap H 3h
vnoremap L 3l

" Visual mode movement commands
nnoremap º :m .+1<CR>==
nnoremap ∆ :m .-2<CR>==
nnoremap @ >>
nnoremap ª <<
vnoremap º :m '>+1<CR>gv=gv
vnoremap ∆ :m '<-2<CR>gv=gv
vnoremap @ >gv
vnoremap ª <gv

nmap U <C-R>

set cul

map <C-P> :FZF<CR>

" Coc settings
set hidden

set nobackup
set nowritebackup

set cmdheight=2

set updatetime=300

set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" set guifont=Hack:h22
" set guifont=Source\ Code\ Pro:h21
set guifont=Fira\ Code:h15
" set guifont=Consolas:h18
set guioptions=
let g:airline_powerline_fonts = 1
