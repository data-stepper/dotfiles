require("nvim-autopairs").setup {}

require("cmp_nvim_ultisnips").setup {}
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

local lspkind = require("lspkind")
local cmp = require("cmp")
local types = require("cmp.types")
local str = require("cmp.utils.str")

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
          maxwidth = 70,
          -- prevent the popup from showing more than provided characters
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
              cmp.select_next_item({behavior = cmp.SelectBehavior.Replace})
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
              cmp.select_prev_item({behavior = cmp.SelectBehavior.Replace})
            else
              fallback()
            end
          end
        }
      ),
      -- The below defined mappings ONLY jump between ultisnips tabstops!
      ["<C-Right>"] = cmp.mapping(
        function(fallback)
          cmp_ultisnips_mappings.compose {"jump_forwards"}(fallback)
        end,
        {"i", "s" --[[ "c" (to enable the mapping in command mode) ]]}
      ),
      ["<C-Left>"] = cmp.mapping(
        function(fallback)
          cmp_ultisnips_mappings.compose {"jump_backwards"}(fallback)
        end,
        {"i", "s" --[[ "c" (to enable the mapping in command mode) ]]}
      ),
      ["<Tab>"] = cmp.mapping(
        function(fallback)
          cmp_ultisnips_mappings.compose {"jump_forwards"}(fallback)
        end,
        {"i" --[[ "c" (to enable the mapping in command mode) ]]}
      ),
      ["<S-Tab>"] = cmp.mapping(
        function(fallback)
          cmp_ultisnips_mappings.compose {"jump_backwards"}(fallback)
        end,
        {"i" --[[ "c" (to enable the mapping in command mode) ]]}
      ),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), {"i", "c"}),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), {"i", "c"}),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
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
    -- Maybe the keyword length is too long for some completion sources?
    sources = cmp.config.sources(
      {
        {name = "nvim_lsp"},
        {name = "ultisnips"}, -- For ultisnips users.
        -- {name = "zsh"},
        {name = "nvim_lsp_document_symbol"},
        {name = "emoji"}
        -- {name = "nvim_lsp_signature_help"},
        -- {name = "rg"} -- Ripgrep
      },
      {
        {name = "path"} -- Add path autocomplete in all buffers
        -- {name = "fuzzy_path", keyword_length = 5} -- Add path autocomplete in all buffers
      },
      {
        {name = "buffer", keyword_length = 3}
        -- {name = "fuzzy_buffer", keyword_length = 5}
      }
    )
  }
)

cmp.setup.filetype(
  {
    "python",
    "lua"
  },
  {
    sources = cmp.config.sources(
      {
        {name = "nvim_lsp"},
        {name = "ultisnips"}, -- I use ultisnips for now
        {name = "nvim_lsp_document_symbol", keyword_length = 3},
        {name = "emoji"}
        -- {name = "latex_symbols"}
      },
      {
        {name = "path", keyword_length = 2} -- Add path autocomplete in all buffers
        -- {name = "fuzzy_path"} -- Add path autocomplete in all buffers
      }
      -- {
      --   {name = "buffer"},
      --   {name = "fuzzy_buffer"}
      --   -- {name = "zsh"}
      -- }
    )
  }
)

cmp.setup.filetype(
  "tex",
  {
    sources = cmp.config.sources(
      {
        {name = "nvim_lsp"},
        {name = "nvim_lsp_document_symbol"},
        {name = "ultisnips"}, -- For ultisnips users.
        {name = "emoji"}
        -- {name = "latex_symbols"}
      },
      {
        {name = "buffer", keyword_length = 4}
        -- {name = "fuzzy_buffer", keyword_length = 5}
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
        {name = "cmp_git"}, -- You can specify the `cmp_git` source if you were installed it.
        {name = "emoji"}
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
      {name = "buffer"},
      {name = "fuzzy_buffer"}
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    sources = cmp.config.sources(
      {
        {name = "cmdline"},
        {name = "cmdline_history"}
      },
      {
        {name = "path"}
        -- {name = "fuzzy_path"}
      }
    )
  }
)
