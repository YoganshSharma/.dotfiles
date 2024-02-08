
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
    use({
        "mattn/emmet-vim",
        config = function()
            vim.g.user_emmet_leader_key = '<C-Z>'
        end
    })
    -- wakatime plugin
    use 'wakatime/vim-wakatime'
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- use({ "jose-elias-alvarez/null-ls.nvim", module = "null-ls" }) -- depreceated
    -- use("antoinemadec/FixCursorHold.nvim") -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

    use {
        "numToStr/Comment.nvim",
        config = function()
            require('config.comment')
        end
    }

    use({ "jose-elias-alvarez/typescript.nvim", module = "typescript" })

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
    -- use({
    --     "akinsho/nvim-bufferline.lua",
    --     -- event = "BufReadPre",
    --     config = function()
    --         require("config.bufferline")
    --     end,
    --

    -- statusline
    use({
        'windwp/windline.nvim',
        config = function()
            require('config.windline')
        end,
        requires = { 'lewis6991/gitsigns.nvim' },
    })
    use({
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
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
        'nvim-treesitter/nvim-treesitter-context',
        requires = {
            "nvim-treesitter/nvim-treesitter",
        }
    })

    use "folke/lua-dev.nvim"
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

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        config = function()
            require("config.lsp")
        end,
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use({
        "simrat39/rust-tools.nvim",
        config = function()
            require("config.rust_tools")
        end,
    })
    use({
        'ray-x/go.nvim',
        requires = {
            "ray-x/guihua.lua", -- recommended if need floating window support
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter"
        }
    })
    use({
  "adalessa/laravel.nvim",
  requires = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
    "nvimtools/none-ls.nvim",
  },
  cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
  keys = {
    { "<leader>la", ":Laravel artisan<cr>" },
    { "<leader>lr", ":Laravel routes<cr>" },
    { "<leader>lm", ":Laravel related<cr>" },
  },
  event = { "VeryLazy" },
  config = true,
    })
    use({
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    })
    use { "kiyoon/jupynium.nvim", run = "pip3 install --user ." }
    -- use { "kiyoon/jupynium.nvim", run = "conda run --no-capture-output -n jupynium pip install ." }
    use { "rcarriga/nvim-notify" }   -- optional
    use { "stevearc/dressing.nvim" } -- optional, UI for :JupyniumKernelSelect
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
            { "nvim-telescope/telescope-z.nvim",            module = "telescope._extensions.z" },
            { "nvim-telescope/telescope-project.nvim",      module = "telescope._extensions.project" },
            { "nvim-telescope/telescope-symbols.nvim",      module = "telescope._extensions.symbols" },
            { "nvim-telescope/telescope-fzf-native.nvim",   module = "telescope._extensions.fzf",         run = "make" },
        },
    })
    use({ "nvim-lua/plenary.nvim", module = "plenary" })

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    })

    use({
        "ryoppippi/bad-apple.vim",
        requires = {
            "vim-denops/denops.vim",
        },
    })
    use { 'sourcegraph/sg.nvim', run = 'nvim -l build/init.lua',
        requires = {
            'nvim-lua/plenary.nvim', "nvim-telescope/telescope.nvim"
        },
    }

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
