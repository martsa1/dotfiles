call plug#begin('~/.config/nvim/plugged')

" Add colour highlighting for colours in NVim
Plug 'ap/vim-css-color'

" Give git hints on current buffer line: Add, Modify, Remove within NerdTree
Plug 'airblade/vim-gitgutter'

" Vim TOML Syntax Highlighting
Plug 'cespare/vim-toml'

" Old jedi vim not using deoplete -- for some reason need both deoplete-jedi
" and this
Plug 'davidhalter/jedi-vim'

" Dracular theme is a nice Dark Theme
Plug 'dracula/vim'

" Vim Test harness integration - Supports standard test harnesses for multiple
" languages etc.
Plug 'janko-m/vim-test'

" Markdown Previewer
Plug 'JamshedVesuna/vim-markdown-preview'

" Fuzzy file finder
Plug 'kien/ctrlp.vim'

" Lots of language file type highlighting
Plug 'hoelzro/vim-polyglot'

" Support for the Jinja Templating language
Plug 'lepture/vim-jinja'

" Most comprehensive tagging plugin for vim?
Plug 'ludovicchabant/vim-gutentags'

" source tree listing/menu containing definitions
Plug 'majutsushi/tagbar'

" Adds support for using * and # keys with visual selection searching
Plug 'nelstrom/vim-visual-star-search'

"Async builder for Neovim
Plug 'neomake/neomake'

" Swoop provides multi-buffer find and replace
Plug 'pelodelfuego/vim-swoop'

" Add support for i3 config files
Plug 'PotatoesMaster/i3-vim-syntax'

" Epic Comment management
Plug 'scrooloose/nerdcommenter'

" File tree within vim
Plug 'scrooloose/nerdtree'

"Add Yang language support to vim
Plug 'Shathur/yang.vim'

" Async support for nvim calling out to python process
Plug 'Shougo/deoplete.nvim'

" Source code folding pluggin
Plug 'tmhedberg/SimpylFold'

" Git functionaility within vim for git (status|diff|bisect|....others]
Plug 'tpope/vim-fugitive'

" Adds support for surround text with characters of your choosing
Plug 'tpope/vim-surround'

" powerline is fucked up, use vim-airline instead
Plug 'vim-airline/vim-airline'

" Solarized Theme is one of the most popular colourschemes
Plug 'vim-scripts/Solarized'

" Give git hints on files/dirs regarding: Add, Modify, Remove within NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Visually display indentation
Plug 'Yggdroot/indentLine'

" Python project used by deoplete for code completion
Plug 'zchee/deoplete-jedi'

"" JS stuff
" Maybe checkout ack.vim for source code searching.
"Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' } " needs sudo?
"Plug 'ternjs/tern_for_vim'
"Plug 'pangloss/vim-javascript'

" ------------------ Go Lang ------------------

" Go auto completion client
Plug 'zchee/deoplete-go', { 'do': 'make'}

" ------------------ Rust Lang ------------------

" Rust auto completion client
Plug 'sebastianmarkow/deoplete-rust'


call plug#end()
