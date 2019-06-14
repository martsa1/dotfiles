" Notes check h: LanguageClient docs for how to set settings for specific
" language types... bottom of this file is a shit attempt at doing just that
" should probably change it for what is set in the official docs
let g:LanguageClient_autoStart = 1
" Control hover preview behavior
" Default: "Auto"
" Valid options: "Never", "Auto", "Always"
let g:LanguageClient_hoverPreview = "Always"
let g:LanguageClient_serverCommands = {}

" Put LSP output into location list rather than quickfix by default
let g:LanguageClient_diagnosticsList = "Location"

" waitOutputTimeout default is 10
"let g:LanguageClient_waitOutputTimeout = 10
"
" We can load language server settings instead of setting
" them here?
" default: ".vim/settings.json"
"let g:LanguageClient_settingsPath = <insert settings file path here>

" default: 0
" values: 0, 1
"let g:LanguageClient_loadSettings = 0

" Controls how frequently client sends server text changes
" default is disabled
" value: in seconds
"let g:LanguageClient_changeThrottle = 0.5

" Whether to bring up hover info for current cursor position
" Valid options: 'Never', 'Auto', 'Always'
" default: 'Auto'
"let g:LanguageClient_hoverPreview = 'Auto'

" set root maker for project path? not sure how this is useful
" supports path globbing
"let g:LanguageClient_rootMarkers = ['.root', 'project.*']
" OR
"let g:LanguageClient_rootMarkers = {
"    \ 'javascript': ['project.json'],
"    \ 'rust': ['Cargo.toml'],
"    \ 'python': ['pyproject.toml', '.root', 'setup.py', '.git'],
"    \ }

let g:LanguageClient_serverCommands.python = ['pyls', '-vv', '--log-file', '/tmp/pyls.log']

" Minimal LSP configuration for JavaScript
"if executable('javascript-typescript-stdio')
"  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  " Use LanguageServer for omnifunc completion
"  autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
"else
"  echo "javascript-typescript-stdio not installed!\n"
"  :cq
"endif

"nnoremap <silent> <C-S> :call LanguageClient#textDocument_completion()<cr>
" document highlight will show occurances of things... but it's not very
" accurate and default settings only underscores the text.. would be good to
" use color instead
"nnoremap <silent> <Leader>lhs :call LanguageClient#textDocument_documentHighlight()<cr>
"nnoremap <silent> <Leader>lhc :call LanguageClient#clearDocumentHighlight()<cr>
" Format all text within the given range (visual selection? line number
" range?)
nnoremap <silent> <Leader>lrf :call LanguageClient#textDocument_rangeFormatting()<cr>
" Format all text (in the current buffer? or is all files? need to find out)
nnoremap <silent> <Leader>lf :call LanguageClient_textDocument_formatting()<cr>
" Show all available Language Client actions -- worth changing binding
" to something that would work in insert mode
nnoremap <silent> <Leader>lmc :call LanguageClient_contextMenu()<cr>
" Go to implementation under the cursor
" No matter using _ or # still get: 'Method Not Found: textDocument/implementation'
" Is it to do with statically compiled languages and python doesn't support
" this feature? or is it just simply not implemented yet?
"nnoremap <silent> <Leader>lim :call LanguageClient_textDocument_implementation()<cr>
nnoremap <silent> <Leader>lim :call LanguageClient#textDocument_implementation()<cr>
" Find all references to what is under the current cursor position
nnoremap <silent> <Leader>lu :call LanguageClient#textDocument_references()<cr>
" Go to definition under cursor -- (statically and dynamically typed languages)
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>ld :call LanguageClient_textDocument_definition()<cr>
" Go to TYPE definition under cursor  -- (staticly typed languages)
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>ltd :call LanguageClient_textDocument_definition()<cr>
" Show docs for symbol under cursor
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>lho :call LanguageClient_textDocument_hover()<cr>
" Rename variable under cursor
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>lr :call LanguageClient_textDocument_rename()<cr>
" List all symbols within the buffer
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>
" List all symbols under the cursor
autocmd FileType javascript,python nnoremap <buffer>
  \ <leader>lR :call LanguageClient_textDocument_references()<cr>
