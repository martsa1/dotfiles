call plug#begin('~/.config/nvim/plugged')

" Async support for nvim calling out to python process
Plug 'Shougo/deoplete.nvim'
" Fuzzy file finder
Plug 'kien/ctrlp.vim'
" Python project used by deoplete for code completion
Plug 'zchee/deoplete-jedi'
Plug 'https://github.com/neomake/neomake.git'
" powerline is fucked up, use vim-airline instead
"Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim'}
Plug 'vim-airline/vim-airline'
" Give git hints on current buffer line: Add, Modify, Remove within NerdTree
Plug 'airblade/vim-gitgutter'
" Git functionaility within vim for git (status|diff|bisect|....others]
Plug 'tpope/vim-fugitive'
" File tree within vim
Plug 'scrooloose/nerdtree'
" Give git hints on files/dirs regarding: Add, Modify, Remove within NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Old jedi vim not using deoplete -- for some reason need both deoplete-jedi
" and this
Plug 'davidhalter/jedi-vim'
" Create a source tree listing
Plug 'tmhedberg/SimpylFold'
" Maybe checkout ack.vim for source code searching.

call plug#end()
