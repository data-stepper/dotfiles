-- Vim slime keymappings
-- nmap <silent> <F2> :%SlimeSend<CR>
vim.keymap.set("n", "<F2>", ":SlimeSend<CR>", {noremap = true, silent = true})

-- nmap <silent> s :SlimeSendCurrentLine<CR>j
vim.keymap.set("n", "s", ":SlimeSendCurrentLine<CR>j", {noremap = true, silent = true})

-- vmap <silent> s :SlimeSend<CR>
vim.keymap.set("v", "s", ":SlimeSend<CR>j", {noremap = true, silent = true})

-- Telescope keymappings
-- map <C-t> :Telescope<CR>
vim.keymap.set("n", "<C-t>", ":Telescope<CR>", {noremap = true})

-- map <F3> :Telescope<CR>
vim.keymap.set("n", "<F3>", ":Telescope<CR>", {noremap = true})

-- map <C-f> :Telescope find_files<CR>
vim.keymap.set("n", "<C-f>", ":Telescope find_files<CR>", {noremap = true})

-- map <C-b> :Telescope buffers<CR>
vim.keymap.set("n", "<C-b>", ":Telescope buffers<CR>", {noremap = true})

-- map <C-r> :Telescope oldfiles<CR>
vim.keymap.set("n", "<C-r>", ":Telescope oldfiles<CR>", {noremap = true})

-- Some general keymappings
-- nmap <leader>w :w!<CR>
vim.keymap.set("n", "<leader>w", ":w!<CR>", {noremap = true})

-- nmap <silent> <C-N> :NvimTreeToggle<CR>
vim.keymap.set("n", "<C-N>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})

-- map <C-P> :Copilot panel<CR>
vim.keymap.set("n", "<C-P>", ":Copilot panel<CR>", {noremap = true})

-- nnoremap <space> za
vim.keymap.set("n", " ", "za", {noremap = true, silent = true})

-- map <silent> <leader>g :Goyo<CR>
vim.keymap.set("n", "<leader>g", ":Goyo<CR>", {noremap = true, silent = true})

-- map <silent> <C-g> :Goyo<CR>
vim.keymap.set("n", "<C-g>", ":Goyo<CR>", {noremap = true, silent = true})

-- noremap <C-h> <C-w>h
-- noremap <C-j> <C-w>j
-- noremap <C-k> <C-w>k
-- noremap <C-l> <C-w>l

-- " In terminals Esc enters normal mode
-- tnoremap <Esc> <C-\><C-n>

-- " Make sure split movement works in terminals as well
-- tnoremap <C-h> <C-w>h
-- tnoremap <C-j> <C-w>j
-- tnoremap <C-k> <C-w>k

-- " One can also comment this out if clearing terminal with ctr-L is wanted
-- tnoremap <C-l> <C-w>l

-- " Split with content of current buffer
-- noremap <silent> <leader>vs :vs<CR>
-- noremap <silent> <leader>ss :split<CR>

-- " Split a new terminal
-- " In a terminal split we don't want to have relative numbers
-- noremap <silent> <leader>vt :vsplit<CR>:terminal<CR>:set nonumber<CR>
-- noremap <silent> <leader>st :split<CR>:terminal<CR>:set nonumber<CR>

-- " Split a new empty buffer
-- nnoremap <silent> <leader>vn :vnew<CR>
-- nnoremap <silent> <leader>sn :new<CR>

-- " The following adds notepad-like behavior:

-- " In visual mode split new buffer and put selection inside
-- vnoremap <silent> <leader>vn :yank<CR>:vnew<CR>:put<CR><C-w>h
-- vnoremap <silent> <leader>sn :yank<CR>:new<CR>:put<CR><C-w>k

-- " Put selection directly after cursor in corresponding buffer and jump back
-- vnoremap <silent> <leader>h :yank<CR><C-W>h:put<CR><C-w>l
-- vnoremap <silent> <leader>j :yank<CR><C-W>j:put<CR><C-w>k
-- vnoremap <silent> <leader>k :yank<CR><C-W>k:put<CR><C-w>j
-- vnoremap <silent> <leader>l :yank<CR><C-W>l:put<CR><C-w>h

-- " Just put in previous buffer
-- vnoremap <silent> <leader>p :yank<CR><C-W>w:put<CR><C-w>w

-- " Split for help ( never used )
-- noremap <leader>vh :vert h
-- noremap <leader>sh :h

-- " Split and edit directly
-- noremap <leader>ve :vsplit
-- noremap <leader>se :split

-- " Exiting and quitting buffers or terminals
-- tnoremap <C-X> clear<CR>
-- tnoremap <C-Q> exit<CR>
-- noremap <c-q> <c-w>c

-- " Shows contents of registers and tag bar
-- nnoremap <silent> <leader>1 :registers<CR>
-- " Use the symbols outline plugin
-- nnoremap <silent> <leader>2 :SymbolsOutline<CR>

-- " Git commands
-- nnoremap <silent> <leader>gs :Git<CR>
-- nnoremap <silent> <leader>gl :Glog<CR>
-- nnoremap <silent> <leader>ga :G add *<CR>
-- nnoremap <silent> <leader>gc :Gcommit<CR>
-- nnoremap <silent> <leader>gp :Git push<CR>
-- nnoremap <silent> <leader>gf :Git fetch<CR>

-- " Arrow keys resize splits
-- noremap <Down> <C-W>-
-- noremap <Up> <C-W>+
-- noremap <Left> <C-W>>
-- noremap <Right> <C-W><
