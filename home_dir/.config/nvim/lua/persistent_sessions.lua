if not vim.g.persistent_sessions_path then
  vim.g.persistent_sessions_path = vim.fn.expand("$HOME/.persistent_session")
end

local write_session_state = function()
  vim.cmd("mksession! " .. vim.g.persistent_sessions_path)
end

vim.api.nvim_create_autocmd(
  "BufWritePost",
  {
    callback = write_session_state
  }
)
