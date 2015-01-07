set nocompatible
filetype off

" Set Vundle into the runtime path of Vim...
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-sensible'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'Yggdroot/indentLine'

" Colour Schemes
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'

call vundle#end()

" Colourscheme Settings
colorscheme molokai
let g:rehash256 = 1

"Markdown Settings
let g:vim_markdown_frontmatter=1

" Additional Settings
filetype plugin indent on
syntax on
set number
