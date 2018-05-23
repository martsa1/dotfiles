let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}

let g:LanguageClient_serverCommands.python = ['pyls']

" Minimal LSP configuration for JavaScript
"if executable('javascript-typescript-stdio')
"  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  " Use LanguageServer for omnifunc completion
"  autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
"else
"  echo "javascript-typescript-stdio not installed!\n"
"  :cq
"endif

" Go to definition under cursor
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>ld :call LanguageClient_textDocument_definition()<cr>
" Show docs for symbol under cursor
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>lh :call LanguageClient_textDocument_hover()<cr>
" Rename variable under cursor
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>lr :call LanguageClient_textDocument_rename()<cr>
" List all symbols within the buffer
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>
" List all symbols under the cursor
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>lR :call LanguageClient_textDocument_references()<cr>
