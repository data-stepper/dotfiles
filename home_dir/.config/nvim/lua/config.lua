-- -------------------- CODE FORMATTING --------------------
require("formatter").setup(
  {
    filetype = {
      json = {
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--double-quote"},
            stdin = true
          }
        end
      },
      tex = {
        function()
          return {
            exe = "latexindent",
            args = {"-"},
            stdin = true
          }
        end
      },
      sh = {
        -- Shell Script Formatter
        function()
          return {
            exe = "shfmt",
            args = {"-i", 4},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      python = {
        -- Configuration for psf/black
        function()
          return {
            exe = "black", -- this should be available on your $PATH
            args = {"--fast", "--line-length", 89, "--experimental-string-processing", "-"},
            stdin = true
          }
        end
      }
    }
  }
)

vim.api.nvim_exec(
  [[
augroup FormatAutogroup
	autocmd!
	autocmd BufWritePost *.lua,*.py,*.tex,*.sh,*.bash, FormatWrite
augroup END
]],
  true
)
-- Fix this issue where after formatting the folds are gone.
-- setting 'foldmethod' to 'expr' fixes this but it needs to be done automatically.
-- autocmd BufWritePost *.lua,*.py,*.tex,*.sh,*.bash, :set foldmethod=expr

-- -------------------- REFACTORING STUFF --------------------
require("refactoring").setup({})

-- -------------------- INDENT BLANKLINE --------------------
vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:<")

require("indent_blankline").setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
  -- show_end_of_line = true,
  space_char_blankline = " "
}

-- -------------------- NEORG SETUP --------------------
require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.integrations.telescope"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          main = "~/git/notes/main",
          gtd = "~/git/notes/gtd"
        }
      }
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "gtd"
      }
    },
    ["core.norg.concealer"] = {
      config = {
        -- icon_preset = "diamond",
        dim_code_blocks = false
      }
    },
    ["external.kanban"] = {
      config = {
        task_states = {
          "undone",
          "done",
          "pending",
          "cancelled",
          "uncertain",
          "urgent",
          "recurring",
          "on_hold"
        }
      }
    },
    ["core.norg.qol.toc"] = {}
    -- ["core.norg.completion"] = {},
    -- ["core.export"] = {},
    -- ["core.norg.manoeuvre "] = {},
    -- ["core.integrations.nvim-cmp"] = {},
    -- ["core.gtd.ui"] = {},
    -- ["core.highlights"] = {},
    -- ["core.export.markdown"] = {}
  }
}

-- -------------------- TELESCOPE --------------------
require("telescope").setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {}
    }
  },
  pickers = {},
  extensions = {}
}

require("telescope").load_extension("refactoring")

vim.api.nvim_set_keymap(
  "v",
  "<leader>rr",
  "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  {noremap = true}
)

-- -------------------- COMPLETION STUFF --------------------

require("nvim-autopairs").setup {}
require("cmp_nvim_ultisnips").setup {}
local lspkind = require("lspkind")
local cmp = require("cmp")
local types = require("cmp.types")
local str = require("cmp.utils.str")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup(
  {
    experimental = {
      ghost_text = true
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered()
    },
    formatting = {
      format = lspkind.cmp_format(
        {
          mode = "symbol_text", -- show only symbol annotations
          maxwidth = 70, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          before = function(entry, vim_item)
            vim_item.menu =
              ({
              nvim_lsp = "ﲳ",
              nvim_lua = "",
              treesitter = "",
              path = "ﱮ",
              buffer = "﬘",
              zsh = "",
              vsnip = "",
              spell = "暈"
            })[entry.source.name]

            -- Get the full snippet (and only keep first line)
            local word = entry:get_insert_text()
            if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
              word = vim.lsp.util.parse_snippet(word)
            end
            word = str.oneline(word)
            if
              entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet and
                string.sub(vim_item.abbr, -1, -1) == "~"
             then
              word = word .. "~"
            end
            vim_item.abbr = word

            return vim_item
          end
        }
      )
    },
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end
    },
    mapping = {
      -- Short description of how EXACTLY the completion menu works now
      -- When typing somewhere, a completion menu will be shown
      -- It will not complete anything unless items from it are selected
      --
      -- Select the below item using <C-j> and scroll through the suggestions
      -- scroll back up with <C-k>. In insert mode you will have to press
      -- <C-y> to confirm a suggestion, in command line mode selected options
      -- will automatically be inserted and then you can just keep typing.
      --
      ["<C-j>"] = cmp.mapping(
        {
          c = function()
            if cmp.visible() then
              cmp.select_next_item({behavior = cmp.SelectBehavior.Replace})
            else
              vim.api.nvim_feedkeys(t("<Down>"), "n", true)
            end
          end,
          i = function(fallback)
            if cmp.visible() then
              select_fallback = function()
                cmp.select_next_item({behavior = cmp.SelectBehavior.Replace})
              end
              cmp_ultisnips_mappings.compose {"jump_forwards"}(select_fallback)
            else
              fallback()
            end
          end
        }
      ),
      ["<C-k>"] = cmp.mapping(
        {
          c = function()
            if cmp.visible() then
              cmp.select_prev_item({behavior = cmp.SelectBehavior.Replace})
            else
              vim.api.nvim_feedkeys(t("<Up>"), "n", true)
            end
          end,
          i = function(fallback)
            if cmp.visible() then
              select_fallback = function()
                cmp.select_prev_item({behavior = cmp.SelectBehavior.Replace})
              end
              cmp_ultisnips_mappings.compose {"jump_backwards"}(select_fallback)
            else
              fallback()
            end
          end
        }
      ),
      -- The below defined mappings ONLY jump between ultisnips tabstops!
      -- ["<C-l>"] = cmp.mapping(
      --   function(fallback)
      --     cmp_ultisnips_mappings.compose {"jump_forwards"}(fallback)
      --   end,
      --   {"i", "s" --[[ "c" (to enable the mapping in command mode) ]]}
      -- ),
      -- ["<C-h>"] = cmp.mapping(
      --   function(fallback)
      --     cmp_ultisnips_mappings.compose {"jump_backwards"}(fallback)
      --   end,
      --   {"i", "s" --[[ "c" (to enable the mapping in command mode) ]]}
      -- ),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), {"i", "c"}),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), {"i", "c"}),
      -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
      ["<C-e>"] = cmp.mapping({i = cmp.mapping.close(), c = cmp.mapping.close()}),
      ["<C-y>"] = cmp.mapping(
        {
          i = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),
          c = function(fallback)
            if cmp.visible() then
              cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true})
            else
              fallback()
            end
          end
        }
      )
    },
    sources = cmp.config.sources(
      {
        {name = "nvim_lsp"},
        {name = "ultisnips"}, -- For ultisnips users.
        {name = "path"}, -- Add path autocomplete in all buffers
        {name = "zsh"},
        {name = "latex_symbols"},
        {name = "nvim_lsp_signature_help"},
        {name = "nvim_lsp_document_symbol"},
        {name = "rg"} -- Ripgrep
        -- {name = "copilot"}
      },
      {
        {name = "buffer"},
        {name = "emoji"}
      }
    )
  }
)

-- Set configuration for specific filetype.
cmp.setup.filetype(
  "gitcommit",
  {
    sources = cmp.config.sources(
      {
        {name = "cmp_git"} -- You can specify the `cmp_git` source if you were installed it.
      },
      {
        {name = "buffer"}
      }
    )
  }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
  {
    sources = {
      {name = "buffer"}
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    sources = cmp.config.sources(
      {
        {name = "path"}
      },
      {
        {name = "cmdline"},
        {name = "cmdline_history"}
      }
    )
  }
)

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.wo.foldcolumn = "1"
-- vim.wo.foldlevel = 99 -- feel free to decrease the value
vim.wo.foldenable = true

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, {chunkText, hlGroup})
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, {suffix, "MoreMsg"})
  return newVirtText
end

-- global handler
require("ufo").setup(
  {
    fold_virt_text_handler = handler
  }
)

local lspconfig = require("lspconfig")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- Add additional language servers here
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(
  --   bufnr,
  --   "n",
  --   "<space>wl",
  --   "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
  --   opts
  -- )
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  --
end

local servers = {"pyright"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

-- Setup texlab extra as it is not really a language server.
lspconfig["texlab"].setup {}

-- -------------------- LANGUAGE SERVER STUFF --------------------

local saga = require "lspsaga"

saga.init_lsp_saga {}

-- -------------------- TREE SITTER STUFF --------------------

require("nvim-treesitter.configs").setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false
    -- pyfold = {
    --   enable = true,
    --   custom_foldtext = true -- Sets provided foldtext on window where module is active
    -- }
  }
}

-- Set up folding here for some reason this works here but not in init.vim ?
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

-- -------------------- LUALINE --------------------

-- Standard lualine setup
require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = {left = "", right = ""},
    section_separators = {left = "", right = ""},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {
      "branch",
      "diff",
      {
        "diagnostics",
        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
        -- or a function that returns a table as such:
        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
        sources = {"nvim_diagnostic"},
        -- Displays diagnostics for the defined severity types
        sections = {"error", "warn", "info", "hint"},
        symbols = {error = "E", warn = "W", info = "I", hint = "H"},
        colored = true, -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false -- Show diagnostics even if there are none.
      }
    },
    lualine_c = {"filename"},
    lualine_x = {"filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
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
        } -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {"tabs"}
  },
  extensions = {}
}

-- -------------------- NVIM-TREE --------------------

-- setup with all defaults
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require("nvim-tree").setup {
  -- BEGIN_DEFAULT_OPTS
  -- auto_close = false,
  -- hide_root_folder = false, -- These options deprecated ???
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = true,
  open_on_tab = true,
  sort_by = "name",
  update_cwd = true,
  view = {
    width = 40,
    height = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {}
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {}
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = nil,
    args = {}
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = ""
    }
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400
  },
  actions = {
    change_dir = {
      enable = true,
      global = true
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = {"notify", "packer", "qf", "diff", "fugitive", "fugitiveblame"},
          buftype = {"nofile", "terminal", "help"}
        }
      }
    }
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      git = false,
      profile = false
    }
  }
}
