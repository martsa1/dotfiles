vim.api.nvim_create_autocmd(
	"FileType",
	{
		pattern = "python",
		callback = function()
			vim.bo.tabstop = 4
			vim.bo.expandtab = true
			vim.bo.shiftwidth = 4
			vim.bo.softtabstop = 4
			vim.bo.fileencoding = "utf-8"
			-- N.B. need to update to newer treesitter plugin to use this.
			-- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	}
)
