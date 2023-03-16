-- Sourced from packer homepage, bootstrap packer then use it to manage plugins.
-- See https://github.com/wbthomason/packer.nvim for details.

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(
    function(use)
        -- Use Packer to manage itself
        use "wbthomason/packer.nvim"

        -- Give git hints on current buffer line: Add, Modify, Remove within NerdTree
        use "airblade/vim-gitgutter"

        -- Add colour highlighting for colours in NVim
        use "ap/vim-css-color"

        -- Vim TOML Syntax Highlighting
        use "cespare/vim-toml"

        -- Jenkinsfile linter integration
        use "ckipp01/nvim-jenkinsfile-linter"

        -- Dracular theme is a nice Dark Theme
        use "dracula/vim"

        -- Diagnostics (linters etc.) plugin
        use "folke/trouble.nvim"
        use "folke/lsp-colors.nvim"

        -- Neovim LSP config
        use "folke/neodev.nvim"

        -- Base Terraform support.
        use "hashivim/vim-terraform"

        -- Completion stuff...
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-cmdline"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-nvim-lsp-signature-help"
        use "hrsh7th/cmp-nvim-lua"
        use "hrsh7th/cmp-path"
        use "hrsh7th/nvim-cmp"

        -- Icons set used by folke/trouble.
        use "kyazdani42/nvim-web-devicons"

        -- Markdown Previewer
        use "JamshedVesuna/vim-markdown-preview"

        -- Vim RG integration
        use "jremmen/vim-ripgrep"

        -- Autocomplete support for terraform
        use "juliosueiras/vim-terraform-completion"

        -- For luasnip users.
        use "L3MON4D3/LuaSnip"
        use "saadparwaiz1/cmp_luasnip"

        -- Support for typescript language syntax
        use "leafgarland/typescript-vim"

        -- Support for the Jinja Templating language
        use "lepture/vim-jinja"

        -- Most comprehensive tagging plugin for vim?
        use {"ludovicchabant/vim-gutentags", disabled=true}
        -- NOTE: this is/was disabled in work config.

        -- Highlight yank regions
        use "machakann/vim-highlightedyank"

        -- source tree listing/menu containing definitions
        use "majutsushi/tagbar"

        -- Basic Jenkinsfile syntax highlighting etc.
        use "martinda/Jenkinsfile-vim-syntax"

        -- Groovy syntax support
        use "modille/groovy.vim"

        -- JSX plugin
        use "mxw/vim-jsx"

        -- Adds support for using * and # keys with visual selection searching
        use "nelstrom/vim-visual-star-search"

        -- LSP configurations
        use "neovim/nvim-lspconfig"

        -- Fancy, lua-based ctrl-p replacement
        use "nvim-lua/popup.nvim"
        use "nvim-lua/plenary.nvim"
        use "nvim-lua/telescope.nvim"

        -- Context-aware syntax highlighting
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        use {"nvim-treesitter/playground", run = ":TSInstall query"}

        -- Javascript language support
        use "pangloss/vim-javascript"

        -- Ansible File support in vim
        use "pearofducks/ansible-vim"

        -- Add support for i3 config files
        use "PotatoesMaster/i3-vim-syntax"

        -- Clangd LSP extensions support.
        use "p00f/clangd_extensions.nvim"

        -- Snippets collection
        use "rafamadriz/friendly-snippets"

        -- Quickfix helpers
        use "romainl/vim-qf"

        -- Dev Icons in NERDTree...
        use "ryanoasis/vim-devicons"

        -- Vim NeoFormat -- Code formatting plugin
        use "sbdchd/neoformat"

        -- Epic Comment management
        use "scrooloose/nerdcommenter"

        -- File tree within vim
        use "scrooloose/nerdtree"

        -- Rust specific LSP extensions
        use "simrat39/rust-tools.nvim"

        -- Source code folding pluggin
        use "tmhedberg/SimpylFold"

        -- Add support for the Gherkin file type
        use "tpope/vim-cucumber"

        -- Git functionaility within vim for git (status|diff|bisect|....others]
        use "tpope/vim-fugitive"

        -- Adds support for surround text with characters of your choosing
        use "tpope/vim-surround"

        -- powerline is fucked up, use vim-airline instead
        use "vim-airline/vim-airline"

        -- Systemd syntax highlighting for systemd unit files
        use "wgwoods/vim-systemd-syntax"

        -- Give git hints on files/dirs regarding: Add, Modify, Remove within NerdTree
        use "Xuyuanp/nerdtree-git-plugin"

        -- Visually display indentation
        use "Yggdroot/indentLine"

        -- Automatically set up configuration after cloning packer.nvim
        -- Keep this at the end of plugin setup.
        if packer_bootstrap then
            require("packer").sync()
        end
    end
)
