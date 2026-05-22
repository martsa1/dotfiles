-- TODO remove
-- put this VERY early (before plugins are loaded)
-- see https://github.com/folke/trouble.nvim/issues/655
-- until fixed, use this to leave all of trouble working, just without its TS decoration
-- helper; so, :Trouble commands work; no decoration provider gets registered.
package.preload["trouble.view.treesitter"] = function()
  local M = {}
  function M.setup(_) end
  function M.is_enabled() return false end
  function M.enable() return false end
  function M.attach(_) end
  function M.detach(_) end
  -- Neovim decoration provider callbacks (no-op)
  function M.on_start(_) end
  function M.on_buf(_) end
  function M.on_win(_) end
  function M.on_line(_) end
  function M.on_end(_) end
  function M.on_reload(_) end
  function M.on_lines(_) end
  return M
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- Give git hints on current buffer line: Add, Modify, Remove
    { "airblade/vim-gitgutter" },

    -- Nice bufferline
    { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- Add colour highlighting for colours in NVim
    { "catgoose/nvim-colorizer.lua" },

    -- Vim TOML Syntax Highlighting
    { "cespare/vim-toml", ft = "toml" },

    -- Jenkinsfile linter integration
    {
        "ckipp01/nvim-jenkinsfile-linter",
        config = function()
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
        end,
    },

    -- LSP end-of-line type hints
    {
        "chrisgrieser/nvim-lsp-endhints",
        config = function()
            require("lsp-endhints").setup({
                label = {
                    truncateAtChars = 60,
                },
            })
        end,
    },

    -- Dracula dark theme
    { "dracula/vim", name = "dracula" },

    -- Diagnostics (linters etc.) plugin
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({})
        end,
    },
    { "folke/lsp-colors.nvim" },

    -- Make TODO comments more visible
    { "folke/todo-comments.nvim" },

    -- Neovim LSP config helpers
    { "folke/neodev.nvim" },

    -- Key-shortcuts highlighting/config
    { "folke/which-key.nvim" },

    -- Modern UI features: picker, scroll, words, input, bigfile detection
    {
        "folke/snacks.nvim",
        config = function()
            ---@type snacks.Config
            require("snacks").setup({
                picker  = { enabled = true },
                scroll  = { enabled = true },
                words   = { enabled = true },
                input   = { enabled = true },
                bigfile = {
                    enabled = true,
                    notify  = true,
                    size    = 10 * 1024 * 1024,
                },
            })
        end,
    },

    -- Base Terraform support
    { "hashivim/vim-terraform", ft = "terraform" },

    -- Completion engine (blink.cmp — replaces nvim-cmp and all cmp-* source plugins)
    {
        "saghen/blink.cmp",
        version = "v0.*",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },
    },

    -- Icons set
    { "kyazdani42/nvim-web-devicons" },

    -- Markdown Previewer
    -- { "JamshedVesuna/vim-markdown-preview" },

    -- Vim RG integration
    { "jremmen/vim-ripgrep" },

    -- Autocomplete support for terraform
    { "juliosueiras/vim-terraform-completion", ft = "terraform" },

    -- Support for the Jinja templating language
    { "lepture/vim-jinja", ft = { "jinja", "jinja2" } },

    -- Visually display indentation
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end,
    },

    -- Highlight yank regions
    { "machakann/vim-highlightedyank" },

    -- Source tree listing/menu containing definitions
    { "majutsushi/tagbar" },

    -- Basic Jenkinsfile syntax highlighting
    { "martinda/Jenkinsfile-vim-syntax", ft = "Jenkinsfile" },

    -- Rust specific LSP extensions
    { "mrcjkb/rustaceanvim" },

    -- Groovy syntax support
    { "modille/groovy.vim", ft = "groovy" },

    -- JSX plugin
    { "mxw/vim-jsx", ft = "jsx" },

    -- Adds support for using * and # keys with visual selection searching
    { "nelstrom/vim-visual-star-search" },

    -- LSP configurations
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "b0o/schemastore.nvim", -- Adds access to schemastore catalog
        },
    },

    -- Fancy, lua-based ctrl-p replacement
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },

    -- Successor to airline statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            "arkav/lualine-lsp-progress",
        },
    },

    -- None-ls to integrate various linters/formatters into nvim-LSP
    { "nvimtools/none-ls.nvim" },

    -- Context-aware syntax highlighting
    -- TODO: Migrate to `main` branch - will need to re-write configs.
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = false, -- parsers are pre-compiled by nix (programs.neovim.plugins); no runtime compilation needed
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = 'all',
                ignore_install = { "ipkg", "norg" },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection    = "gnn",
                        node_incremental  = "grn",
                        scope_incremental = "grc",
                        node_decremental  = "grm",
                    },
                },
            })
            -- Associate Jenkinsfile filetype with the groovy parser
            vim.treesitter.language.register("groovy", "Jenkinsfile")
        end,
    },
    -- nvim-treesitter/playground removed: define_modules API was dropped; use :InspectTree / :EditQuery instead

    -- AI integration
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("codecompanion").setup({
                interactions = {
                    chat = {
                        adapter = {
                            name = "cursor_cli"
                        },
                    },
                },
                opts = { log_level = "DEBUG" },
            })
        end,
    },

    -- Ansible file support
    { "pearofducks/ansible-vim", ft = "ansible" },

    -- TypeScript integrations
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    },

    -- Add support for i3 config files
    { "PotatoesMaster/i3-vim-syntax" },

    -- Clangd LSP extensions support
    { "p00f/clangd_extensions.nvim" },

    -- LSP based function signature help
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if vim.tbl_contains({ "null-ls" }, client.name) then
                        return
                    end
                    require("lsp_signature").on_attach({
                        floating_window = false,
                        toggle_key = "<M-h>",
                        hint_prefix = {
                            above   = "↙ ",
                            current = "← ",
                            below   = "↖ ",
                        },
                    }, bufnr)
                end,
            })
        end,
    },

    -- Quickfix helpers
    { "romainl/vim-qf" },

    -- Dev Icons in NERDTree
    { "ryanoasis/vim-devicons" },

    -- conform.nvim — lua-native code formatting
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                python     = { "ruff_format" },
                json       = { "jq" },
                c          = { "clang_format" },
                cpp        = { "clang_format" },
                cmake      = { "cmake_format" },
                typescript = { "prettier" },
                javascript = { "prettier" },
            },
        },
    },

    -- Epic comment management
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    -- File tree within vim
    -- TODO: Possibly replace with nvim-tree/nvim-tree.lua
    { "scrooloose/nerdtree" },

    -- Add support for the Gherkin file type
    { "tpope/vim-cucumber", ft = "cucumber" },

    -- Git functionality within vim
    { "tpope/vim-fugitive" },

    -- Adds support for surround text with characters of your choosing
    { "tpope/vim-surround" },

    -- Systemd syntax highlighting for systemd unit files
    { "wgwoods/vim-systemd-syntax", ft = "systemd" },

    -- Give git hints on files/dirs in NerdTree
    { "Xuyuanp/nerdtree-git-plugin" },

}, {
    install = { colorscheme = { "dracula" } },
})
