" map Leader
let mapleader = ","
" keep backward f search, remapping it to ,;
nnoremap <Leader>; ,

" Disable Ex-mode because it's a pile of shit
nnoremap Q <nop>
" in-line scrolling
nnoremap <Leader>j gj
nnoremap <Leader>k gk

"" buffer keys
" List buffers
nnoremap <Leader>ls :ls<CR>
nnoremap <Leader>bb :b#<CR>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bf :bf<CR>
nnoremap <Leader>bl :bl<CR>
nnoremap <Leader>bw :w<CR>:bd<CR>
nnoremap <Leader>bd :bd!<CR>
"" new buffer/tab
nnoremap <Leader>e :enew<CR>

"" List marks
nnoremap <Leader>mls :marks<CR>

"" List registers
nnoremap <Leader>rls :reg<CR>


"" build tags - expand this to an async call for use within vim
"ctags -R --fields=+l --exclude=build,dist --languages=python -f ./tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))") $(pwd)
" ctags -R --fields=+l --exclude=build,dist --languages=C++,C -f ./tags $(pwd)
" ctags -R --fields=+liaS --exclude=build,dist --languages=C++,C -f ./tags $(pwd)

" window keys
nnoremap <Leader>w< <C-w><
nnoremap <Leader>w> <C-w>>
nnoremap <Leader>w- <C-w>-
nnoremap <Leader>w+ <C-w>+
nnoremap <Leader>ws :split<CR>
nnoremap <Leader>wv :vsplit<CR>
nnoremap <Leader>wx :close<CR>

"" %% to expand active buffer location on cmdline
"cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"" CtrlP keys
"nnoremap <Leader>pp :CtrlP<CR>
"nnoremap <Leader>pf :CtrlP<CR>
"nnoremap <Leader>pm :CtrlPMRUFiles<CR>
"nnoremap <Leader>pr :CtrlPMRUFiles<CR>
"nnoremap <Leader>pb :CtrlPBuffer<CR>

" Function keys
nnoremap <silent> <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <F3> :set hlsearch!<CR>
nnoremap <F5> :source $HOME/.config/nvim/init.vim<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
"nnoremap <F7> :UndotreeToggle<CR>
"nnoremap <F8> :Geeknote<CR>
" indent whole file according to syntax rules
noremap <F9> gg=G

"" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
"" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>
"" Don't use Ex mode, use Q for formatting
"map Q gq

"" toggle relative line numbers
nnoremap <Leader>rn :set relativenumber!<CR>

"" remap number increment to C-s (C-a is already in use by tmux)
"nnoremap <C-s> <C-a>
"
"" Word count selection
"vnoremap <Leader>w :w !wc -w<CR>

" vim paste mode toggle (for fixing indentation issues when pasting text)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"" override read-only permissions
"cmap w!! %!sudo tee > /dev/null %

"" allow ,, for vimsneak
"nnoremap <Leader>, <Plug>SneakPrevious

"" camelCase motion settings
"map <silent> w <Plug>CamelCaseMotion_w
"map <silent> b <Plug>CamelCaseMotion_b
"map <silent> e <Plug>CamelCaseMotion_e
"sunmap w
"sunmap b
"sunmap e

"" start interactive EasyAlign in visual mode (e.g. vip<Enter>)
"vmap <Enter> <Plug>(EasyAlign)

"" start interactive EasyAlign for a motion/text object (e.g. gaip)
"nnoremap ga <Plug>(EasyAlign)

" Preview window - mostly used with linters and neomake
" Apparently preview window unique per buffer
nnoremap <Leader>po :lopen<CR>
nnoremap <Leader>pc :lclose<CR>
nnoremap <Leader>p, :ll<CR>
nnoremap <Leader>pn :lnext<CR>
nnoremap <Leader>pp :lprev<CR>

" Quick fix window is apparently vim wide (shared with all buffers).
" Mostly used for external commands such as grep or internal like
" vimgrep etc. suffix with ! to override existing window (IE):
" `vimgrep!`
nnoremap <Leader>qo :copen<CR>
nnoremap <Leader>qc :cclose<CR>
nnoremap <Leader>q, :cl<CR>
nnoremap <Leader>qp :cprev<CR>
nnoremap <Leader>qn :cnext<CR>


" folding
"nnoremap <Leader>f zf%

"" tern
"autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
"
"" autocomplete
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"let g:UltiSnipsExpandTrigger="<C-j>"
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"
"" colorizer
nnoremap <Leader>tc :ColorToggle<CR>

" Terminal Mode Keybindings
tnoremap <A-Esc> <C-\><C-n>
tnoremap <S-Esc> <C-\><C-n>
"tnoremap <A-h> <C-\><C-n><C-w>h
"tnoremap <A-j> <C-\><C-n><C-w>j
"tnoremap <A-k> <C-\><C-n><C-w>k
"tnoremap <A-l> <C-\><C-n><C-w>l


" Line & Block movement key bindings
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv<Paste>
