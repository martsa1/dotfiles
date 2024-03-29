"autocmd!
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

"find occurrences
"nnoremap <leader>f :"zyiw !rgrep -n <C-R>z --exclude=*.pyc

" original font monospace regular
set encoding=utf-8
set fileencoding=utf-8

" Disable docstring window popup on code completion
"augroup filetype_python
"  autocmd FileType python setlocal completeopt-=preview
"augroup End

"set colorcolumn=100
"highlight ColorColumn ctermbg=0 guibg=0
