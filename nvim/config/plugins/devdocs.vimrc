" Setup an autogroup that allows us to use Shift-K to search for langauge
" specific documentation using devdocs.

"augroup plugin-devdocs
"  autocmd!
"  autocmd FileType c,cpp,rust,haskell,python,yaml,javascript,vim nnoremap <leader>k <Plug>(devdocs-under-cursor)
"augroup END

" Setup leader k keybind
nnoremap  :DevDocsUnderCursor<CR>

" Make devdocs lookup language specific help.
let g:devdocs_filetype_map = {
    \   'python': 'python',
    \   'javascript.jsx': 'react',
    \   'html': 'html',
    \   'css': 'css',
    \   'sass': 'sass',
    \ }
