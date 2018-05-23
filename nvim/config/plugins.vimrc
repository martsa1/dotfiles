"filetype plugin indent on
" completion
"autocmd CompleteDone * pclose!
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" This might not be needed
"  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
augroup end



" deoplete options
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('jedi', 'debug_enabled', 1)
call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')
" Sane version of complete_method
"let g:deoplete#complete_method = "complete"

" deoplete-jedi options
"let g:deoplete#sources#jedi#show_docstring = 0
"let g:deoplete#sources#jedi#debug_server = 1

" Tagbar
nnoremap <Leader>tt :TagbarToggle<CR><C-w><C-w>
" jedi --- test if jedi-vim options work with deoplete-jedi
"let g:jedi#goto_command = "<leader>d"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = ""
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<C-Space>"
"let g:jedi#rename_command = "<leader>r"
"let g:jedi#show_call_signatures = 2

" NOTE: deoplete#custom#source seems to be a replacement for
" deoplete#sources#LANGUAGE = "completion server" but leaving as is for now
" and will come back to investigate
" the later seems to be dropped in change notes, but oddly things are still working

" deoplete python
let g:deoplete#sources#python = "LanguageClient"
let g:deoplete#sources#python3 = "LanguageClient"

" deoplete-go
let g:deoplete#sources#go#gocode_binary = $HOME . '/go/bin/gocode'

" deoplete-rust
let g:deoplete#sources#rust#racer_binary = $HOME . '/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = $HOME . '/bare_sources/rust/src'
