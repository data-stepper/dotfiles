-- Setup nvim-cmp.

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

-- -------------------- COMPLETION STUFF --------------------

require("nvim-autopairs").setup {}
local cmp = require("cmp")

cmp.setup(
  {
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end
    },
    mapping = {
      -- ["<Tab>"] = cmp.mapping(
      --     {
      --         c = function()
      --             if cmp.visible() then
      --                 cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
      --             else
      --                 cmp.complete()
      --             end
      --         end,
      --         i = function(fallback)
      --             if cmp.visible() then
      --                 cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
      --             elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
      --                 vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
      --             else
      --                 fallback()
      --             end
      --         end,
      --         s = function(fallback)
      --             if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
      --                 vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
      --             else
      --                 fallback()
      --             end
      --         end
      --     }
      -- ),
      -- ["<S-Tab>"] = cmp.mapping(
      --     {
      --         c = function()
      --             if cmp.visible() then
      --                 cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
      --             else
      --                 cmp.complete()
      --             end
      --         end,
      --         i = function(fallback)
      --             if cmp.visible() then
      --                 cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
      --             elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
      --                 return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
      --             else
      --                 fallback()
      --             end
      --         end,
      --         s = function(fallback)
      --             if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
      --                 return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
      --             else
      --                 fallback()
      --             end
      --         end
      --     }
      -- ),
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
              cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
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
              cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
            else
              fallback()
            end
          end
        }
      ),
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
        {name = "path"} -- Add path autocomplete in all buffers
      },
      {
        {name = "buffer"}
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
        {name = "cmdline"}
      }
    )
  }
)

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require("lspconfig")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- Add additional language servers here
local servers = {"pyright"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities
  }
end
-- -------------------- LANGUAGE SERVER STUFF --------------------

local saga = require "lspsaga"

saga.init_lsp_saga {}

-- -------------------- TREE SITTER STUFF --------------------

require("nvim-treesitter.configs").setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
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
  auto_close = false,
  auto_reload_on_write = true,
  disable_netrw = false,
  hide_root_folder = false,
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
    dotfiles = true,
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
