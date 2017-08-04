call plug#begin('~/.config/nvim/plugged')

" Async support for nvim calling out to python process
Plug 'Shougo/deoplete.nvim'
" Fuzzy file finder
Plug 'kien/ctrlp.vim'
" Python project used by deoplete for code completion
Plug 'zchee/deoplete-jedi'
Plug 'neomake/neomake'
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
" Source code folding pluggin
Plug 'tmhedberg/SimpylFold'
""" START: - AUTOTAGGING - features one or the other, currently not a good idea
""" until exploring stock vim features and manual key map for tag generation
""""" Create and remove entries on file save/write
""""Plug 'craigemery/vim-autotag'
""""""
""""Plug 'xolox/vim-easytags' " Requires vim-misc as dependency
" Most comprehensive tagging plugin for vim?
Plug 'ludovicchabant/vim-gutentags'
""""Plug 'xolox/vim-misc' " Dependency of easytag
""" END: - AUTOTAGGING -
" source tree listing/menu containing definitions
Plug 'majutsushi/tagbar'
" Visually display indentation
Plug 'Yggdroot/indentLine'
" Color theming - supposedly the best
Plug 'vim-scripts/Solarized'
"" JS stuff
" Maybe checkout ack.vim for source code searching.
"Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' } " needs sudo?
"Plug 'ternjs/tern_for_vim'
"Plug 'pangloss/vim-javascript'

Plug 'scrooloose/nerdcommenter'

Plug 'pelodelfuego/vim-swoop'

" Lots of language file type highlighting
Plug 'hoelzro/vim-polyglot'

"Add Yang language support to vim
Plug 'Shathur/yang.vim'
call plug#end()
