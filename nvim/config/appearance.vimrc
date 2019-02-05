" ################################################
" ############# Coloursheme settings #############
" ################################################

"Setup the colourscheme - Default to Solarized Light, unless VAMPIRE
"environment variable is set (Dracula Theme), or DARKSUN is set (Solarized
"Dark)
if exists("$VAMPIRE")
  colorscheme dracula
  color dracula
  set colorcolumn=100
elseif exists("$DARKSUN")
	set background=dark "(light|dark)
	colorscheme solarized
else
	set background=light "(light|dark)
	colorscheme solarized
endif

" If we are in a TrueColour terminal, use true colours
if has("termguicolors")
  set termguicolors
endif

" ################################################
" ########## General Appearance settings #########
" ################################################

" Setup the status/command line
set cmdheight=1
set display+=lastline

" general config
set laststatus=2 " always show status line
set showtabline=2 " always show tabline
set noshowmode " hide default mode text (e.g. INSERT) as airline already displays it

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
