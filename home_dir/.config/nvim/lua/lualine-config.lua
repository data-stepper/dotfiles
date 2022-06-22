-- -------------------- LUALINE --------------------
local function search_result()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local last_search = vim.fn.getreg("/")
  if not last_search or last_search == "" then
    return ""
  end
  local searchcount = vim.fn.searchcount {maxcount = 9999}
  return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
end

local function modified()
  if vim.bo.modified then
    return "+"
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return "-"
  end
  return ""
end

local ts_utils = require("nvim-treesitter.ts_utils")
local navic = require("nvim-navic")
-- Setup lualine
require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    -- component_separators = {left = "", right = ""},
    component_separators = {left = "|", right = "|"},
    section_separators = {left = "", right = ""},
    -- section_separators = {left = " ", right = " "},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end
      }
    },
    lualine_b = {
      {
        "branch",
        icon_only = true
      },
      {"filename", file_status = false},
      {modified},
      {
        "diagnostics",
        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
        -- or a function that returns a table as such:
        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
        -- sources = {"nvim_diagnostic"},
        sources = {"nvim_lsp"},
        -- Displays diagnostics for the defined severity types
        sections = {"error"},
        symbols = {error = "E", warn = "W", info = "I", hint = "H"},
        colored = true, -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false -- Show diagnostics even if there are none.
      },
      {
        "%w",
        cond = function()
          return vim.wo.previewwindow
        end
      },
      {
        "%r",
        cond = function()
          return vim.bo.readonly
        end
      },
      {
        "%q",
        cond = function()
          return vim.bo.buftype == "quickfix"
        end
      }
    },
    lualine_c = {
      {navic.get_location, cond = navic.is_available}
    },
    lualine_x = {},
    lualine_z = {
      search_result
    },
    lualine_y = {
      {
        "filetype",
        colored = true, -- Displays filetype icon in color if set to true
        icon_only = true, -- Display only an icon for filetype
        icon = {align = "right"} -- Display filetype icon on the right hand side
        -- icon =    {'X', align='right'}
        -- Icon string ^ in table is ignored in filetype component
      },
      "location"
    }
    -- Here I removed some unnecessary stuff
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        "windows",
        show_filename_only = true, -- Shows shortened relative path when set to false.
        show_modified_status = true, -- Shows indicator when the buffer is modified.
        mode = 0, -- 0: Shows buffer name
        -- 1: Shows buffer index (bufnr)
        -- 2: Shows buffer name + buffer index (bufnr)

        max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
        -- it can also be a function that returns
        -- the value of `max_length` dynamically.
        filetype_names = {
          TelescopePrompt = "Telescope",
          dashboard = "Dashboard",
          packer = "Packer",
          fzf = "FZF",
          alpha = "Alpha"
        }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
        disabled_buftypes = {"quickfix", "prompt"},
        -- Set special seperators for the buffers
        component_separators = {left = "|", right = "|"},
        section_separators = {left = "", right = ""},
        symbols = {
          modified = " ●", -- Text to show when the buffer is modified
          alternate_file = "", -- Text to show to identify the alternate file
          directory = "" -- Text to show when the buffer is a directory
        }
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        "tabs",
        component_separators = {left = "|", right = "|"},
        section_separators = {left = " ", right = " "}
      }
    }
  },
  extensions = {}
}
