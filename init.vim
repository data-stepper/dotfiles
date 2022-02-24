set nocompatible
filetype off

call plug#begin()
" Rainbow parentheses, yeah
Plug 'luochen1990/rainbow'
	let g:rainbow_active = 1

Plug 'tpope/vim-surround'
	" Custom surround with space for editing latex
	let g:surround_115 = "\\; \r \\;"

Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
	" Don't use default mapping for pydocstring shortcut
	let g:pydocstring_enable_mapping = 0

" Use devicons because it looks more beautiful
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tmhedberg/SimpylFold'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yegappan/mru'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/goyo.vim'

" My own ai assist plugin
Plug 'data-stepper/ai-text-assist'

" Devicons plugin somehow doesn't work
" Plug 'ryanoasis/vim-devicons'

" Vim and latex combination
Plug 'lervag/vimtex'
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0

" Text concealment
Plug 'KeitaNakamura/tex-conceal.vim'
	set conceallevel=1
	let g:tex_conceal='abdmg'
	hi Conceal ctermbg=none

" Loads of color schemes here
Plug 'altercation/vim-colors-solarized'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Only use for python editing
Plug 'majutsushi/tagbar'
Plug 'universal-ctags/ctags'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Shows buffers and tabs opened
Plug 'bling/vim-bufferline'
Plug 'mkitt/tabline.vim'

call plug#end()

" New split open below / to the right
set splitbelow
set splitright

" Below code is copied from coc-snippets

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Enable folding
set foldmethod=expr

" Start at lowest fold level always
set foldlevel=0

set noswapfile

" Map leader key to ','
let mapleader=","
nmap <leader>w :w<CR>

" File browser and most recently used files
nmap <silent> <C-N> :NERDTreeToggle<CR>
nmap <silent> <C-M> :MRU<CR>

" Fuzzy search with ctr-p
map <C-P> :FZF<CR>

" Line numbering
set number
set relativenumber
set numberwidth=1

" For cleaner python programming and more readability
set colorcolumn=81

" Switch to absolute line numbering in insert mode (and back)
autocmd!
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber

" This way the terminal displays the colors correctly
set termguicolors

" Set default colorscheme and dark background
" colorscheme one
set background=dark

" Better colorscheme for latex
colorscheme onehalfdark
" colorscheme flattened_dark

" Below is only needed when using nord colorscheme and goyo plugin
" When using nord, I want folded to not differ from background color
" This function reloads colors because Goyo changes that unwillingly.
" function! ReloadColors()
"   hi Folded guibg=#2f343f
" endfunction

" call ReloadColors()
" command Redraw call ReloadColors()
" Map Goyo toggle
" map <silent> <leader>g :Goyo<CR>:Redraw<CR>

map <silent> <leader>g :Goyo<CR>

" Using sneak plugin
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Enable folding with the space bar
nnoremap <space> za

" Unicode encoding for everything
set encoding=utf-8

" No idea what the below is about huh
" airline Settings
set laststatus=2                             " for airline

" vim-airline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 1

filetype plugin indent on

" Move between splits with ctrl-[ h j k l ]
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" In terminals Esc enters normal mode
tnoremap <Esc> <C-\><C-n>

" Make sure split movement works in terminals as well
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k

" One can also comment this out if clearing terminal with ctr-L is wanted
tnoremap <C-l> <C-w>l

" Split with content of current buffer
noremap <silent> <leader>vs :vs<CR>
noremap <silent> <leader>ss :split<CR>

" Split a new terminal
noremap <silent> <leader>vt :vert ter<CR>
noremap <silent> <leader>st :ter<CR>

" Split a new empty buffer
nnoremap <silent> <leader>vn :vnew<CR>
nnoremap <silent> <leader>sn :new<CR>

" The following adds notepad-like behavior:

" In visual mode split new buffer and put selection inside
vnoremap <silent> <leader>vn :yank<CR>:vnew<CR>:put<CR><C-w>h
vnoremap <silent> <leader>sn :yank<CR>:new<CR>:put<CR><C-w>k

" Put selection directly after cursor in corresponding buffer and jump back
vnoremap <silent> <leader>h :yank<CR><C-W>h:put<CR><C-w>l
vnoremap <silent> <leader>j :yank<CR><C-W>j:put<CR><C-w>k
vnoremap <silent> <leader>k :yank<CR><C-W>k:put<CR><C-w>j
vnoremap <silent> <leader>l :yank<CR><C-W>l:put<CR><C-w>h

" Just put in previous buffer
vnoremap <silent> <leader>p :yank<CR><C-W>w:put<CR><C-w>w

" Split for help ( never used )
noremap <leader>vh :vert h 
noremap <leader>sh :h 

" Split and edit directly
noremap <leader>ve :vsplit 
noremap <leader>se :split 

" Exiting and quitting buffers or terminals
tnoremap <C-X> clear<CR>
tnoremap <C-Q> exit<CR>
noremap <c-q> <c-w>c

" Shows contents of registers and tag bar
nnoremap <silent> <leader>1 :registers<CR>
nnoremap <silent> <leader>2 :TagbarToggle<CR>

" Git commands
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>ga :G add *<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gf :Git fetch<CR>

" Arrow keys resize splits
noremap <Down> <C-W>-
noremap <Up> <C-W>+
noremap <Left> <C-W>>
noremap <Right> <C-W><

" Reload vimrc in instance
nnoremap <c-u> :source ~/.config/nvim/init.vim<CR> :CocRestart<CR>

" Open new tabs and switch between buffers
nnoremap <silent> <leader>n :tabnew<CR>
nnoremap <silent> <leader>m :bnext<CR>
nnoremap <silent> <leader>M :bNext<CR>
nnoremap <Esc> gt

" Quit or close buffers
nnoremap <leader>q <C-W>c
nnoremap <silent> <leader>c :bw!<CR>

" Edit a file
nnoremap <leader>e :e 
nnoremap <leader>E :tabe 

" Abbreviations when using the Ex-console
cnoreabbrev H vert h
cnoreabbrev E vert e

" Show documentation provided by language server
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Move faster with shift-hjkl (except K because it shows docs)
nnoremap J 5j
" nnoremap K 5k
nnoremap H 4h
nnoremap L 4l

" Also in visual mode
vnoremap J 5j
vnoremap K 5k
vnoremap H 4h
vnoremap L 4l

" Comment stuff out
noremap <silent> <c-c> :Commentary<CR>

" Visual mode movement commands
" These rely on what is interpreted as Alt-hjkl by system
nnoremap <silent> º :m .+1<CR>==
nnoremap <silent> ∆ :m .-2<CR>==
vnoremap <silent> º :m '>+1<CR>gv=gv
vnoremap <silent> ∆ :m '<-2<CR>gv=gv

" Tab / Untab selection or a single line
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Tabs should be 4 spaces always.
" Tabs are always better than spaces, no discussion !!!
set tabstop=4
set shiftwidth=4
set showmatch

" U redos, instead of C-R
nmap U <C-R>

" Highlight current line
set cul

" Coc settings
set hidden

set nobackup
set nowritebackup

set cmdheight=2

" Vim backend updates faster for better responsiveness
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

" Control-d generates docstring for python function / class
nmap <silent> <C-d> <Plug>(pydocstring)

" Cycle through completions with tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Cycle backwards with shit-tab
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" have control space confirm a suggestion
inoremap <C-space> <C-y>
" inoremap <silent><expr> <C-space> coc#refresh()

" Set python docstyle for linting and docstring generation
" Always use numpy docstyle as it is the best
let g:ultisnips_python_style = "numpy"
let g:pydocstring_formatter = 'numpy'

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

" Coc statusline setup
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Cursor never gets closer than n lines to the top / bottom of the split
set scrolloff=10

" Activate syntax highlightin
syntax on

" Different options for fonts
" Old gvim font setting
" set guifont=Fira\ Code\ 9

" Powerline fonts
set guioptions=
let g:airline_powerline_fonts = 1

" Closetag plugin
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb,*.js'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" Spelling correction for German and English
setlocal spell
set spelllang=en,de

" When in insert mode, ctr-L corrects spelling mistakes on the current line
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

