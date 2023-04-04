-- ################################################
-- ############# Colourscheme settings ############
-- ################################################

-- Setup the colourscheme - Default to Dracula Theme
vim.cmd.colorscheme("dracula")

-- ##################################################################################################
-- ######## Statusline settings ########################################################################
-- ##################################################################################################
require("smb.statusline")

-- If we are in a TrueColour terminal, use true colours
if vim.fn.has("termguicolors") then
    vim.opt.termguicolors = true
end

-- ################################################
-- ########## General Appearance settings #########
-- ################################################

vim.opt.showmode = true

-- In case we're inside a gui, set the font and size to fira-code.
vim.opt.guifont = "FiraCode Nerd Font Mono:h10"

-- general config
require("bufferline").setup({
  options = {
    numbers = "ordinal",
    separator_style = "slope",
  },
})

-- Always highlight the row and column of the cursor. - Set an end of line
-- marker at 100 chars.
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.cursorcolumn = true

vim.opt.ruler = true -- show the cursor position all the time
