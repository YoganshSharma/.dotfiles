local packer = require("util.packer")

local config = {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
}

local function plugins(use)
  -- Packer can manage itself as an optional plugin
    use({ "wbthomason/packer.nvim" })

    use({ "jose-elias-alvarez/null-ls.nvim", module = "null-ls" })
    use("antoinemadec/FixCursorHold.nvim") -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

    use {
        "numToStr/Comment.nvim",
        config = function()
            require('config.comment')
        end
    }

  use({
    "folke/trouble.nvim",
    event = "BufReadPre",
    module = "trouble",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup({
        auto_open = false,
        use_diagnostic_signs = true, -- en
      })
    end,
  })
  -- Tabs
  use({
    "akinsho/nvim-bufferline.lua",
    -- event = "BufReadPre",
    config = function()
      require("config.bufferline")
    end,
  })
    use({ "mbbill/undotree", cmd = "UndotreeToggle" })
    use({
    "windwp/nvim-autopairs",
    module = "nvim-autopairs",
    config = function()
      require("config.autopairs")
    end,
    })

    use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("config.keys")
    end,
    })


    --Colorizer
    use({
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("config.colorizer")
    end,
    })
    
    -- Indent Guides and rainbow brackets
    use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("config.blankline")
    end,
    })

    use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    module = "nvim-treesitter",
    requires = {
      -- "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    config = [[require('config.treesitter')]],
    })
    use({
    "L3MON4D3/LuaSnip",
    module = "luasnip",
    config = function()
      require("config.snippets")
    end,
    requires = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    })

    use({
      "hrsh7th/nvim-cmp",
      -- event = "InsertEnter",
      config = function()
        require("config.cmp")
      end,
      requires = {
        { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
      },
    })


  use({
    "SmiteshP/nvim-navic",
    module = "nvim-navic",
    config = function()
      vim.g.navic_silence = true
      require("nvim-navic").setup({ separator = " " })
    end,
  })

    -- LSP
    use({
    "neovim/nvim-lspconfig",
    -- event = "BufReadPre",
    config = function()
      require("config.lsp")
    end,
    })

    -- Fuzzy finder
    use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope")
    end,
    cmd = { "Telescope" },
    module = "telescope",
    -- keys = { "<leader><space>", "<leader>fz", "<leader>pp" },
    requires = {
      { "nvim-telescope/telescope-file-browser.nvim", module = "telescope._extensions.file_browser" },
      { "nvim-telescope/telescope-z.nvim", module = "telescope._extensions.z" },
      { "nvim-telescope/telescope-project.nvim", module = "telescope._extensions.project" },
      { "nvim-telescope/telescope-symbols.nvim", module = "telescope._extensions.symbols" },
      { "nvim-telescope/telescope-fzf-native.nvim", module = "telescope._extensions.fzf", run = "make" },
    },
    })
    use({ "nvim-lua/plenary.nvim", module = "plenary" })

    -- Theme: icons
    use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
    })


    -- -- Dashboard
    -- use({ "glepnir/dashboard-nvim", opt = false, config = [[require('config.dashboard')]] })

    -- -- Debugging (needs plenary from above as well)
    --  use('mfussenegger/nvim-dap')
    -- -- use('rcarriga/nvim-dap-ui')

    ----barbar.nvim
    -- use('romgrk/barbar.nvim')



    --vimwiki
    -- use('vimwiki/vimwiki')

    -- use('mfussenegger/nvim-lint')
    -- Themes
    -- use('folke/tokyonight.nvim', { 'branch': 'main' })
    -- use('tanvirtin/monokai.nvim')
    -- use('rktjmp/lush.nvim')
    use("ellisonleao/gruvbox.nvim")

end

return packer.setup(config, plugins)
