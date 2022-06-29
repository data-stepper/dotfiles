require("plugins")
require("config")
require("file-tree")
require("code-formatting")
require("neorg-config")
require("lualine-config")

-- Set all the globals stuff here now
vim.g.pydocstring_enable_mapping = 0
vim.g.UltiSnipsNoMap = 1
vim.g.UltiSnipsExpandTrigger = "<NUL>"
vim.g.goyo_width = 100
vim.g.slime_target = "neovim"
vim.g.slime_no_mappings = 1
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0
