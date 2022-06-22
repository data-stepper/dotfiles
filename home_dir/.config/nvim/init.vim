" This is what used to be called .vimrc
" And what will soon be gone when everyone moved to init.lua

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

" Better folding
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'ray-x/lsp_signature.nvim'
Plug 'SmiteshP/nvim-navic'

" Google keep integration, yeah
Plug 'stevearc/gkeep.nvim', { 'do': ':UpdateRemotePlugins' }

" Use the neovim builtin lsp client
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim' " For language server features
Plug 'onsails/lspkind.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-emoji'
Plug 'dmitmel/cmp-cmdline-history'
Plug 'tamago324/cmp-zsh'
Plug 'kdheepak/cmp-latex-symbols'
Plug 'lukas-reineke/cmp-rg'
" Plug 'hrsh7th/cmp-copilot' " Normal copilot is better
Plug 'hrsh7th/nvim-cmp'
Plug 'windwp/nvim-autopairs'

" For refactoring
Plug 'ThePrimeagen/refactoring.nvim'

" For math stuff in neovim
Plug 'jbyuki/nabla.nvim' 

" Use Neorg from now on, to organize stuff yeah
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-neorg/neorg' 

Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'SirVer/ultisnips'
	let g:UltiSnipsNoMap = 1
	let g:UltiSnipsExpandTrigger = "<NUL>"

" Code formatting for python
Plug 'mhartington/formatter.nvim'
" Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}
" 	let g:black#settings = {
" 		\ 'fast': 1,
" 		\ 'line_length': 89
" 	\}
" 		" \ 'experimental_string_processing': 1
" 	let g:python3_host_prog = $HOME . '/miniconda3/bin/python3'

" Crazy snippet library
" Plug 'honza/vim-snippets'

" Nicely indent the lines everywhere
Plug 'lukas-reineke/indent-blankline.nvim'

" Use nvim-treesitter 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'eddiebergman/nvim-treesitter-pyfold'
" Plug 'romgrk/nvim-treesitter-context' " Not so cool for solarized colors
Plug 'liuchengxu/vista.vim'
	let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Emojis in vim
" Plug 'junegunn/vim-emoji'

" Switch to nvim-tree, a lua file tree version
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Use devicons because it looks more beautiful
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Plug 'tmhedberg/SimpylFold'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" Now using telescope
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-neorg/neorg-telescope'
Plug 'max397574/neorg-kanban'

Plug 'yegappan/mru'
Plug 'junegunn/goyo.vim'
	" Use a little wider than the default (80)
	let g:goyo_width = 90

Plug 'junegunn/limelight.vim'
	" Always use limelight when using goyo
	autocmd! User GoyoEnter Limelight
	autocmd! User GoyoLeave Limelight!

" Use github copilot, yeah
Plug 'github/copilot.vim'
	" Enable copilot by default for all filetypes
	let g:copilot_filetypes = {
		\ '*': v:true,
	\ }

" This plugin lets me move inside python code more easily
Plug 'jeetsukumaran/vim-pythonsense'

" Use vim-slime for interactive development
Plug 'jpalardy/vim-slime'
	" Use the neovim terminal feature
	let g:slime_target = "neovim"

	" For python always use ipython
	" Don't use ipython anymore since it uses way to much ram
	" use bpython or python3 interactive directly
	" let g:slime_python_ipython = 1

	" Remove the standard mappings created by vim-slime
	let g:slime_no_mappings = 1

" My own ai assist plugin
Plug 'data-stepper/ai-text-assist'

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
" Plug 'altercation/vim-colors-solarized'
" Plug 'rafi/awesome-vim-colorschemes'
" From now on only use neovim compatible colorschemes
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'EdenEast/nightfox.nvim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'overcache/NeoSolarized'
Plug 'savq/melange'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" For markdown editing
" Found it not so useful after all
" Plug 'ellisonleao/glow.nvim'

" Only use for python editing
" Plug 'majutsushi/tagbar'
" Plug 'universal-ctags/ctags'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Switched to alternatives written in lua
" Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'CocUpdate'}
" 	" Maybe think about switching from coc-jedi to
" 	" https://github.com/pappasam/jedi-language-server
" 	" as it seems to be better supported
" 	let g:coc_global_extensions = [
" 		\'coc-sh',
" 		\'coc-pyright',
" 		\'coc-jedi',
" 		\'coc-tabnine',
" 		\'coc-json',
" 		\'coc-texlab',
" 		\'coc-markdownlint',
" 		\'coc-yaml',
" 		\'coc-snippets'
" 	\]

" Shows buffers and tabs opened
" Plug 'bling/vim-bufferline'
" Plug 'mkitt/tabline.vim'
" The new bufferline written in lua
" Plug 'akinsho/bufferline.nvim'
" One can do also the bufferline with lualine
Plug 'nvim-lualine/lualine.nvim'

call plug#end()

" For nvim-cmp
set completeopt=menu,menuone,noselect

" New split open below / to the right
set splitbelow
set splitright

" Below is the configuration of vim-slime, one of the best tools ever built!
" Use vim-slime because it works best with all kinds of REPLs

" Send the entire buffer
" nmap <silent> <C-r> :%SlimeSend<CR>
nmap <silent> <F2> :%SlimeSend<CR>

" Only send a selection or current line
vmap <silent> <C-s> :SlimeSend<CR>
nmap <silent> <C-s> :SlimeSendCurrentLine<CR>j
nmap <silent> <F1> :SlimeSendCurrentLine<CR>j

" Using s is very convenient
nmap <silent> s :SlimeSendCurrentLine<CR>j
vmap <silent> s :SlimeSend<CR>

" Below code is copied from coc-snippets

" Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)

" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)

" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'

" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'

" " Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

" Neovim telescope setup
map <leader>t :Telescope<CR>
map <C-t> :Telescope<CR>
map <F3> :Telescope<CR>

" Some more specific telescope mappings
map <C-f> :Telescope find_files<CR> 
map <C-b> :Telescope buffers<CR> 
map <C-r> :Telescope oldfiles<CR>

" Enable folding with treesitter now
" set foldmethod=expr
" set foldexpr=nvim_treesitter#fold_expr()

" Start at lowest fold level always
" set foldlevel=0

set noswapfile

" Map leader key to ','
let mapleader=","
nmap <leader>w :w!<CR>

" Launch action menu with leader + a
" nmap <silent> <leader>a :CocAction<CR>

" Also enable in visual mode
" vmap <silent> <leader>a :CocAction<CR>

" File browser and most recently used files
" nmap <silent> <C-N> :NERDTreeToggle<CR>
" Switched to nvim-tree because it's written in lua
nmap <silent> <C-N> :NvimTreeToggle<CR>
nmap <silent> <C-M> :MRU<CR>

" Fuzzy search with ctr-p
map <C-P> :FZF<CR>

" Line numbering turned off for now
" set number
" set relativenumber
" set numberwidth=1

" For cleaner python programming and more readability
set colorcolumn=81

" Switch to absolute line numbering in insert mode (and back)
" autocmd!
" autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
" autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber

" This way the terminal displays the colors correctly
set termguicolors

" Set default colorscheme and dark background
set background=light
colorscheme NeoSolarized
" colorscheme melange

map <silent> <leader>g :Goyo<CR>
map <silent> <C-g> :Goyo<CR>

" Enable folding with the space bar
nnoremap <space> za

" Unicode encoding for everything
set encoding=utf-8

" No idea what the below is about huh
" airline Settings
set laststatus=2                             " for airline

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
" In a terminal split we don't want to have relative numbers
noremap <silent> <leader>vt :vsplit<CR>:terminal<CR>:set nonumber<CR>
noremap <silent> <leader>st :split<CR>:terminal<CR>:set nonumber<CR>

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
" nnoremap <silent> <leader>2 :TagbarToggle<CR>
" Use the vista plugin because it's written in lua
nnoremap <silent> <leader>2 :Vista<CR>

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
" nnoremap <c-u> :source ~/.config/nvim/init.vim<CR> :CocRestart<CR>
" Not using coc anymore
nnoremap <c-u> :source ~/.config/nvim/init.vim<CR>

" Open new tabs and switch between buffers
nnoremap <silent> <leader>n :tabnew<CR>
nnoremap <silent> <leader>m :bnext<CR>
nnoremap <silent> <leader>M :bNext<CR>

" In normal mode escape removes search result highlighting
nnoremap <silent> <Esc> gt:nohlsearch<CR>

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
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" nnoremap <silent> K :Lspsaga hover_doc<CR>

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
" set cul

" Coc settings
set hidden

set nobackup
set nowritebackup

" set cmdheight=2

" Vim backend updates faster for better responsiveness
" set updatetime=300

set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif

" Control-d generates docstring for python function / class
nmap <silent> <C-d> <Plug>(pydocstring)

" Cycle through completions with tab
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

" Cycle backwards with shit-tab
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" have control space confirm a suggestion
" inoremap <C-space> <C-y>
" inoremap <silent><expr> <C-space> coc#refresh()

" Set python docstyle for linting and docstring generation
" Always use numpy docstyle as it is the best
let g:ultisnips_python_style = 'numpy'
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
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rn :Lspsaga rename<CR>

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Coc statusline setup
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Cursor never gets closer than n lines to the top / bottom of the split
set scrolloff=10

" Activate syntax highlighting
syntax on

" Different options for fonts
" Old gvim font setting
" set guifont=Fira\ Code\ 9

" Powerline fonts
set guioptions=
" let g:airline_powerline_fonts = 1

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


" The lua part of my config
" Because I don't want to maintain a separate lua file

lua require('config')

