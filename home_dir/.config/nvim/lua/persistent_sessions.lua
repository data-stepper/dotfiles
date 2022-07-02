-- Set some paths as global variables in neovim

if not vim.g.persistent_sessions_path then
  vim.g.persistent_sessions_path = vim.fn.expand("$HOME/.persistent_session")
end

if not vim.g.colorscheme_path then
  vim.g.colorscheme_path = vim.fn.expand("$HOME/.vim_colorscheme")
end

-- Write session state to 'mksession' file
local write_session_state = function()
  if not vim.bo.filetype == "gitcommit" then
    vim.cmd("mksession! " .. vim.g.persistent_sessions_path)
  end
end

-- Save colors
local save_state = function()
  -- Overwrite if the file
  local f = io.open(vim.g.colorscheme_path, "w")
  if f then
    f:write(
      vim.fn.json_encode(
        {
          colorscheme = vim.g.colors_name,
          background = vim.o.background
        }
      )
    )
    f:close()
  end
end

-- Load colors
local load_state = function()
  local f = io.open(vim.g.colorscheme_path, "r")
  if f then
    local data = f:read("*a")
    f:close()
    local state = vim.fn.json_decode(data)
    if state.colorscheme then
      vim.cmd("colorscheme " .. state.colorscheme)
    end
    if state.background then
      vim.cmd("set background=" .. state.background)
    end
  end
end

-- Makes sure that the autocommands are not defined twice
if not vim.g.autocommands_defined_persistent_state then
  vim.api.nvim_create_autocmd(
    "Colorscheme",
    {
      callback = save_state,
      desc = "Auto save colorscheme"
    }
  )

  vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
      callback = write_session_state,
      desc = "Auto save session"
    }
  )

  vim.g.autocommands_defined_persistent_state = true
end

load_state()
