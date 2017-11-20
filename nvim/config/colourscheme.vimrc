" ################################################
" ############# Coloursheme settings #############
" ################################################

"Setup the colourscheme - Default to Solarized Light, unless VAMPIRE
"environment variable is set (Dracula Theme), or DARKSUN is set (Solarized
"Dark)
if exists("$VAMPIRE")
  colorscheme dracula
  color dracula
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

