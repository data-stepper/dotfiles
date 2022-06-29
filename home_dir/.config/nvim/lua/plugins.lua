return require("packer").startup(
  function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    use "tpope/vim-surround"

    use "heavenshell/vim-pydocstring"

    use "kevinhwang91/promise-async"
    use "kevinhwang91/nvim-ufo"
    use "ray-x/lsp_signature.nvim"
    use "SmiteshP/nvim-navic"

    use "stevearc/gkeep.nvim"

    use "neovim/nvim-lspconfig"
    use "glepnir/lspsaga.nvim"
    use "onsails/lspkind.nvim"

    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-emoji"
    use "dmitmel/cmp-cmdline-history"
    use "tamago324/cmp-zsh"
    use "kdheepak/cmp-latex-symbols"
    use "lukas-reineke/cmp-rg"
    use "hrsh7th/nvim-cmp"

    use "romgrk/fzy-lua-native"
    use "tzachar/fuzzy.nvim"
    use "tzachar/cmp-fuzzy-buffer"
    use "tzachar/cmp-fuzzy-path"

    use "windwp/nvim-autopairs"

    use "ThePrimeagen/refactoring.nvim"

    use "jbyuki/nabla.nvim"

    use "nvim-lua/plenary.nvim"

    use "quangnguyen30192/cmp-nvim-ultisnips"
    -- use "SirVer/ultisnips"
    -- 	let g:UltiSnipsNoMap = 1
    -- 	let g:UltiSnipsExpandTrigger = "<NUL>"

    use "mhartington/formatter.nvim"

    -- use "honza/vim-snippets"

    use "lukas-reineke/indent-blankline.nvim"

    -- Use nvim-treesitter
    use "nvim-treesitter/nvim-treesitter"
    -- use "eddiebergman/nvim-treesitter-pyfold"
    -- use "romgrk/nvim-treesitter-context-- -- Not so cool for solarized colors
    -- use "liuchengxu/vista.vim"
    -- 	let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
    -- Not using vista anymore, it is not hierarchical
    use "simrat39/symbols-outline.nvim"

    -- Emojis in vim
    -- use "junegunn/vim-emoji"

    -- Switch to nvim-tree, a lua file tree version
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"

    -- Use devicons because it looks more beautiful
    use "tpope/vim-fugitive"
    use "tpope/vim-commentary"
    -- use "tmhedberg/SimpylFold"
    use "jiangmiao/auto-pairs"
    use "alvan/vim-closetag"

    -- Now using telescope
    -- use "junegunn/fzf", { "do": { -> fzf#install() } }
    use "nvim-telescope/telescope.nvim"
    use "nvim-neorg/neorg"
    use "nvim-neorg/neorg-telescope"
    use "max397574/neorg-kanban"

    use "yegappan/mru"
    use "junegunn/goyo.vim"
    -- Use a little wider than the default (80)
    -- let g:goyo_width = 100

    use "junegunn/limelight.vim"
    -- Always use limelight when using goyo
    -- autocmd! User GoyoEnter Limelight
    -- autocmd! User GoyoLeave Limelight!

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
    -- Use the neovim terminal feature
    -- let g:slime_target = "neovim"

    -- For python always use ipython
    -- Don"t use ipython anymore since it uses way to much ram,
    -- use bpython or python3 interactive directly
    -- let g:slime_python_ipython = 1

    -- Remove the standard mappings created by vim-slime
    -- let g:slime_no_mappings = 1

    -- My own ai assist plugin
    -- use "data-stepper/ai-text-assist"

    -- Vim and latex combination
    use "lervag/vimtex"
    -- let g:tex_flavor="latex"
    -- let g:vimtex_view_method="zathura"
    -- let g:vimtex_quickfix_mode=0

    -- Text concealment
    use "KeitaNakamura/tex-conceal.vim"
    -- set conceallevel=1
    -- let g:tex_conceal="abdmg"
    -- hi Conceal ctermbg=none

    -- Loads of color schemes here (colorscheme)
    -- use "altercation/vim-colors-solarized"
    -- use "rafi/awesome-vim-colorschemes"
    -- use "arzg/vim-colors-xcode"
    -- use "patstockwell/vim-monokai-tasty"
    -- The above colorschemes where abandoned

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

    -- Shows buffers and tabs opened
    -- use "bling/vim-bufferline"
    -- use "mkitt/tabline.vim"
    -- The new bufferline written in lua
    -- use "akinsho/bufferline.nvim"
    -- One can do also the bufferline with lualine
    use "nvim-lualine/lualine.nvim"
  end
)
