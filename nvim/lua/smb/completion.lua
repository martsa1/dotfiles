-- UNCOMMENT THIS FOR DEBUGGING LSPs.
-- vim.lsp.set_log_level("debug")
-- run the below command:
-- :lua vim.cmd('e'..vim.lsp.get_log_path())

-- Enable several LSP's & Completion settings
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- Setup nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup(
    {
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            end
        },
        mapping = cmp.mapping.preset.insert(
            {
                -- Completion keybinds
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = false}), -- select = false only accepts manually selected options.
                -- Lusnip keybinds
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                ),
                ["<S-Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                    {"i", "s"}
                )
            }
        ),
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "cmp-nvim-lsp-signature-help"},
                {name = "nvim_lua"},
                {name = "luasnip"}
            },
            {
                {name = "buffer"}
            }
        )
    }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    "/",
    {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            {name = "buffer"}
        }
    }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":",
    {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
            {
                {name = "path"}
            },
            {
                {name = "cmdline"}
            }
        )
    }
)

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

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

local lspconfig = require("lspconfig")
lspconfig.pylsp.setup {
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                configurationSources = {"flake8"},
                flake8 = {
                    enabled = true
                },
                jedi_completion = {
                    eager = true -- Attempts to eagerly resolve documentation and detail.
                },
                pycodestyle = {
                    enabled = false
                },
                pyflakes = {
                    enabled = true
                },
                pylint = {
                    enabled = true
                },
                pylsp_mypy = {
                    enabled = true,
                    live_mode = true
                }
            }
        }
    }
}

-- Commented lspconfig for clangd as its called internally by clangd-extensions.
-- lspconfig.clangd.setup{capabilities = capabilities}
require("clangd_extensions").setup {
    server = {
        capabilities = capabilities
    },
    extensions = {
        autoSetHints = true
    }
}

-- Setup rust-tools, which provides some extensions beyond the base lsp-config for rust-analyzer
local rt = require("rust-tools")
rt.setup(
    {
        server = {},
        capabilities = capabilities
    }
)
-- Hopefully not needed when using rust-tools above
-- lspconfig.rust_analyzer.setup{capabilities = capabilities}

lspconfig.cmake.setup {capabilities = capabilities}
lspconfig.yamlls.setup {capabilities = capabilities}
lspconfig.bashls.setup {capabilities = capabilities}
lspconfig.rnix.setup {capabilities = capabilities}
lspconfig.terraformls.setup {capabilities = capabilities}
lspconfig.cucumber_language_server.setup {capabilities = capabilities}
lspconfig.zls.setup {capabilities = capabilities}

-- Setup lua_ls and enable call snippets for neovim config
lspconfig.lua_ls.setup(
    {
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

-- Snippets setup
-- Imports VSCode style snippets (friendly-snippets plugin)
local vscode_snippet_loader = require("luasnip.loaders.from_vscode")
vscode_snippet_loader.lazy_load()
vscode_snippet_loader.lazy_load({paths = {"./snippets"}}) -- Personal snippets.
