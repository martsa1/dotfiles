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



" deoplete
" This appears to be needed on, otherwise nothing works
let g:deoplete#enable_at_startup = 1
" Sane version of complete_method
let g:deoplete#complete_method = "complete"
" This setting seems to screw with ctrl+space completion
"let g:deoplete#complete_method = "omnifunc"
let g:deoplete#sources#jedi#debug_server = 1
" Not about this one.
let g:deoplete#sources#jedi#show_docstring = 0
call deoplete#custom#set('jedi', 'debug_enabled', 1)
"call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')

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

" deoplete-go

let g:deoplete#sources#go#gocode_binary = $HOME . '/go/bin/gocode'

" deoplete-rust

let g:deoplete#sources#rust#racer_binary = $HOME . '/.cargo/bin/racer'

let g:deoplete#sources#rust#rust_source_path = $HOME . '/bare_sources/rust/src'
