

" powerline config
" example vim binding
"set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
"let g:powerline_pycmd="py3"
"set rtp+=/usr/local/src/pyenvs/py3/powerline_status/lib/python3.5/site-packages/powerline/bindings/vim/
"set rtp+=/usr/local/src/pyenvs/py2/powerline_status/lib/python2.7/site-packages/powerline/bindings/vim/
"set rtp+=/home/mhahe/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Make use of Powerline symbols
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled=1  " buffers at the top as tabs

" Shows buffer index which is not the buffer ID (buffer_id = :ls)
"let g:airline#extensions#tabline#buffer_idx_mode = 1
" shows buffer ID same as :ls
let g:airline#extensions#tabline#buffer_nr_show = 1

" let g:airline#extensions#tabline#show_tabs=0
"let g:airline#extensions#tabline#show_tab_type=0
"let g:airline#extensions#tmuxline#enabled=0
"let g:airline_theme = 'base16_pop'
"
let g:airline_symbols.linenr = '||'
"let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.readonly = ''
"
"let g:airline#extensions#quickfix#quickfix_text = 'QF'
"let g:airline#extensions#quickfix#location_text = 'LL'

" disable unused extensions (performance)
"let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline#extensions#bufferline#enabled = 1
"let g:airline#extensions#capslock#enabled   = 0
"let g:airline#extensions#csv#enabled        = 0
let g:airline#extensions#ctrlspace#enabled  = 1
"let g:airline#extensions#eclim#enabled      = 1
"let g:airline#extensions#hunks#enabled      = 0
"let g:airline#extensions#nrrwrgn#enabled    = 0
"let g:airline#extensions#promptline#enabled = 0
"let g:airline#extensions#syntastic#enabled  = 0
"let g:airline#extensions#taboo#enabled      = 0
let g:airline#extensions#tagbar#enabled     = 1
"let g:airline#extensions#virtualenv#enabled = 0
"let g:airline#extensions#whitespace#enabled = 0

" tmuxline config
" let g:tmuxline_preset = {
"         \ 'a': '#S',
"         \ 'b': '#F',
"         \ 'c': '#W',
"         \ 'win': ['#I', '#W'],
"         \ 'cwin': ['#I', '#W'],
"         \ 'x': '#h',
"         \ 'y': '%b %d',
"         \ 'z': '%R'}
