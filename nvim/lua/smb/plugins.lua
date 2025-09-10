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

        -- Nice bufferline
        use {"akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons"}

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

        -- key-shortcuts highlihgting/config
        use "folke/which-key.nvim"

        -- Base Terraform support.
        use {"hashivim/vim-terraform", ft = "terraform"}

        -- Completion stuff...
        use {
            "hrsh7th/nvim-cmp",
            requires = {
                {"hrsh7th/cmp-buffer"},
                {"hrsh7th/cmp-cmdline"},
                {"hrsh7th/cmp-nvim-lsp"},
                {"hrsh7th/cmp-nvim-lsp-signature-help"},
                {"hrsh7th/cmp-nvim-lua"},
                {"hrsh7th/cmp-path"},
                {"L3MON4D3/LuaSnip"},
                {"saadparwaiz1/cmp_luasnip"}
            }
        }

        -- Icons set used by folke/trouble.
        use "kyazdani42/nvim-web-devicons"

        -- TODO: This one can be loaded when calling its function, in essence...
        -- Markdown Previewer
        use "JamshedVesuna/vim-markdown-preview"

        -- Vim RG integration
        use "jremmen/vim-ripgrep"

        -- Autocomplete support for terraform
        use {"juliosueiras/vim-terraform-completion", ft = "terraform"}

        -- Support for the Jinja Templating language
        use {"lepture/vim-jinja", ft = "jinja,jinja2"}

        -- Visually display indentation
        use "lukas-reineke/indent-blankline.nvim"

        -- Use treesitter to figure out the correct comment string even for embedded sub-languages
        use "JoosepAlviste/nvim-ts-context-commentstring"

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
        use "b0o/schemastore.nvim" -- Adds access to schemastore catalog

        -- Add colour highlighting for colours in NVim
        use "norcalli/nvim-colorizer.lua"

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

        -- None-ls to intgegrate various things into nvim-LSP.
        use "nvimtools/none-ls.nvim"

        -- Context-aware syntax highlighting
        use {
            "nvim-treesitter/nvim-treesitter",
            branch = "master",
            run = function()
                local ts_update = require("nvim-treesitter.install").update({with_sync = false})
                ts_update()
            end
        }
        use {"nvim-treesitter/playground", run = ":TSInstall query"}

        -- Ansible File support in vim
        use {"pearofducks/ansible-vim", ft = "ansible"}

        -- Typescript integrations
        use {
            "pmizio/typescript-tools.nvim",
            requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
        }

        -- Add support for i3 config files
        use "PotatoesMaster/i3-vim-syntax"

        -- Clangd LSP extensions support.
        use "p00f/clangd_extensions.nvim"

        -- Snippets collection
        use "rafamadriz/friendly-snippets"

        -- LSP based function signature help
        use "ray-x/lsp_signature.nvim"

        -- Quickfix helpers
        use "romainl/vim-qf"

        -- Dev Icons in NERDTree...
        use "ryanoasis/vim-devicons"

        -- Vim NeoFormat -- Code formatting plugin
        use "sbdchd/neoformat"

        -- Epic Comment management
        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }

        -- File tree within vim
        -- TODO: Possibly replace with nvim-tree/nvim-tree.lua
        use "scrooloose/nerdtree"

        -- Rust specific LSP extensions
        -- DEPRECATED: should switch to: https://github.com/mrcjkb/rustaceanvim
        -- alternative looks more faff to integrate though...
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

		-- LLM integrations
		use {
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					-- Defer to nvim-cmp/avante
					suggestion = { enabled = false },
					panel = { enabled = false },
				})
			end,
		}
		-- TODO: Integrate co-pilot into nvim-cmp
		use {
			"zbirenbaum/copilot-cmp",
			after = { "copilot.lua" },
			config = function ()
				require("copilot_cmp").setup()
			end
		}

        use {
			'yetone/avante.nvim',
            requires = {
				{"MeanderingProgrammer/render-markdown.nvim"},
				{"MunifTanjim/nui.nvim"},
				{"nvim-lua/plenary.nvim"},
				{"stevearc/dressing.nvim"},
			},
			branch = 'main',
			run = 'make',
			opts = {
				provider = "copilot",
				-- Some warnings about potential token creation rates... (hope to disable auto-providing in any case though)
				auto_suggestsions_provider = "copilot",
				chat = "copilot"
			},
			config = function()
			  require('avante_lib').load()
			  require('avante').setup()
			end
        }


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
    ignore_install = { "ipkg", "norg" },
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
-- Associate Jenkinsfile filetype with the groovy parser
vim.treesitter.language.register("groovy", "Jenkinsfile")

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

-- Configure intentline stuff
require("ibl").setup()

-- Configure LSP signature help
-- Options are here: https://github.com/ray-x/lsp_signature.nvim?tab=readme-ov-file#full-configuration-with-default-values
-- require("lsp_signature").setup({
--     floating_window = false,
--     toggle_key = "<M-h>",
--     hint_prefix = {
--         above = "↙ ",  -- when the hint is on the line above the current line
--         current = "← ",  -- when the hint is on the same line
--         below = "↖ "  -- when the hint is on the line below the current line
--     }
-- })
vim.api.nvim_create_autocmd(
    "LspAttach",
    {
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if vim.tbl_contains({"null-ls"}, client.name) then -- blacklist lsp
                return
            end
            require("lsp_signature").on_attach(
                {
                    floating_window = false,
                    toggle_key = "<M-h>",
                    hint_prefix = {
                        above = "↙ ", -- when the hint is on the line above the current line
                        current = "← ", -- when the hint is on the same line
                        below = "↖ " -- when the hint is on the line below the current line
                    }
                },
                bufnr
            )
        end
    }
)
