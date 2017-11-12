source $HOME/.config/nvim/config/plugins/init.vimrc
source $HOME/.config/nvim/config/general.vimrc
" source keys because <Leader> is remapped, if mapping happens after plugins
" <Leader> is still mapped to old key
source $HOME/.config/nvim/config/keys.vimrc
source $HOME/.config/nvim/config/plugins.vimrc
source $HOME/.config/nvim/config/line.vimrc
source $HOME/.config/nvim/config/general_plugins.vimrc
"https://github.com/Shougo/deoplete.nvim/blob/master/doc/deoplete.txt
"https://github.com/kien/ctrlp.vim
"https://github.com/ervandew/supertab
"https://github.com/greg-js/dotfiles/blob/master/.config/nvim/config/plugins.vimrc
"https://github.com/junegunn/vim-plug.git
"
"
"
"
"  # ctag command to generate ctag file for python project
"  ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags $(python \
"  -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if \
"  os.path.isdir(d)))")
