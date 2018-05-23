syntax on
syntax enable

set hlsearch

set number


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Set delay/timeout of key mapping sequences
set timeoutlen=4000

" http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set undodir=~/.config/nvim/undodir
set undofile
set undolevels=100
set undoreload=1000

set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/backup

set ruler		" show the cursor position all the time
set cursorline

set showcmd		" display incomplete commands

if has('mouse')
  set mouse=a
endif

if has("autocmd")

  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 100 characters.
    autocmd FileType text setlocal textwidth=100

    " Trim whitespace onsave
    autocmd BufWritePre * %s/\s\+$//e

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END

endif " has("autocmd")

" tab stuff
filetype plugin indent on
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
"set tabstop=4
"set softtabstop=4
"set expandtab
"set smarttab
"set shiftwidth=4
"set autoindent
"set smartindent

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

" detect .md as markdown instead of modula-2
augroup filetype_html
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END

" Unix as standard file type
set ffs=unix,dos,mac

" Always utf8
set termencoding=utf-8
set encoding=utf-8
"set fileencoding=utf-8
setglobal fileencoding=utf-8

set so=5 " scroll lines above/below cursor
set sidescrolloff=5
set lazyredraw

set magic " for regular expressions

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if has('path_extra')
  setglobal tags-=./tags tags^=./tags;
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif

" viminfo is deprecated, this should use shada instead
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" buffer settings
set hid " buffer becomes hidden when abandoned

" stop highlighting of underscores in markdown files
augroup filetype_html
  autocmd BufNewFile,BufRead,BufEnter *.md,*.markdown :syntax match markdownIgnore "_"
augroup END

set completeopt=longest,menuone
set completeopt-=preview

"Lint files with neomake
" When writing a buffer, reading a bufer, and on normal mode changes (after 750ms).
call neomake#configure#automake({
\ 'TextChanged': {},
\ 'InsertLeave': {},
\ 'BufWritePost': {'delay': 0},
\ 'BufWinEnter': {'delay': 0},
\ }, 750)

let g:python_host_prog = '/usr/local/src/pyenvs/py2/neovim/bin/python'
let g:python3_host_prog = '/usr/local/src/pyenvs/py3/neovim/bin/python'
