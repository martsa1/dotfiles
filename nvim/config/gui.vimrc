if exists('g:GtkGuiLoaded')
  " Use a dark colourscheme (set behind an environment variable for terminal)
  colorscheme dracula
  color dracula

  set colorcolumn=100

  let g:GuiInternalClipboard = 1

  " Don't use the GTK built-in tabline, use Airline instead.
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)

  " Use a nice, code-ligature supporting font!
  call rpcnotify(1, 'Gui', 'Font', 'FuraCode Nerd Font 12')
endif

if exists('g:neovide')
  " Use a dark colourscheme (set behind an environment variable for terminal)
  colorscheme dracula
  color dracula

  set colorcolumn=100

  let g:GuiInternalClipboard = 1

  " Use a nice, code-ligature supporting font!
  set guifont=FuraCode\ Nerd\ Font,Light:h14
endif

