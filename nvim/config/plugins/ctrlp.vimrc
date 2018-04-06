let g:ctrlp_prompt_mappings={'PrtClearCache()':['<Leader><F5>']}
let g:ctrlp_prompt_mappings={'PrtdeleteEnt()':['<Leader><F7>']}
let g:ctrlp_match_window='bottom,order:btt,min:2,max:25'
" ctrlp_open_multiple_files option default seems to be vertical split even though it was never set.
" Now multiple files are open as seperate buffers in seperate windows.
let g:ctrlp_open_multiple_files = 'i'
" Allow ctrlp to display hidden files
let g:ctrlp_show_hidden = 1
set wildmenu " enhanced autocomplete
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*node_modules*,*.jpg,*.png,*.svg,*.ttf,*.woff,*.woff3,*.eot,*public/css/*,*public/js*



"" CtrlP keys
"nnoremap <Leader>pp :CtrlP<CR>
"nnoremap <Leader>pf :CtrlP<CR>
"nnoremap <Leader>pm :CtrlPMRUFiles<CR>
"nnoremap <Leader>pr :CtrlPMRUFiles<CR>
"nnoremap <Leader>pb :CtrlPBuffer<CR>

