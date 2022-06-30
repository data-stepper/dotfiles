-- Take some basic keymaps from vimscript directly.

vim.cmd [[
" Using s is very convenient
nmap <silent> s :SlimeSendCurrentLine<CR>j
vmap <silent> s :SlimeSend<CR>

map <C-t> :Telescope<CR>

" Some more specific telescope mappings
map <C-f> :Telescope find_files<CR> 
map <C-b> :Telescope buffers<CR> 
map <C-r> :Telescope oldfiles<CR>

nmap <leader>w :w!<CR>
nnoremap <space> za

map <silent> <C-g> :Goyo<CR>
nmap <silent> <C-N> :NvimTreeToggle<CR>
map <C-P> :Copilot panel<CR>
]]

-- Movements inside vim splits
vim.cmd [[
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
]]
