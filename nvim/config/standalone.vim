" Adjust leader and provide a keybind to get to ,'s original function
" map Leader
let mapleader = " "
" keep backward f search, remapping it to ,;
" nnoremap <Leader>; ,

syntax on
syntax enable

set hlsearch

set number


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Set delay/timeout of key mapping sequences
set timeoutlen=2000

" Set vim swap file write frequency and various plugin update frequency
" like tagbar
set ut=50
" ut long form:
" set updatetime=50

" Disable vim swap files
" set noswap

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

" Set tags search location to always be within a sub-directory (so we can
" bind-mount it to /tmp etc.
"set tags=./.tags/tags,tags;

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

" default tab stuff - some file types are overriden in `ftplugin` section.
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

" Make things like substitute commands act incrementally, and provide
" offscreen operations in a preview window.  Command acts exactly the same,
" but shows you what will happen live.
set inccommand=split

" if exists("$VAMPIRE")
" "Lint files with neomake
" " When writing a buffer, reading a bufer, and on normal mode changes (after 750ms).
"   call neomake#configure#automake({
"   \ 'TextChanged': {},
"   \ 'InsertLeave': {},
"   \ 'BufWritePost': {'delay': 0},
"   \ 'BufWinEnter': {'delay': 0},
"   \ }, 750)
" endif

" Need to dynamically set this up depending on system?
let g:python_host_prog = '/home/sam/.python/neovim-py2/bin/python'
let g:python3_host_prog = '/home/sam/.python/neovim-py3/bin/python'
" let g:python_host_prog = '/usr/local/src/pyenvs/py2/neovim/bin/python'
" let g:python3_host_prog = '/usr/local/src/pyenvs/py3/neovim/bin/python'

" ################################################################################################
" ####### PLUGINS ################################################################################
" ################################################################################################

" Ensure vim plug is available
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.config/nvim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Give git hints on current buffer line: Add, Modify, Remove within NerdTree
Plug 'airblade/vim-gitgutter'

" Add colour highlighting for colours in NVim
Plug 'ap/vim-css-color'

" Vim TOML Syntax Highlighting
Plug 'cespare/vim-toml'

" Possibly replaced by telescope, below
"" Fuzzy file finder
"Plug 'ctrlpvim/ctrlp.vim'

" Dracular theme is a nice Dark Theme
Plug 'dracula/vim'
" BAse Terraform support.
Plug 'hashivim/vim-terraform'

" Lots of language file type highlighting
Plug 'hoelzro/vim-polyglot'

" Markdown Previewer
Plug 'JamshedVesuna/vim-markdown-preview'

" Vim RG integration
Plug 'jremmen/vim-ripgrep'

" Autocomplete support for terraform
Plug 'juliosueiras/vim-terraform-completion'

" (Optional) but needed if LanguageServer wants to display multiple
" completion candidates
" Plug 'junegunn/fzf', {'do': './install --all'}
" Plug 'junegunn/fzf'

" Add support for Typescript syntax
Plug 'leafgarland/typescript-vim'

" Support for typescript language syntax
Plug 'leafgarland/typescript-vim'

" Support for the Jinja Templating language
Plug 'lepture/vim-jinja'

" Most comprehensive tagging plugin for vim?
Plug 'ludovicchabant/vim-gutentags'

" Highlight yank regions
Plug 'machakann/vim-highlightedyank'

" source tree listing/menu containing definitions
Plug 'majutsushi/tagbar'

" Groovy syntax support
Plug 'modille/groovy.vim'

" JSX plugin
Plug 'mxw/vim-jsx'

" Adds support for using * and # keys with visual selection searching
Plug 'nelstrom/vim-visual-star-search'

"Async builder for Neovim
Plug 'neomake/neomake'

" Possibly replaced by TreeSitter...
"" Symantic python highlighting
"Plug 'numirias/semshi'

" Lua based LSP autocompletion
"Plug 'nvim-lua/completion-nvim', { 'commit': '3b6774ed1' }
Plug 'nvim-lua/completion-nvim'

" Lua based LSP Diagnostics plugin
" NOTE - This is built in on the very latest nightlies.  Keeping for use on
" older nvim's.
"Plug 'nvim-lua/diagnostic-nvim'

" Fancy, lua-based ctrl-p replacement
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'


" Context-aware syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Javascript language support
Plug 'pangloss/vim-javascript'

" Ansible File support in vim
Plug 'pearofducks/ansible-vim'

" Add support for i3 config files
Plug 'PotatoesMaster/i3-vim-syntax'

" Quickfix helpers
Plug 'romainl/vim-qf'

" Add the base rust syntax highlighting plugin
Plug 'rust-lang/rust.vim'

" Dev Icons in NERDTree...
Plug 'ryanoasis/vim-devicons'

" Vim NeoFormat -- Code formatting plugin
Plug 'sbdchd/neoformat'

" Epic Comment management
Plug 'scrooloose/nerdcommenter'

" File tree within vim
Plug 'scrooloose/nerdtree'

" " Async support for nvim calling out to python process
" Plug 'Shougo/deoplete.nvim'

" Source code folding pluggin
Plug 'tmhedberg/SimpylFold'

" Add support for the Gherkin file type
Plug 'tpope/vim-cucumber'

" Git functionaility within vim for git (status|diff|bisect|....others]
Plug 'tpope/vim-fugitive'

" Adds support for surround text with characters of your choosing
Plug 'tpope/vim-surround'

" powerline is fucked up, use vim-airline instead
Plug 'vim-airline/vim-airline'

" System-d syntax highlighting for systemd unit files
Plug 'wgwoods/vim-systemd-syntax'

" Give git hints on files/dirs regarding: Add, Modify, Remove within NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Visually display indentation
Plug 'Yggdroot/indentLine'

" LSP configurations
Plug 'neovim/nvim-lspconfig'

call plug#end()

" ################################################
" ############# Coloursheme settings #############
" ################################################

"Setup the colourscheme - Default to Dracula Theme
colorscheme dracula
color dracula

" If we are in a TrueColour terminal, use true colours
if has("termguicolors")
  set termguicolors
endif

" ################################################
" ########## General Appearance settings #########
" ################################################

" Setup the status/command line
set cmdheight=1
set display+=lastline

" general config
set laststatus=2 " always show status line
set showtabline=2 " always show tabline
set noshowmode " hide default mode text (e.g. INSERT) as airline already displays it

" Always highlight the row and column of the cursor. - Set an end of line
" marker at 100 chars.
set colorcolumn=100
set cursorline
set cursorcolumn

set ruler		" show the cursor position all the time
set cursorline

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256


" ################################################
" ############### General key maps #'#############
" ################################################

" Disable Ex-mode because it's a pile of shit
nnoremap Q <nop>

" copy absolute file path to system clipboard
nnoremap <Leader>yf :let @+ = expand('%:p')<CR>

" Add Ctrl+v Esc as terminal escape key
tnoremap <C-v><Esc> <C-\><C-n>

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
" Tweak Gutentags behaviour
let g:gutentags_cache_dir = '/tmp/gutentags'
let g:gutentags_ctags_tagfile = "tags"


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

" Function keys
nnoremap <silent> <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <F3> :set hlsearch!<CR>
nnoremap <F5> :source $HOME/.config/nvim/init.vim<CR>
nnoremap <Leader>e :NERDTreeToggle<CR>
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

" Location List - mostly used with linters and neomake
nnoremap <Leader>lo :lopen<CR>
nnoremap <Leader>lc :lclose<CR>
nnoremap <Leader>ll :ll<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>
nnoremap <Leader>lw :lexpr []<CR> " Clear location list (w for wipe)

" Preview Window - mostly used with linters and neomake
nnoremap <Leader>pc :pclose<CR>

" Quick fix window is apparently vim wide (shared with all buffers).
" Mostly used for external commands such as grep or internal like
" vimgrep etc. suffix with ! to override existing window (IE):
" `vimgrep!`
nnoremap <Leader>qo :copen<CR>
nnoremap <Leader>qc :cclose<CR>
nnoremap <Leader>ql :cl<CR>
nnoremap <Leader>qp :cprev<CR>
nnoremap <Leader>qn :cnext<CR>
nnoremap <Leader>qw :cexpr []<CR> " Clear quick fix (w for wipe)


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


" Attempt mapping ctrl-6 to ctrl-shift-6
nnoremap <C-6> <C-^>


nnoremap <Leader>tt :TagbarToggle<CR><C-w><C-w>


" ##################################################################################################
" ######## Airline Settings ########################################################################
" ##################################################################################################
" Make use of Powerline symbols
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" buffers at the top as tabs
let g:airline#extensions#tabline#enabled=1

" Shows buffer index which is not the buffer ID (buffer_id = :ls)
"let g:airline#extensions#tabline#buffer_idx_mode = 1

" shows buffer ID same as :ls
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline_symbols.linenr = '||'

"let g:airline_symbols.paste = 'ρ'

let g:airline_symbols.readonly = ''
"
" disable unused extensions (performance)
"let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#ctrlspace#enabled  = 1
let g:airline#extensions#tagbar#enabled     = 1
let g:airline#extensions#whitespace#enabled = 1

" ##################################################################################################
" ###### Ctrl-P Settings ###########################################################################
" ##################################################################################################

let g:ctrlp_prompt_mappings={'PrtClearCache()':['<Leader><F5>']}
let g:ctrlp_prompt_mappings={'PrtdeleteEnt()':['<Leader><F7>']}
let g:ctrlp_match_window='bottom,order:btt,min:2,max:25'
" ctrlp_open_multiple_files option default seems to be vertical split even though it was never set.
" Now multiple files are open as seperate buffers in seperate windows.
let g:ctrlp_open_multiple_files = 'i'
" Allow ctrlp to display hidden files
let g:ctrlp_show_hidden = 1
set wildmenu " enhanced autocomplete
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*node_modules*,*.jpg,*.png,*.svg,*.ttf,*.woff,*.woff3,*.eot,*public/css/*,*public/js*
set wildignore+=*.so,*.swp,*.zip,*node_modules*,*.jpg,*.png,*.svg,*.ttf,*.woff,*.woff3,*.eot,*public/css/*,*public/js*

" ##################################################################################################
" ###### Neoformat Settings ########################################################################
" ##################################################################################################
" Setup leader n f keybind to trigger beautification of the current buffer
nnoremap <leader>nf :Neoformat<CR>

" Setup leader n f keybind on visual mode to format the selection
vnoremap <leader>nf :Neoformat<CR>

" Store the path to the style.yapf (suggest you symlink to that location)
" The . in the args line is a string concatenation (+ is numeric only...)
let g:yapf_config_path = resolve(expand('~/.style.yapf'))
let g:neoformat_python_yapf = {
    \ 'exe': 'yapf',
    \ 'args': ['--style ' . yapf_config_path],
    \ 'stdin': 1,
    \ }

let g:neoformat_enabled_python = ['yapf']
" let g:neoformat_enabled_python = ['black']

let g:neoformat_json_pyjson = {
    \ 'exe': 'python',
    \ 'args': ['-m', 'json.tool'],
    \ 'stdin': 1,
    \ }
" python -m json.tool
let g:neoformat_enabled_json = ['pyjson']

let g:neoformat_enabled_clangformat = ['clang-format']

let g:neoformat_enabled_cmakeformat = ['cmake-format']

" #################################################################################################
" ####### NERDTree Settings #######################################################################
" #################################################################################################
" Settings to tweak the NERDTree configuration.

let g:NERDTreeQuitOnOpen=3  " Close the window after opening a file.
let g:NERDTreeShowLineNumbers=1  " Show Line Numbers in the NERDTree window
let g:NERDTreeNaturalSort=1  " Sort using natural numbers, i.e. 1.txt, 2.txt, 10.txt

" Try putting dirs after files in NERDTree view
" See :h NERDTreeSortOrder for more info
let g:NERDTreeSortOrder=['*', '\.swp$',  '\.bak$', '\~$', '\/$']

" Experiment with this to see how things look.
" let NERDTreeNodeDelimiter="\x07"     "bell
" let g:NERDTreeNodeDelimiter="\u00b7"   "middle dot
" let NERDTreeNodeDelimiter="\u00a0"   "non-breaking space
" let NERDTreeNodeDelimiter="😀"       "smiley face

" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 0


" Add a Modeline function, appends modeline after last line in buffer.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>


" #################################################################################################
" ####### LSP Settings ############################################################################
" #################################################################################################
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" LSP Bindings
nnoremap <Leader>ldf   <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>ldc   <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <Leader>ldt   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <Leader>li    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>lh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>la    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <Leader>ls    <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>lr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <Leader>lds   <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <Leader>lws   <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" LSP Completion
" Use LSP omni-completion in Python files.
autocmd Filetype python  setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype cpp     setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype c       setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype cmake   setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype yaml    setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype sh      setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Enable several LSP's
lua <<EOF
-- Wrapper on attach function to call both diagnostic and completion attach functions.
local on_attach_wrapper = function(client)
  require'completion'.on_attach(client)
end


require'lspconfig'.pyls.setup{
  on_attach=on_attach_wrapper,
  settings = {
    pyls = {
      plugins = {
        configurationSources = { "flake8" },
        flake8 = {
          enabled = true
        },
        pycodestyle = {
          enabled = false
        },
        pyflakes = {
          enabled = true
        },
        pylint =  {
          enabled = true
        },
        pyls_mypy = {
          enabled = true,
          live_mode = true
        }
      }
    }
  }
}

require'lspconfig'.clangd.setup{on_attach=on_attach_wrapper}
require'lspconfig'.cmake.setup{on_attach=on_attach_wrapper}
require'lspconfig'.yamlls.setup{on_attach=on_attach_wrapper}
require'lspconfig'.bashls.setup{on_attach=on_attach_wrapper}
require'lspconfig'.rust_analyzer.setup{on_attach=on_attach_wrapper}
EOF

" Use completion-nvim in every buffer
"autocmd BufEnter * lua require'completion'.on_attach()

" Tresitter configuration for more awesome highlighting.
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

function! LSClients()
  :lua print(vim.inspect(vim.lsp.buf_get_clients()))
endfunction
com! LSClients call LSClients()

function! LSRestart()
  :lua vim.lsp.stop_client(vim.lsp.get_active_clients())
  :edit
endfunction
com! LSRestart call LSRestart()


" Use Treesitter grammar for code folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Telescope setup:
nnoremap <c-p>       <cmd>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <Leader>rg  <cmd>lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <Leader>ts  <cmd>lua require'telescope.builtin'.treesitter{}<CR>

" Configure LSP Diagnostics
lua<<EOF
-- Source: https://www.reddit.com/r/backtickbot/comments/jua6d9/httpsredditcomrneovimcommentsjt9tqmnew_builtin/
-- Function to handle the diagnostics themselves
diagHandler = diagHandler or vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable virtual text
    virtual_text = {
      spacing = 2,
      prefix = ' ',
    },

    -- Enable signs
    signs = true,

    -- Disable underlining - its confusing!
    underline = false,

  }
)

-- Bind the above handler, but also update the location list
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, method, params, client_id, bufnr, config)
  local uri = params.uri

  --   diagHandler(err, method, params, client_id, bufnr, config)
  pcall(diagHandler, err, method, params, client_id, bufnr, config)

  bufnr = bufnr or vim.uri_to_bufnr(uri)

  if bufnr == vim.api.nvim_get_current_buf() then
    vim.lsp.diagnostic.set_loclist { open_loclist = false }
  end
end
EOF
