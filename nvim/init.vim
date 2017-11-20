" Adjust leader and provide a keybind to get to ,'s original function
" map Leader
let mapleader = ","
" keep backward f search, remapping it to ,;
nnoremap <Leader>; ,

" Source the rest of our configs
runtime ./config/init.vimrc


"https://github.com/ervandew/supertab
"
"https://github.com/greg-js/dotfiles/blob/master/.config/nvim/config/plugins.vimrc
"
"  # ctag command to generate ctag file for python project
"  ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags $(python \
"  -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if \
"  os.path.isdir(d)))")
