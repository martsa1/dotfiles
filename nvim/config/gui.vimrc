if exists('g:GtkGuiLoaded')
  colorscheme dracula
  let g:GuiInternalClipboard = 1

  color dracula
  set colorcolumn=100
  call rpcnotify(1, 'Gui', 'Font', 'FuraCode Nerd Font 12')
endif
