set nocompatible
filetype off

" Determine Operating system, and add the appropriate Vim Directory {{{
if has("win32") || has("win16") "Windows specific vim directory
    set rtp+=~/_vim/bundle/Vundle.vim
    let path='~/_vim/bundle'
else 		"Linux Vim Directory to be added to runtime...
    set rtp+=~/.vim/bundle/Vundle.vim

endif
" }}}

" Ensure that any gvim instances use a nice font...
set guifont=monaco:h9:cANSI

" Set Vundle into the runtime path of Vim...
"set rtp+=~/.vim/bundle/Vundle.vim
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
Plugin 'bling/vim-bufferline'
Plugin 'tpope/vim-fugitive.git'
Plugin 'fatih/vim-go'
Plugin 'stephpy/vim-yaml'
Plugin 'Valloric/YouCompleteMe'

" Colour Schemes
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'

" Syntax Highlighting Scripts
Plugin 'jelera/vim-javascript-syntax'

call vundle#end()

" Colourscheme Settings
colorscheme molokai
let g:rehash256 = 1

"Markdown Settings
let g:vim_markdown_frontmatter=1

" Indent Settings
let g:indentLine_color_term = 239

" Additional Settings
filetype plugin indent on
syntax on
set number
set colorcolumn=100

" Settings for Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint', 'flake8', 'python']
