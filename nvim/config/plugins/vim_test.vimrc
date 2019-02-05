nnoremap <Leader>tn :TestNearest<CR> " ,tn
nnoremap <Leader>tf :TestFile<CR>    " t Ctrl+f
nnoremap <Leader>ts :TestSuite<CR>   " t Ctrl+s
nnoremap <Leader>tl :TestLast<CR>    " t Ctrl+l
nnoremap <Leader>tg :TestVisit<CR>   " t Ctrl+g

" Make Test output pop up asynchronously in the quickfix window
let test#strategy = "neomake"

" " Allows the test system to auto-run when relevant files have been changed
" augroup test
"   " Ensure that the test autogroup is not duplicated by clearing it first
"   autocmd!
"   " Runs Vim-Test's Test File command if a test exists in the current buffer.
"   autocmd BufWrite * if test#exists()
"         \ | TestFile
"         \ | endif
" augroup END
"
