-- UNCOMMENT THIS FOR DEBUGGING LSPs.
-- vim.lsp.set_log_level("debug")
-- run the below command:
-- :lua vim.cmd('e'..vim.lsp.get_log_path())

-- Enable several LSP's & Completion settings

-- Setup blink.cmp
require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<CR>"]  = { "select_and_accept", "fallback" },
        ["<Esc>"] = { "cancel", "fallback" },
    },
    completion = {
        list = {
            selection = {
                preselect  = false, -- matches cmp's PreselectMode.None
                auto_insert = false,
            },
        },
        documentation = {
            auto_show           = true,
            auto_show_delay_ms  = 200,
        },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    snippets = { preset = "luasnip" },
    signature = { enabled = true }, -- replaces cmp-nvim-lsp-signature-help
})

-- Setup lspconfig.
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- IMPORTANT: neodev Lua-LSP setup must be called before lspconfig.
require("neodev").setup(
    {
        override = function(root_dir, library)
            local normalize = vim.fs.normalize
            local valid_dirs = {normalize("~/.config/nixpkgs/nvim"), normalize("~/.config/nvim")}
            -- Since I'm using nix, my actual source tends to be edited from here...
            for _, path in pairs(valid_dirs) do
                if root_dir == path then
                    library.enabled = true
                    library.plugins = true
                end
            end
            if library.enabled == false then
                vim.print("Not enabling neodev")
            end
		end
	}
)

-- vim.lsp.config('pylsp', {
--     capabilities = capabilities,
--     settings = {
--         pylsp = {
--             plugins = {
--                 configurationSources = {"flake8"},
--                 flake8 = {
--                     enabled = true
--                 },
--                 jedi_completion = {
--                     eager = true, -- Attempts to eagerly resolve documentation and detail.
--                     --rename = false
--                 },
--                 pycodestyle = {
--                     enabled = false
--                 },
--                 pyflakes = {
--                     enabled = false
--                 },
--                 pylint = {
--                     enabled = false
--                 },
--                 pylsp_mypy = {
--                     enabled = true,
--                     dmypy = false,
--                     report_progress = true,
--
--                     -- live_mode = true
--                 },
--                 -- rope_autoimport = {
--                 --    enabled = true,
--                 --    completions = {
--                 --        enabled = true
--                 --    },
--                 --    code_actions = {
--                 --        enabled = true
--                 --    },
--                 -- },
--                 -- rope_completion = {
--                 --    enabled = true
--                 -- },
--             }
--         }
--     }
-- }
-- )
-- vim.lsp.enable('pylsp')
-- vim.lsp.config(
--   'ty',
--   {
--     settings = {
--       ty = {
--         diagnosticMode = "openFilesOnly",
--         inlayHints = {
--           variableTypes = true,
--           callArgumentNames = true,
--         },
--       },
--     },
--   },
-- )
vim.lsp.enable('ty')

vim.lsp.config('ruff', {
    capabilities = capabilities,
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = { "--preview" },
        }
    }
}
)
vim.lsp.enable('ruff')

-- Commented lspconfig for clangd as its called internally by clangd-extensions.
require("clangd_extensions").setup {
    capabilities = capabilities,
    inlay_hints = {
        -- Put hints at the end of the line, not inline
        inline = false,
    }
}

vim.lsp.config('clangd', {
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
    },
    on_attach = function(_client, bufnr)
        -- local clang_inlay_hints  = require("clangd_extensions.inlay_hints");
        -- clang_inlay_hints.setup_autocmd()
        -- clang_inlay_hints.set_inlay_hints()

        -- for clangd enabled buffers only, add a keybind to swap header/impl.
        vim.keymap.set("n", "gh", "<cmd>ClangdSwitchSourceHeader<CR>",
            { silent = true, desc = "Switch between header and source" }
        )
    end
}
)
vim.lsp.enable('clangd')


vim.lsp.config('cmake', {capabilities = capabilities})
vim.lsp.enable('cmake')

vim.lsp.config('bashls', {capabilities = capabilities})
vim.lsp.enable('bashls')

vim.lsp.config('nil_ls', {capabilities = capabilities})
vim.lsp.enable('nil_ls')

vim.lsp.config('terraformls', {capabilities = capabilities})
vim.lsp.enable('terraformls')

vim.lsp.config('cucumber_language_server', {capabilities = capabilities})
vim.lsp.enable('cucumber_language_server')

vim.lsp.config('graphql', {capabilities = capabilities})
vim.lsp.enable('graphql')

-- UI stuff with Vue
vim.lsp.enable('biome')
vim.lsp.enable('vue_ls')
vim.lsp.enable('vtsls')
vim.lsp.enable('tailwindcss')

vim.lsp.config('zls', {capabilities = capabilities})
vim.lsp.enable('zls')


-- JSON and Yaml LSP setup to use SchemaStore
local schemastore = require("schemastore")
vim.lsp.config('jsonls', {
    capabilities = capabilities,
    settings  = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true },
        }
    }
}
)
vim.lsp.enable('jsonls')

-- TODO: How to get this to load per-project settings I wonder?
-- https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings#configure-in-your-personal-settings-initlua
vim.lsp.config('yamlls', {
    capabilities = capabilities,
    settings = {
        yaml = {
            validate = true,
            completion = true,
            hover = true,
            format = {
                enable = true,
            },
            schemastore = {
                -- Disable built-in in favour of schemastore plugin.
                enable = false,
                -- Avoid spurious type error
                url = ""
            },
            customTags = {
                "!And scalar",
                "!And mapping",
                "!And sequence",
                "!If scalar",
                "!If mapping",
                "!If sequence",
                "!Not scalar",
                "!Not mapping",
                "!Not sequence",
                "!Equals scalar",
                "!Equals mapping",
                "!Equals sequence",
                "!Or scalar",
                "!Or mapping",
                "!Or sequence",
                "!FindInMap scalar",
                "!FindInMap mappping",
                "!FindInMap sequence",
                "!Base64 scalar",
                "!Base64 mapping",
                "!Base64 sequence",
                "!Cidr scalar",
                "!Cidr mapping",
                "!Cidr sequence",
                "!Ref scalar",
                "!Ref mapping",
                "!Ref sequence",
                "!Sub scalar",
                "!Sub mapping",
                "!Sub sequence",
                "!GetAtt scalar",
                "!GetAtt mapping",
                "!GetAtt sequence",
                "!GetAZs scalar",
                "!GetAZs mapping",
                "!GetAZs sequence",
                "!ImportValue scalar",
                "!ImportValue mapping",
                "!ImportValue sequence",
                "!Select scalar",
                "!Select mapping",
                "!Select sequence",
                "!Split scalar",
                "!Split mapping",
                "!Split sequence",
                "!Join scalar",
                "!Join mapping",
                "!Join sequence"
            },
            schemas = schemastore.yaml.schemas(),
        }
    }
}
)
vim.lsp.enable('yamlls')

-- Setup lua_ls and enable call snippets for neovim config
vim.lsp.config('lua_ls', {
        -- settings = {
        --   Lua = {
        --     completion = {
        --       callSnippet = "Replace"
        --     }
        --   }
        -- },
        capabilities = capabilities
    }
)
vim.lsp.enable('lua_ls')

require("typescript-tools").setup {
    capabilities = capabilities,
    settings = {
        expose_as_code_actions = "all",

		complete_function_calls = true,

        tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        },
    },
}
vim.lsp.config('eslint', {capabilities = capabilities})
vim.lsp.enable('eslint')

-- Snippets setup
-- Imports VSCode style snippets (friendly-snippets plugin)
local vscode_snippet_loader = require("luasnip.loaders.from_vscode")
vscode_snippet_loader.lazy_load()
vscode_snippet_loader.lazy_load({paths = {"./snippets"}}) -- Personal snippets.

-- lua formatted snippets:
require("luasnip.loaders.from_lua").load({paths = "./snippets"})


-- Setup inlay hints for any LSP that supports them
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
	-- TODO: Check this before trying to enable: inlayHintProvider
    callback = function(args)
        -- local client = vim.lsp.get_client_by_id(args.data.client_id)
        vim.lsp.inlay_hint.enable(true)
    end,
})

-- None-ls for cfn-lint integration etc.
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.cfn_lint
  },
})
