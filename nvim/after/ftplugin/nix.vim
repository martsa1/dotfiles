"autocmd!
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

setfiletype=nix

"find occurrences
"nnoremap <leader>f :"zyiw !rgrep -n <C-R>z --exclude=*.pyc

" original font monospace regular
set encoding=utf-8
set fileencoding=utf-8

set colorcolumn=100
"highlight ColorColumn ctermbg=0 guibg=0

"" IndentLine Plugin Settings
let g:indentLine_color_term=22
