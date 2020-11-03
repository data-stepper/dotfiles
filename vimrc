set nocompatible
filetype off

call plug#begin()

" Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yegappan/mru'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/goyo.vim'
" Plug 'ryanoasis/vim-devicons'

Plug 'rafi/awesome-vim-colorschemes'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Only use for python editing
Plug 'majutsushi/tagbar'
Plug 'universal-ctags/ctags'
Plug 'psf/black'
Plug 'jnurmine/Zenburn'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bling/vim-bufferline'
Plug 'mkitt/tabline.vim'
" Plug 'tomasr/molokai'
" Plug 'turbio/bracey.vim' " connection refused error on macos

call plug#end()

set splitbelow
set splitright

" Enable folding
" set foldmethod=indent
" set foldlevel=99

set noswapfile
set foldmethod=marker
set foldmarker=STARTFOLD,ENDFOLD
set foldlevel=0
syntax on

" Set fold abbreviation for different languages:
" Also add custom surround with fold Shift-s + f
" in visual mode

function! FoldPython()
  inoremap <buffer> fold # STARTFOLD #####<CR><CR># ENDFOLD
  let b:surround_98 = "# STARTFOLD ##### \r # ENDFOLD"

  " When in python mode
  " Executes selection in python3 interpreter
  vnoremap <buffer> <leader>r :'<,'>write ! python3<CR>

endfunction

function! FoldJavascript()
  inoremap <buffer> fold // STARTFOLD #####<CR><CR>ENDFOLD
endfunction

function! FoldHTML()
  inoremap <buffer> fold <!-- STARTFOLD ##### SECTION --><CR><CR><!-- ENDFOLD -->
  let b:surround_98 = "<!-- STARTFOLD ##### SECTION -->\r<!-- ENDFOLD -->"

  " stuff for django devlopment
  inoremap <buffer> block {% block BLOCKNAME %}<CR><CR>{% endblock %}
  inoremap <buffer> {<Space> { }<left>
  inoremap <buffer> {{<Space> {{ }}<left><left>
  inoremap <buffer> {%<Space> {% %}<left><left>
endfunction

au BufNewFile,BufRead *.py :call FoldPython()
au BufNewFile,BufRead *.js :call FoldJavascript()
au BufNewFile,BufRead *.html :call FoldHTML()

colorscheme nord
set background=dark

" When using nord, I want folded to not differ from background color
" This function reloads colors because Goyo changes that unwillingly.
function! ReloadColors()
  hi Folded guibg=#2f343f
endfunction

call ReloadColors()
command Redraw call ReloadColors()
set number
set relativenumber

let mapleader=","
nmap <leader>w :w<CR>
nmap <silent> <C-N> :NERDTreeToggle<CR>
nmap <silent> <C-M> :MRU<CR>

" Map Goyo toggle
map <silent> <leader>g :Goyo<CR>:Redraw<CR>

" Using sneak plugin
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

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

" Old splitting behaviour, deprecated
" noremap <silent> <leader>t :vert ter<CR>
" noremap <leader>v <C-W>v
" noremap <leader>s <C-W>s

" Split with content of current buffer
noremap <silent> <leader>vs :vs<CR>
noremap <silent> <leader>ss :split<CR>

" Split a new shell
noremap <silent> <leader>vt :vert ter<CR>
noremap <silent> <leader>st :ter<CR>

" Split a new buffer
nnoremap <silent> <leader>vn :vnew<CR>
nnoremap <silent> <leader>sn :new<CR>

" The following adds notepad-like behavior:

" In visual mode split new buffer and put selection inside
vnoremap <silent> <leader>vn :yank<CR>:vnew<CR>:put<CR><C-w>h
vnoremap <silent> <leader>sn :yank<CR>:new<CR>:put<CR><C-w>k

" Put selection directly after cursor in corresponding buffer
vnoremap <silent> <leader>h :yank<CR><C-W>h:put<CR><C-w>l
vnoremap <silent> <leader>j :yank<CR><C-W>j:put<CR><C-w>k
vnoremap <silent> <leader>k :yank<CR><C-W>k:put<CR><C-w>j
vnoremap <silent> <leader>l :yank<CR><C-W>l:put<CR><C-w>h

" Just put in previous buffer
vnoremap <silent> <leader>p :yank<CR><C-W>w:put<CR><C-w>w

" Split for help
noremap <leader>vh :vert h 
noremap <leader>sh :h 

" Split and edit directly
noremap <leader>ve :vsplit 
noremap <leader>se :split 

tnoremap <C-X> clear<CR>
tnoremap <C-Q> exit<CR>
noremap <C-Q> <C-W>c

nnoremap <silent> <leader>1 :registers<CR>
nnoremap <silent> <leader>2 :TagbarToggle<CR>

" Git commands
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>ga :G add *<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gf :Git fetch<CR>

noremap <Down> <C-W>-
noremap <Up> <C-W>+
noremap <Left> <C-W>>
noremap <Right> <C-W><

nnoremap <silent> <leader>n :tabnew<CR>
nnoremap <silent> <leader>m :bnext<CR>
nnoremap <silent> <leader>M :bNext<CR>
nnoremap <Esc> gt

nnoremap <leader>q <C-W>c
nnoremap <silent> <leader>c :bw<CR>

nnoremap <leader>e :e 
nnoremap <leader>E :tabe 

cnoreabbrev H vert h
cnoreabbrev E vert e

nnoremap J 5j
nnoremap K 5k
nnoremap H 4h
nnoremap L 4l

vnoremap J 5j
vnoremap K 5k
vnoremap H 4h
vnoremap L 4l

" Comment stuff out
noremap <silent> ç :Commentary<CR>

" Visual mode movement commands
nnoremap <silent> º :m .+1<CR>==
nnoremap <silent> ∆ :m .-2<CR>==
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <silent> º :m '>+1<CR>gv=gv
vnoremap <silent> ∆ :m '<-2<CR>gv=gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Tabs should be 4 spaces always.
set tabstop=4
set shiftwidth=4
set showmatch

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

" have control space confirm a suggestion
inoremap <C-space> <C-y>
" inoremap <silent><expr> <C-space> coc#refresh()

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

set macligatures
" set guifont=Hack:h16
" set guifont=Source\ Code\ Pro:h16
set guifont=Fira\ Code:h15
" set guifont=IBM\ Plex\ Mono:h15
" set guifont=Consolas:h18
set guioptions=
let g:airline_powerline_fonts = 1

