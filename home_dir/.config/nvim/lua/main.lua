-- Set all the globals stuff here now
vim.g.mapleader = ","
vim.g.pydocstring_enable_mapping = 0
vim.g.UltiSnipsNoMap = 1
vim.g.UltiSnipsExpandTrigger = "<NUL>"
vim.g.goyo_width = 100

-- Vim slime settings
vim.g.slime_target = "neovim"
vim.g.slime_no_mappings = 1

vim.opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldclose = ""
}

vim.o.foldcolumn = "auto"
vim.o.foldclose = "all"
vim.o.foldlevel = 99 -- feel free to decrease the value
vim.o.foldenable = true

-- Latex stuff
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0

-- Use copilot everywhere
vim.g.copilot_filetypes = {
  ["*"] = true
}

-- Set keymaps and general stuff here
require("keymaps")
require("autocommands")

-- Load and configure plugins
require("plugins")
require("completion")
require("config")

require("file-tree")
require("code-formatting")
require("neorg-config")
require("lualine-config")
require("autoload_colorscheme")

print("Configuration loaded successfully!")
