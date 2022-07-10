" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  Plug 'antoinemadec/FixCursorHold.nvim' " Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    " Better Syntax Support
    " Plug 'sheerun/vim-polyglot'
    
    Plug 'junegunn/goyo.vim' " Distraction free writing
    " File Explorer
    Plug 'scrooloose/NERDTree'

    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    "Which key
    Plug 'liuchengxu/vim-which-key'
    
    "Airline
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    
    "Colorizer
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'junegunn/rainbow_parentheses.vim'

    " snippets
    Plug 'rafamadriz/friendly-snippets'

    " Completion framework
    Plug 'hrsh7th/nvim-cmp'

    " LSP completion source for nvim-cmp
    Plug 'hrsh7th/cmp-nvim-lsp'

    " Snippet completion source for nvim-cmp
    Plug 'hrsh7th/cmp-vsnip'

    " Other usefull completion sources
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-buffer'

    Plug 'tpope/vim-commentary'

    " Git plugins
    Plug 'tpope/vim-fugitive' " Git
    Plug 'tpope/vim-rhubarb'  " Hub
    Plug 'junegunn/gv.vim'    " commit browser
    Plug 'mbbill/undotree'

    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

    Plug 'neovim/nvim-lspconfig'
    " telescope requirements...
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    " Snippet engine
    Plug 'hrsh7th/vim-vsnip'
    "Telescope extensions
    Plug 'nvim-telescope/telescope-project.nvim'

    " Debugging (needs plenary from above as well)
    Plug 'mfussenegger/nvim-dap'

    Plug 'kyazdani42/nvim-web-devicons' 
    "barbar.nvim
    Plug 'romgrk/barbar.nvim'

    "which key
    Plug 'liuchengxu/vim-which-key'

    "fzf

    " Plug 'junegunn/fzf.vim'
    " Plug 'airblade/vim-rooter'

    Plug 'mhinz/vim-startify'

    "vimwiki
    Plug 'vimwiki/vimwiki'

    Plug 'mfussenegger/nvim-lint'
    "Themes
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'tanvirtin/monokai.nvim'

    Plug 'rktjmp/lush.nvim'
    Plug 'ellisonleao/gruvbox.nvim'


    call plug#end()
