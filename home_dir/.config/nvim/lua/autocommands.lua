-- Autcommands in my neovim
vim.api.nvim_create_autocmd(
  "BufReadPost",
  {
    pattern = "*.py,*.tex,*.bib",
    desc = "Set colorcolumn dynamically",
    callback = function()
      vim.wo.colorcolumn = "81"
      vim.bo.tabstop = 4
      vim.bo.shiftwidth = 4
      -- vim.wo.foldcolumn = "auto:7"
    end
  }
)

vim.api.nvim_create_autocmd(
  "BufReadPost",
  {
    pattern = "*.lua",
    desc = "Set colorcolumn dynamically",
    callback = function()
      vim.wo.colorcolumn = "81"
      -- vim.wo.foldcolumn = "auto:7"
    end
  }
)

-- Always use limelight when using goyo
-- autocmd! User GoyoEnter Limelight
-- autocmd! User GoyoLeave Limelight!
vim.api.nvim_create_autocmd(
  "User",
  {
    pattern = "GoyoEnter",
    desc = "Use limelight when using goyo",
    callback = function()
      vim.cmd("Limelight")
    end
  }
)

vim.api.nvim_create_autocmd(
  "User",
  {
    pattern = "GoyoLeave",
    desc = "Use limelight when using goyo",
    callback = function()
      vim.cmd("Limelight!")
    end
  }
)
