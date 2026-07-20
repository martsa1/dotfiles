-- Tree-sitter setup. Runs in both parser modes:
--   nix  -> plugin + parsers provided by nix (programs.neovim.plugins); no self-install.
--   self -> plugin via lazy; nvim-treesitter compiles parsers into a writable dir.
local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

local nix_parsers = (os.getenv("NVIM_TS_PARSERS") or "nix") == "nix"

configs.setup({
    ensure_installed = nix_parsers and {} or "all",
    auto_install = not nix_parsers,
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
