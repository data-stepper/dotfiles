-- Take some basic keymaps from vimscript directly.

vim.cmd [[
nmap <silent> <F2> :%SlimeSend<CR>

" Only send a selection or current line
vmap <silent> <C-s> :SlimeSend<CR>
nmap <silent> <C-s> :SlimeSendCurrentLine<CR>j
nmap <silent> <F1> :SlimeSendCurrentLine<CR>j

" Using s is very convenient
nmap <silent> s :SlimeSendCurrentLine<CR>j
vmap <silent> s :SlimeSend<CR>
]]
