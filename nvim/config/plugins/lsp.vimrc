let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}

let g:LanguageClient_serverCommands.python = ['pyls']

" Map renaming in python
autocmd FileType python nnoremap <buffer>
  \ <leader>lr :call LanguageClient_textDocument_rename()<cr>
" <leader>ld to go to definition
autocmd FileType python nnoremap <buffer>
  \ <leader>ld :call LanguageClient_textDocument_definition()<cr>
" <leader>lh for type info under cursor
autocmd FileType python nnoremap <buffer>
  \ <leader>lh :call LanguageClient_textDocument_hover()<cr>

" Minimal LSP configuration for JavaScript
"if executable('javascript-typescript-stdio')
"  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  " Use LanguageServer for omnifunc completion
"  autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
"else
"  echo "javascript-typescript-stdio not installed!\n"
"  :cq
"endif

" <leader>ld to go to definition
autocmd FileType javascript nnoremap <buffer>
  \ <leader>ld :call LanguageClient_textDocument_definition()<cr>
" <leader>lh for type info under cursor
autocmd FileType javascript nnoremap <buffer>
  \ <leader>lh :call LanguageClient_textDocument_hover()<cr>
" <leader>lr to rename variable under cursor
autocmd FileType javascript nnoremap <buffer>
  \ <leader>lr :call LanguageClient_textDocument_rename()<cr>
