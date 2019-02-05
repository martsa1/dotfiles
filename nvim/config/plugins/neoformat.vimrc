" Keybindings for the Neoformat code beautification tool, allows simple
" integration with a variety of code beautification tools like Yapf for python
" and uncrustify for C.

" Setup leader n f keybind to trigger beautification of the current buffer
nnoremap <leader>nf :Neoformat<CR>

" Setup leader n f keybind on visual mode to format the selection
vnoremap <leader>nf :Neoformat<CR>

" Store the path to the style.yapf (suggest you symlink to that location)
" The . in the args line is a string concatenation (+ is numeric only...)
let g:yapf_config_path = resolve(expand('~/.style.yapf'))
let g:neoformat_python_yapf = {
    \ 'exe': 'yapf',
    \ 'args': ['--style ' . yapf_config_path],
    \ 'stdin': 1,
    \ }

let g:neoformat_enabled_python = ['yapf']
