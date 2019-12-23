call plug#begin('~/.config/nvim/plugged')

" Add colour highlighting for colours in NVim
Plug 'ap/vim-css-color'

" Give git hints on current buffer line: Add, Modify, Remove within NerdTree
Plug 'airblade/vim-gitgutter'

" Vim TOML Syntax Highlighting
Plug 'cespare/vim-toml'

" Dracular theme is a nice Dark Theme
Plug 'dracula/vim'

" Add buffer explorer for easier buffer traversal
Plug 'jlanzarotta/bufexplorer'

" Vim Test harness integration - Supports standard test harnesses for multiple
" languages etc.
Plug 'janko-m/vim-test'

" Markdown Previewer
Plug 'JamshedVesuna/vim-markdown-preview'

" Vim RG integration
Plug 'jremmen/vim-ripgrep'

" Fuzzy file finder
Plug 'kien/ctrlp.vim'

" Lots of language file type highlighting
Plug 'hoelzro/vim-polyglot'

" Support for the Jinja Templating language
Plug 'lepture/vim-jinja'

" Most comprehensive tagging plugin for vim?
Plug 'ludovicchabant/vim-gutentags'

" Highlight yank regions
Plug 'machakann/vim-highlightedyank'

" source tree listing/menu containing definitions
Plug 'majutsushi/tagbar'

" JSX plugin
Plug 'mxw/vim-jsx'

" Adds support for using * and # keys with visual selection searching
Plug 'nelstrom/vim-visual-star-search'

"Async builder for Neovim
Plug 'neomake/neomake'

" Javascript language support
Plug 'pangloss/vim-javascript'

" Ansible File support in vim
Plug 'pearofducks/ansible-vim'

" Add support for i3 config files
Plug 'PotatoesMaster/i3-vim-syntax'

" Quickfix helpers
Plug 'romainl/vim-qf'

" Add the base rust syntax highlighting plugin
Plug 'rust-lang/rust.vim'

" Dev Icons in NERDTree...
Plug 'ryanoasis/vim-devicons'

" Vim NeoFormat -- Code formatting plugin
Plug 'sbdchd/neoformat'

" Epic Comment management
Plug 'scrooloose/nerdcommenter'

" File tree within vim
Plug 'scrooloose/nerdtree'

" Async support for nvim calling out to python process
Plug 'Shougo/deoplete.nvim'

" Source code folding pluggin
Plug 'tmhedberg/SimpylFold'

" Add support for the Gherkin file type
Plug 'tpope/vim-cucumber'

" Git functionaility within vim for git (status|diff|bisect|....others]
Plug 'tpope/vim-fugitive'

" Adds support for surround text with characters of your choosing
Plug 'tpope/vim-surround'

" powerline is fucked up, use vim-airline instead
Plug 'vim-airline/vim-airline'

" Close all buffers save the current with :BufOnly - add a number to close all
" save that number.
Plug 'vim-scripts/BufOnly.vim'

" Solarized Theme is one of the most popular colourschemes
Plug 'vim-scripts/Solarized'

" System-d syntax highlighting for systemd unit files
Plug 'wgwoods/vim-systemd-syntax'

" Give git hints on files/dirs regarding: Add, Modify, Remove within NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Visually display indentation
Plug 'Yggdroot/indentLine'

" Symantic python highlighting
Plug 'numirias/semshi'

" Go auto completion client
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Rust auto completion client
Plug 'sebastianmarkow/deoplete-rust'

" Language Server Protocol - LSP
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) but needed if LanguageServer wants to display multiple
" completion candidates
Plug 'junegunn/fzf', {'do': './install --all'}

call plug#end()
