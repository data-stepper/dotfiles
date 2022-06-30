-- Take some basic keymaps from vimscript directly.
vim.g.mapleader = ","

vim.cmd [[
	" Using s is very convenient
	nmap <silent> s :SlimeSendCurrentLine<CR>j
	vmap <silent> s :SlimeSend<CR>

	map <C-t> :Telescope<CR>

	" Some more specific telescope mappings
	map <C-f> :Telescope find_files<CR> 
	map <C-b> :Telescope buffers<CR> 
	map <C-r> :Telescope oldfiles<CR>

	map <silent> <C-g> :Goyo<CR>
	nmap <silent> <C-N> :NvimTreeToggle<CR>
	map <C-P> :Copilot panel<CR>
	noremap <silent> <c-c> :Commentary<CR>
	nmap <leader>rn :Lspsaga rename<CR>

	nmap <leader>w :w!<CR>
	nnoremap <space> za
	tnoremap <C-X> clear<CR>
	tnoremap <C-Q> exit<CR>
	noremap <c-q> <c-w>c
	nnoremap U <C-R>

	" Control-d generates docstring for python function / class
	nmap <silent> <C-d> <Plug>(pydocstring)

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

	" Shows contents of registers and tag bar
	nnoremap <silent> <leader>1 :registers<CR>
	" Use the symbols outline plugin
	nnoremap <silent> <leader>2 :SymbolsOutline<CR>

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

	" Open new tabs and switch between buffers
	nnoremap <silent> <leader>n :tabnew<CR>
	nnoremap <silent> <leader>m :bnext<CR>
	nnoremap <silent> <leader>M :bNext<CR>

	" In normal mode escape removes search result highlighting
	nnoremap <silent> <Esc> gt:nohlsearch<CR>

	" Quit or close buffers
	nnoremap <leader>q <C-W>c
	nnoremap <silent> <leader>c :bw!<CR>

	" Shifting
	nnoremap <Tab> >>
	nnoremap <S-Tab> <<
	vnoremap <Tab> >gv
	vnoremap <S-Tab> <gv
]]
