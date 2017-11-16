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
augroup filetype_python
  autocmd FileType python setlocal completeopt-=preview
augroup End

set colorcolumn=100
highlight ColorColumn ctermbg=0 guibg=0

"" IndentLine Plugin Settings
let g:indentLine_color_term=22
"let g:indentLine_char = 'Ì∫ê' " insert mode ctrl+v or c followed by
"uNUMBERS OR simply insert \uCODEPOINT or \UCODEPOINT
"let g:indentLine_char = 'Ì∫ê'
"" Other IndentLine Options
"let g:indentLine_concealcursor = 'inc'
"let g:indentLine_conceallevel = 2
"let g:indentLine_setConceal = 0
"let g:indentLine_enabled = 0

"let g:neomake_flake8_maker = {
"    \ 'exe': 'flake8',
"    \ 'args': ['--option', 'x'],
"    \ 'append_file': 0,
"    \ 'errorformat': '%f:%l:%c: %m',
"    \ }

"let g:neomake_python_flake8_maker = {
"      \ 'exe': 'flake8',
"      \ }

" autocmd BufLeave * QFix

"let g:neomake_place_signs = 0

" Add a comment to this line
"let g:neomake_open_list = 2

" neomake config
let g:neomake_python_enabled_makers = ['flake8', 'pylint']
"let g:neomake_python_enabled_makers = ['flake8']
"let g:neomake_python_enabled_makers = ['pylint']
"let g:neomake_python_pylint_maker = {
"    \ 'args': [
"      \ '--disable=I',
"    \ ],
"\ }
"let g:neomake_python_pylint_maker_args = [
"    \ '--disable=I'
"\ ]

let g:neomake_python_pylint_maker = {
        \ 'args': [
            \ '--disable=I',
            \ '--output-format=text',
            \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg} [{msg_id}]"',
            \ '--reports=no'
        \ ],
        \ 'errorformat':
            \ '%A%f:%l:%c:%t: %m,' .
            \ '%A%f:%l: %m,' .
            \ '%A%f:(%l): %m,' .
            \ '%-Z%p^%.%#,' .
            \ '%-G%.%#'
            \ }
" Neomake open location list
"let g:neomake_open_list = 2
augroup my_py_group
  autocmd BufWritePost *.py Neomake
  autocmd BufEnter *.py Neomake
augroup END
"autocmd TextChangedI *.py Neomake
" linting on the fly
" https://github.com/neomake/neomake/pull/1167
