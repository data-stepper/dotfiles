if not vim.g.persistent_sessions_path then
  vim.g.persistent_sessions_path = vim.fn.expand("$HOME/.persistent_session")
end

local write_session_state = function()
  if not vim.bo.filetype == "gitcommit" then
    vim.cmd("mksession! " .. vim.g.persistent_sessions_path)
  end
end

-- Save colors
local save_state = function()
  -- Overwrite if the file
end

-- Load colors
local load_state = function()
  if vim.g.Colors_State then
    vim.g.colors_name = vim.g.Colors_State[1]
    vim.o.background = vim.g.Colors_State[2]
  else
    vim.g.colors_name = "NeoSolarized"
    vim.o.background = "light"
  end
end

load_state()

if not vim.g.autocommands_defined_persistent_state then
  vim.api.nvim_create_autocmd(
    "Colorscheme",
    {
      callback = save_state
    }
  )

  vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
      callback = write_session_state
    }
  )

  vim.g.autocommands_defined_persistent_state = true
end

-- vim.api.nvim_create_user_command(
--   "LoadPersistentSession",
-- 	{
-- 		sync = true,
-- 		func = function()
-- 			vim.cmd("source " .. vim.g.persistent_sessions_path)
-- 		end
-- 	}
-- )
