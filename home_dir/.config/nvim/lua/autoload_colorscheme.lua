-- Save and load last used colorscheme from a file
-- vim.g.colorscheme_state_file_path = "~/.colorscheme_state.json"
-- vim.g.colorscheme_state_file_path = vim.fn.expand(vim.g.colorscheme_state_file_path)
-- When neovim starts, check if the file exists
-- local json = require("json")
-- local load_state = function()
--   if vim.fn.exists(vim.g.colorscheme_state_file_path) then
--     local file = io.open(vim.g.colorscheme_state_file_path, "r")
--     local state = json.decode(file:read("*a"))
--     file:close()
--     vim.cmd("colorscheme " .. state.colorscheme)
--   end
-- end
--
-- Let's see if I still need this plugin later