call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim'
Plug 'kien/ctrlp.vim'
Plug 'zchee/deoplete-jedi'
Plug 'https://github.com/neomake/neomake.git'
" powerline is fucked up, use vim-airline instead
"Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim'} 
Plug 'vim-airline/vim-airline'

call plug#end()
