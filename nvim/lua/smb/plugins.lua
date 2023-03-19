-- TODO: Perhaps we should actually move straight to Lazy, not even packer!
--
--
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

-- API guidance from packer repo for reference
--use {
--  'myusername/example',        -- The plugin location string
--  -- The following keys are all optional
--  disable = boolean,           -- Mark a plugin as inactive
--  as = string,                 -- Specifies an alias under which to install the plugin
--  installer = function,        -- Specifies custom installer. See "custom installers" below.
--  updater = function,          -- Specifies custom updater. See "custom installers" below.
--  after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--  rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--  opt = boolean,               -- Manually marks a plugin as optional.
--  bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
--  branch = string,             -- Specifies a git branch to use
--  tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
--  commit = string,             -- Specifies a git commit to use
--  lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--  run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--  requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--  rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--  config = string or function, -- Specifies code to run after this plugin is loaded.
--  -- The setup key implies opt = true
--  setup = string or function,  -- Specifies code to run before this plugin is loaded. The code is ran even if
--                               -- the plugin is waiting for other conditions (ft, cond...) to be met.
--  -- The following keys all imply lazy-loading and imply opt = true
--  cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--  ft = string or list,         -- Specifies filetypes which load this plugin.
--  keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--  event = string or list,      -- Specifies autocommand events which load this plugin.
--  fn = string or list          -- Specifies functions which load this plugin.
--  cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--  module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                               -- with one of these module names, the plugin will be loaded.
--  module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--                               -- requiring a string which matches one of these patterns, the plugin will be loaded.
--}
require("packer").startup(
    function(use)
        -- Use Packer to manage itself
        use "wbthomason/packer.nvim"

        -- Give git hints on current buffer line: Add, Modify, Remove within NerdTree
        use "airblade/vim-gitgutter"

        -- Add colour highlighting for colours in NVim
        use "ap/vim-css-color"

        -- Vim TOML Syntax Highlighting
        use {"cespare/vim-toml", ft = "toml"}

        -- Jenkinsfile linter integration
        use {"ckipp01/nvim-jenkinsfile-linter"}

        -- Dracular theme is a nice Dark Theme
        use "dracula/vim"

        -- Diagnostics (linters etc.) plugin
        use "folke/trouble.nvim"
        use "folke/lsp-colors.nvim"

        -- Make TODO comments more visible.
        use "folke/todo-comments.nvim"

        -- Neovim LSP config
        use {"folke/neodev.nvim"}

        -- Base Terraform support.
        use {"hashivim/vim-terraform", ft = "terraform"}

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

        -- TODO: This one can be loaded when calling its function, in essence...
        -- Markdown Previewer
        use "JamshedVesuna/vim-markdown-preview"

        -- Vim RG integration
        use "jremmen/vim-ripgrep"

        -- Autocomplete support for terraform
        use {"juliosueiras/vim-terraform-completion", ft = "terraform"}

        -- For luasnip users.
        use "L3MON4D3/LuaSnip"
        use "saadparwaiz1/cmp_luasnip"

        -- Support for typescript language syntax
        use {"leafgarland/typescript-vim", ft = "javascript,javascriptreact,jsx,typescript,typescriptreact"}

        -- Support for the Jinja Templating language
        use {"lepture/vim-jinja", ft = "jinja,jinja2"}

        -- Most comprehensive tagging plugin for vim?
        --use {"ludovicchabant/vim-gutentags", disable = true}
        -- NOTE: this is/was disabled in work config.

        -- Highlight yank regions
        use "machakann/vim-highlightedyank"

        -- source tree listing/menu containing definitions
        use "majutsushi/tagbar"

        -- Basic Jenkinsfile syntax highlighting etc.
        use {"martinda/Jenkinsfile-vim-syntax", ft = "Jenkinsfile"}

        -- Groovy syntax support
        use {"modille/groovy.vim", ft = "groovy"}

        -- JSX plugin
        use {"mxw/vim-jsx", ft = "jsx"}

        -- Adds support for using * and # keys with visual selection searching
        use "nelstrom/vim-visual-star-search"

        -- LSP configurations
        use "neovim/nvim-lspconfig"

        -- Fancy, lua-based ctrl-p replacement
        use "nvim-lua/popup.nvim"
        use "nvim-lua/plenary.nvim"
        use "nvim-lua/telescope.nvim"

        -- Successor to airline
        use {
            "nvim-lualine/lualine.nvim",
            requires = {
                {"kyazdani42/nvim-web-devicons"},
                {"arkav/lualine-lsp-progress"}
            }
        }

        -- Context-aware syntax highlighting
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        use {"nvim-treesitter/playground", run = ":TSInstall query"}
        -- Javascript language support
        use {"pangloss/vim-javascript", ft = "javascript,typescript"}

        -- Ansible File support in vim
        use {"pearofducks/ansible-vim", ft = "ansible"}

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
        -- TODO: Possibly replace with numToStr/Comment.nvim
        use "scrooloose/nerdcommenter"

        -- File tree within vim
        -- TODO: Possibly replace with nvim-tree/nvim-tree.lua
        use "scrooloose/nerdtree"

        -- Rust specific LSP extensions
        use "simrat39/rust-tools.nvim"

        -- Source code folding pluggin
        -- TODO: Should be redundant in the treesitter era.
        --use "tmhedberg/SimpylFold"

        -- Add support for the Gherkin file type
        use {"tpope/vim-cucumber", ft = "cucumber"}

        -- Git functionaility within vim for git (status|diff|bisect|....others])
        use "tpope/vim-fugitive"

        -- Adds support for surround text with characters of your choosing
        use "tpope/vim-surround"

        -- Systemd syntax highlighting for systemd unit files
        use {"wgwoods/vim-systemd-syntax", ft = "systemd"}

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

-- TODO: All of the plugin config here should probably be lazy-loaded wherever possible (see move to Lazy.nvim!)

-- Tresitter configuration for more awesome highlighting.
require("nvim-treesitter.configs").setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true -- false will disable the whole extension
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    }
}

require("trouble").setup({})

-- Configure jenkinsfile linter integration
-- TODO: This should be lazy-configured on opening a Jenkinsfile only.
if os.getenv("JENKINS_USER_ID") then
    vim.keymap.set(
        "n",
        "<leader>lf",
        "",
        {
            callback = require("jenkinsfile_linter").validate,
            desc = "Lint Jenkinsfile using Jenkins API"
        }
    )
end
