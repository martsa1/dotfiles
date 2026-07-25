-- Tree-sitter setup. The plugin + parsers are provided by nix via
-- programs.neovim.plugins, so we don't self-install anything.
local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

configs.setup({
    ensure_installed = {},
    auto_install = false,
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
