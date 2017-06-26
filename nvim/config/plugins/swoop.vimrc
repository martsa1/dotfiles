"Plug 'pelodelfuego/vim-swoop'

let g:swoopUseDefaultKeyMap = 0

set nnoremap <Leader>ss :call Swoop()<CR>
set vnoremap <Leader>ss :call SwoopSelection()<CR>

set nnoremap <Leader>sm :call SwoopMulti()<CR>
set vnoremap <Leader>sm :call SwoopMultiSelection()<CR>
