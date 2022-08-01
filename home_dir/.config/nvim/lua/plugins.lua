return require("packer").startup(
  function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    use "tpope/vim-surround"

    use {"heavenshell/vim-pydocstring", ft = "python"}
    use {"stevearc/gkeep.nvim", cmd = "GkeepOpen"}

    use "kevinhwang91/promise-async"
    use "kevinhwang91/nvim-ufo"
    use "SmiteshP/nvim-navic"

    use {
      "ray-x/lsp_signature.nvim",
      ft = {"python", "lua"},
      config = function()
        require "lsp_signature".setup {
          debug = false, -- set to true to enable debug logging
          log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
          -- default is  ~/.cache/nvim/lsp_signature.log
          verbose = false, -- show debug line number
          bind = true, -- This is mandatory, otherwise border config won't get registered.
          -- If you want to hook lspsaga or other signature handler, pls set to false
          doc_lines = 15, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
          -- set to 0 if you DO NOT want any API comments be shown
          -- This setting only take effect in insert mode, it does not affect signature help in normal
          -- mode, 10 by default

          floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
          floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
          -- will set to true when fully tested, set to false will use whichever side has more space
          -- this setting will be helpful if you do not want the PUM and floating win overlap

          floating_window_off_x = 1, -- adjust float windows x position.
          floating_window_off_y = -2, -- adjust float windows y position.
          fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
          hint_enable = true, -- virtual hint enable
          hint_prefix = "🐼 ", -- Panda for parameter
          hint_scheme = "String",
          hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
          max_height = 20, -- max height of signature floating_window, if content is more than max_height, you can scroll down
          -- to view the hiding contents
          max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
          handler_opts = {
            border = "rounded" -- double, rounded, single, shadow, none
          },
          always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
          transparency = 10 -- disabled by default, allow floating win transparent value 1~100
          -- shadow_blend = 36, -- if you using shadow as border use this set the opacity
          -- shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
        }
      end
    }

    use "neovim/nvim-lspconfig"
    use "glepnir/lspsaga.nvim"
    use "onsails/lspkind.nvim"

    use "arkav/lualine-lsp-progress"

    -- Nvim CMP stuff
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-emoji"
    use "dmitmel/cmp-cmdline-history"

    -- use "tamago324/cmp-zsh"
    -- use "kdheepak/cmp-latex-symbols"
    -- use "lukas-reineke/cmp-rg"

    -- CMP itself
    use "hrsh7th/nvim-cmp"

    use "romgrk/fzy-lua-native"
    use "tzachar/fuzzy.nvim"
    use "tzachar/cmp-fuzzy-buffer"
    -- use "tzachar/cmp-fuzzy-path"

    use "windwp/nvim-autopairs"

    use {
      "ThePrimeagen/refactoring.nvim",
      config = function()
        require("refactoring").setup({})
      end
    }

    -- use "jbyuki/nabla.nvim"

    use "nvim-lua/plenary.nvim"

    use {
      "quangnguyen30192/cmp-nvim-ultisnips",
      config = function()
        vim.g.UltiSnipsExpandTrigger = "<NUL>"
        vim.g.UltiSnipsNoMap = 1
      end
    }
    use "SirVer/ultisnips"

    use "mhartington/formatter.nvim"

    -- Todo comments search inside code
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {}
      end
    }

    -- For searching diagnostics
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end
    }

    -- use "honza/vim-snippets"

    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        vim.opt.list = true
        -- vim.opt.listchars:append("space:⋅")
        -- vim.opt.listchars:append("eol:<")

        require("indent_blankline").setup {
          show_current_context = true,
          show_current_context_start = true,
          -- show_end_of_line = true,
          space_char_blankline = " "
        }
      end
    }

    -- Use nvim-treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate"
    }

    use "simrat39/symbols-outline.nvim"

    -- Emojis in vim
    -- use "junegunn/vim-emoji"

    -- Switch to nvim-tree, a lua file tree version
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"

    -- Use devicons because it looks more beautiful
    use "tpope/vim-fugitive"
    use "tpope/vim-commentary"
    use "jiangmiao/auto-pairs"
    use "alvan/vim-closetag"

    -- Now using telescope
    use {
      "nvim-telescope/telescope.nvim",
      config = function()
        require("telescope").setup {
          defaults = {
            mappings = {
              i = {
                ["<Tab>"] = false,
                ["U"] = false
              }
            }
          },
          pickers = {},
          extensions = {}
        }
      end
    }

    use {
      "nvim-neorg/neorg",
      run = ":NeorgStart silent=true"
    }

    use "nvim-neorg/neorg-telescope"
    use "max397574/neorg-kanban"

    use {
      "junegunn/goyo.vim",
      config = function()
        vim.g.goyo_width = 100
      end
    }

    use "junegunn/limelight.vim"

    -- Use github copilot, yeah
    use "github/copilot.vim"

    -- Enable copilot by default for all filetypes
    -- let g:copilot_filetypes = {
    -- 	\ "*": v:true,
    -- \ }

    -- This plugin lets me move inside python code more easily
    use "jeetsukumaran/vim-pythonsense"

    -- Use vim-slime for interactive development
    use "jpalardy/vim-slime"

    -- My own ai assist plugin
    -- use "data-stepper/ai-text-assist"

    -- Vim and latex combination
    use {
      "lervag/vimtex",
      ft = "tex"
    }
    -- let g:tex_flavor="latex"
    -- let g:vimtex_view_method="zathura"
    -- let g:vimtex_quickfix_mode=0

    -- Text concealment
    -- use "KeitaNakamura/tex-conceal.vim" I think this is outdated, let's see
    -- set conceallevel=1
    -- let g:tex_conceal="abdmg"
    -- hi Conceal ctermbg=none

    -- From now on only use neovim compatible colorschemes
    -- use "Plug junegunn/seoul256.vim", { "branch": 'main' }
    -- This colorscheme doesn"t work anymore ?
    use "folke/tokyonight.nvim"
    use "EdenEast/nightfox.nvim"
    use "rmehri01/onenord.nvim"
    use "luisiacc/gruvbox-baby"
    use "overcache/NeoSolarized"
    use "savq/melange"
    use "sonph/onehalf"
    use "sainnhe/everforest"

    -- One can do also the bufferline with lualine
    use "nvim-lualine/lualine.nvim"
  end
)
