-- map Leader to space
vim.g.mapleader = ' '

--syntax on
--syntax enable
vim.opt.syntax = 'on'

vim.opt.hlsearch = true

vim.opt.number = true

-- Ensure vim plug is available
-- TODO: bootstrap packer, not Plug here...
--let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.config/nvim'
--if empty(glob(data_dir . '/autoload/plug.vim'))
--  echom "Vim-Plug not found, attempting to install."
--  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
--  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
--endif


-- allow backspacing over everything in insert mode
vim.opt.backspace = {'indent','eol','start'}

-- Set delay/timeout of key mapping sequences
vim.opt.timeoutlen =2000

-- Set vim swap file write frequency and various plugin update frequency
-- like tagbar
vim.opt.updatetime=50

-- TODO: Not sure this does anything anymore
vim.cmd([[
if has("vms")
  set nobackup "do not keep a backup file, use versions instead
else
  set backup "keep a backup file
endif
]])

-- PReserve undo-history per buffer
vim.opt.undodir=vim.fs.normalize("~/.config/nvim/undodir")
vim.opt.undofile = true
vim.opt.undolevels=100
vim.opt.undoreload=1000

vim.opt.backupdir=vim.fs.normalize("~/.config/nvim/backup")

-- TODO this will hide swap files away from source buffers, not sure if I actually want that...
vim.opt.directory=vim.fs.normalize("~/.config/nvim/backup")

vim.opt.showcmd = true		-- display incomplete commands

if vim.fn.has('mouse') then
  vim.opt.mouse='a'
end

if vim.fn.has("autocmd") then
  -- TODO: Setup lua-powered autocommands...
  vim.cmd([[
  augroup vimrcEx
    au!

    "For all text files set 'textwidth' to 100 characters.
    autocmd FileType text setlocal textwidth=100

    "-- Trim whitespace onsave
    autocmd BufWritePre * %s/\s\+$//e

    "-- When editing a file, always jump to the last known cursor position.
    "-- Don't do it when the position is invalid or when inside an event handler
    "-- (happens when dropping a file on gvim).
    "-- Also don't do it when the mark is in the first line, that is the default
    "-- position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END
  ]])

end -- has("autocmd")

-- default tab stuff - some file types are overriden in `ftplugin` section.
vim.opt.autoindent=true
vim.opt.expandtab=true
vim.opt.shiftwidth=0  -- match tabstop
vim.opt.smartindent=true
vim.opt.smarttab=true
vim.opt.softtabstop=2
vim.opt.tabstop=4

-- Allow 100ms between keys in a key-sequence.  Defaults to 1000ms
vim.opt.ttimeout = true
vim.opt.ttimeoutlen=100

-- TODO: A - do I actually still need this, b. move it to lua-powered autocommand.
-- detect .md as markdown instead of modula-2
vim.cmd([[
augroup filetype_html
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END
]])

-- Unix as standard file type
vim.opt.ffs={'unix' ,'dos','mac'}

-- Always utf8
vim.opt.fileencoding='utf-8'

vim.opt.scrolloff=5 -- lines above/below cursor to keep visible
vim.opt.sidescrolloff=5 -- horizontal columns to keep visible either side of the cursor

-- TODO: Not sure this setting is meant to be generally set.
--vim.opt.lazyredraw = true

vim.opt.listchars="tab:>\\ ,trail:-,extends:>,precedes:<,nbsp:+"

vim.opt.autoread = true

vim.opt.history=1000
vim.opt.tabpagemax=50

-- Look into whether I should customise ShaDa
-- Look into whether I need to tweak default sessionoptions

-- buffer settings
-- TODO: This is default in nvim, could remove
vim.opt.hid = true -- buffer becomes hidden when abandoned

-- stop highlighting of underscores in markdown files
-- TODO: Do I actually need this in the treesitter era..?
vim.cmd([[
augroup filetype_html
  autocmd BufNewFile,BufRead,BufEnter *.md,*.markdown :syntax match markdownIgnore "_"
augroup END
]])

-- Make things like substitute commands act incrementally, and provide offscreen operations
-- in a preview window.  Command acts exactly the same, but shows you what will happen live.
vim.opt.inccommand='split'

-- TODO: Do I actually make any use of neomake nowadays?  Perhaps it can go...
-- "Lint files with neomake
-- -- When writing a buffer, reading a bufer, and on normal mode changes (after 750ms).
--   call neomake#configure#automake({
--   \ 'TextChanged': {},
--   \ 'InsertLeave': {},
--   \ 'BufWritePost': {'delay': 0},
--   \ 'BufWinEnter': {'delay': 0},
--   \ }, 750)
-- endif

-- ################################################################################################
-- ####### PLUGINS ################################################################################
-- ################################################################################################

-- TODO: Migrate to packer!!
vim.cmd([[
call plug#begin('~/.config/nvim/plugged')

"-- Give git hints on current buffer line: Add, Modify, Remove within NerdTree
Plug 'airblade/vim-gitgutter'

"-- Add colour highlighting for colours in NVim
Plug 'ap/vim-css-color'

"-- Vim TOML Syntax Highlighting
Plug 'cespare/vim-toml'

"-- Dracular theme is a nice Dark Theme
Plug 'dracula/vim'

"-- Diagnostics (linters etc.) plugin
Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'

"-- Neovim LSP config
Plug 'folke/neodev.nvim'

"-- Base Terraform support.
Plug 'hashivim/vim-terraform'

"-- Lots of language file type highlighting
"-- TODO: Can this be removed now that I heavily use treesitter for highlighting?
"-- Plug 'hoelzro/vim-polyglot'

"-- Completion stuff...
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

"-- Icons set used by folke/trouble.
Plug 'kyazdani42/nvim-web-devicons'

"-- Markdown Previewer
Plug 'JamshedVesuna/vim-markdown-preview'

"-- Vim RG integration
Plug 'jremmen/vim-ripgrep'

"-- Autocomplete support for terraform
Plug 'juliosueiras/vim-terraform-completion'

"-- For luasnip users.
 Plug 'L3MON4D3/LuaSnip'
 Plug 'saadparwaiz1/cmp_luasnip'

"-- Add support for Typescript syntax
Plug 'leafgarland/typescript-vim'

"-- Support for typescript language syntax
Plug 'leafgarland/typescript-vim'

"-- Support for the Jinja Templating language
Plug 'lepture/vim-jinja'

"-- Most comprehensive tagging plugin for vim?
Plug 'ludovicchabant/vim-gutentags'

"-- Highlight yank regions
Plug 'machakann/vim-highlightedyank'

"-- source tree listing/menu containing definitions
Plug 'majutsushi/tagbar'

"-- Groovy syntax support
Plug 'modille/groovy.vim'

"-- JSX plugin
Plug 'mxw/vim-jsx'

"-- Adds support for using * and # keys with visual selection searching
Plug 'nelstrom/vim-visual-star-search'

"-- Async builder for Neovim
Plug 'neomake/neomake'

"-- LSP configurations
Plug 'neovim/nvim-lspconfig'

"-- Fancy, lua-based ctrl-p replacement
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

"-- Context-aware syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"-- Javascript language support
Plug 'pangloss/vim-javascript'

"-- Ansible File support in vim
Plug 'pearofducks/ansible-vim'

"-- Add support for i3 config files
Plug 'PotatoesMaster/i3-vim-syntax'

"-- Clangd LSP extensions support.
Plug 'p00f/clangd_extensions.nvim'

"-- Snippets collection
Plug 'rafamadriz/friendly-snippets'

"-- Quickfix helpers
Plug 'romainl/vim-qf'

"-- Hopefully deprecated in favour of treesitter + LSP...
"-- Add the base rust syntax highlighting plugin
"-- Plug 'rust-lang/rust.vim'

"-- Dev Icons in NERDTree...
Plug 'ryanoasis/vim-devicons'

"-- Vim NeoFormat -- Code formatting plugin
Plug 'sbdchd/neoformat'

"-- Epic Comment management
Plug 'scrooloose/nerdcommenter'

"-- File tree within vim
Plug 'scrooloose/nerdtree'

"-- Rust specific LSP extensions
Plug 'simrat39/rust-tools.nvim'

"-- Source code folding pluggin
Plug 'tmhedberg/SimpylFold'

"-- Add support for the Gherkin file type
Plug 'tpope/vim-cucumber'

"-- Git functionaility within vim for git (status|diff|bisect|....others]
Plug 'tpope/vim-fugitive'

"-- Adds support for surround text with characters of your choosing
Plug 'tpope/vim-surround'

"-- powerline is fucked up, use vim-airline instead
Plug 'vim-airline/vim-airline'

"-- Systemd syntax highlighting for systemd unit files
Plug 'wgwoods/vim-systemd-syntax'

"-- Give git hints on files/dirs regarding: Add, Modify, Remove within NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'

"-- Visually display indentation
Plug 'Yggdroot/indentLine'

call plug#end()
]])

-- ################################################
-- ############# Colourscheme settings ############
-- ################################################

-- Setup the colourscheme - Default to Dracula Theme
vim.cmd.colorscheme('dracula')

-- If we are in a TrueColour terminal, use true colours
if vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
end

-- ################################################
-- ########## General Appearance settings #########
-- ################################################

-- In case we're inside a gui, set the font and size to fira-code.
vim.opt.guifont= 'FiraCode Nerd Font Mono:h10'

-- general config
vim.opt.showtabline=2 -- always show tabline
-- TODO: is this setting actually needed?
-- TODO: Airline could very well be replaced
vim.opt.showmode  = false -- hide default mode text (e.g. INSERT) as airline already displays it

-- Always highlight the row and column of the cursor. - Set an end of line
-- marker at 100 chars.
vim.opt.colorcolumn='100'
vim.opt.cursorline=true
vim.opt.cursorlineopt = 'number'
vim.opt.cursorcolumn = true

vim.opt.ruler = true		-- show the cursor position all the time

-- ################################################
-- ############### General key maps ###############
-- ################################################

-- TODO: Look into which-key or similar to make this a bit more ergonomic

-- Disable Ex-mode because it's a pile of shit
--vim.keymap.del('n', 'Q')

-- copy absolute file path to system clipboard
vim.keymap.set(
  'n',
  '<Leader>yf',
  function ()
    local buf_path = vim.api.nvim_buf_get_name(0)
    vim.fn.setreg('+', buf_path)
  end
)

-- Add Ctrl+v Esc as terminal escape key
vim.keymap.set('t', '<C-v><Esc>', '<C-\\><C-n>')

-- in-line scrolling
vim.keymap.set('n', '<Leader>j', 'gj')
vim.keymap.set('n', '<Leader>k', 'gk')

-- buffer keys
-- List buffers
vim.keymap.set('n', '<Leader>ls', ':ls<CR>')
vim.keymap.set('n', '<Leader>bb', ':b#<CR>')
vim.keymap.set('n', '<Leader>bn', ':bn<CR>')
vim.keymap.set('n', '<Leader>bp', ':bp<CR>')
vim.keymap.set('n', '<Leader>bf', ':bf<CR>')
vim.keymap.set('n', '<Leader>bl', ':bl<CR>')
vim.keymap.set('n', '<Leader>bw', ':w<CR>:bd<CR>')
vim.keymap.set('n', '<Leader>bd', ':bd!<CR>')
-- new buffer/tab
vim.keymap.set('n', '<Leader>e', ':enew<CR>')

-- -- List marks
vim.keymap.set('n', '<Leader>mls', ':marks<CR>')

-- -- List registers
vim.keymap.set('n', '<Leader>rls', ':reg<CR>')

-- Remap markdown preview as we want Ctrl+p for other things...
vim.o.vim_markdown_preview_hotkey='<C-S-p>'


-- build tags - expand this to an async call for use within vim
-- ctags -R --fields=+l --exclude=build,dist --languages=python -f ./tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))") $(pwd)
-- ctags -R --fields=+l --exclude=build,dist --languages=C++,C -f ./tags $(pwd)
-- ctags -R --fields=+liaS --exclude=build,dist --languages=C++,C -f ./tags $(pwd)
-- Tweak Gutentags behaviour
vim.go.gutentags_cache_dir = '/tmp/gutentags'
vim.go.gutentags_ctags_tagfile = 'tags'


-- window keys
vim.keymap.set('n', '<Leader>w<', '<C-w><')
vim.keymap.set('n', '<Leader>w>', '<C-w>>')
vim.keymap.set('n', '<Leader>w-', '<C-w>-')
vim.keymap.set('n', '<Leader>w+', '<C-w>+')
vim.keymap.set('n', '<Leader>ws', ':split<CR>')
vim.keymap.set('n', '<Leader>wv', ':vsplit<CR>')
vim.keymap.set('n', '<Leader>wx', ':close<CR>')

-- %% to expand active buffer location on cmdline
-- cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

-- Function keys
vim.keymap.set('n', '<F3>', ':set hlsearch!<CR>')
vim.keymap.set('n', '<F5>', ':source $HOME/.config/nvim/init.vim<CR>')
vim.keymap.set('n', '<Leader>e', ':NERDTreeToggle<CR>')
-- nnoremap <F7> :UndotreeToggle<CR>
-- indent whole file according to syntax rules
vim.keymap.set('n', '<F9>', 'gg=G')

-- CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
-- inoremap <C-U> <C-G>u<C-U>
-- Don't use Ex mode, use Q for formatting
-- map Q gq

-- toggle relative line numbers
vim.keymap.set('n', '<Leader>rn', ':set relativenumber!<CR>')

-- vim paste mode toggle (for fixing indentation issues when pasting text)
vim.keymap.set('n', '<F2>', ':set invpaste paste?<CR>')
vim.opt.showmode = true

-- Location List - mostly used with linters and neomake
vim.keymap.set('n', '<Leader>lo', ':lopen<CR>')
vim.keymap.set('n', '<Leader>lc', ':lclose<CR>')
vim.keymap.set('n', '<Leader>ll', ':ll<CR>')
vim.keymap.set('n', '<Leader>ln', ':lnext<CR>')
vim.keymap.set('n', '<Leader>lp', ':lprev<CR>')
vim.keymap.set('n', '<Leader>lw', ':lexpr []<CR>') -- Clear location list (w for wipe)

-- Preview Window - mostly used with linters and neomake
vim.keymap.set('n', '<Leader>pc', ':pclose<CR>')

-- Quick fix window is apparently vim wide (shared with all buffers).
-- Mostly used for external commands such as grep or internal like
-- vimgrep etc. suffix with ! to override existing window (IE):
-- `vimgrep!`
vim.keymap.set('n', '<Leader>qo', ':copen<CR>')
vim.keymap.set('n', '<Leader>qc', ':cclose<CR>')
vim.keymap.set('n', '<Leader>ql', ':cl<CR>')
vim.keymap.set('n', '<Leader>qp', ':cprev<CR>')
vim.keymap.set('n', '<Leader>qn', ':cnext<CR>')
vim.keymap.set('n', '<Leader>qw', ':cexpr []<CR>') -- Clear quick fix (w for wipe)

-- Line & Block movement key bindings
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv<Paste>")

-- Attempt mapping ctrl-6 to ctrl-shift-6
-- Let me swap to most recent buffer, but in the same way I do with Tmux
vim.keymap.set('n', '<C-6>', '<C-^>')


vim.keymap.set('n', '<Leader>tt', ':TagbarToggle<CR><C-w><C-w>')


-- ##################################################################################################
-- ######## Airline Settings ########################################################################
-- ##################################################################################################
-- TODO: Swap this plugin out...
-- TODO: No clue at all, how to configure airline from lua, though its also worth looking
--       at something like 'lualine' as well.

vim.cmd([[
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
]])

-- ##################################################################################################
-- ###### Ctrl-P Settings ###########################################################################
-- ##################################################################################################

-- TODO: I think I can drop this and the Ctrl-p plugin as I prefer telescope for this nowadays.
-- let g:ctrlp_prompt_mappings={'PrtClearCache()':['<Leader><F5>']}
-- let g:ctrlp_prompt_mappings={'PrtdeleteEnt()':['<Leader><F7>']}
-- let g:ctrlp_match_window='bottom,order:btt,min:2,max:25'
-- -- ctrlp_open_multiple_files option default seems to be vertical split even though it was never set.
-- -- Now multiple files are open as seperate buffers in seperate windows.
-- let g:ctrlp_open_multiple_files = 'i'
-- -- Allow ctrlp to display hidden files
-- let g:ctrlp_show_hidden = 1

vim.opt.wildmenu = true -- enhanced autocomplete
vim.opt.wildignore="*.so,*.swp,*.zip,*node_modules*,*.jpg,*.png,*.svg,*.ttf,*.woff,*.woff3,*.eot,*public/css/*,*public/js*"

-- ##################################################################################################
-- ###### Neoformat Settings ########################################################################
-- ##################################################################################################
-- Setup leader n f keybind to trigger beautification of the current buffer
vim.keymap.set('n', '<leader>nf', ':Neoformat<CR>')

-- Setup leader n f keybind on visual mode to format the selection
vim.keymap.set('v', '<leader>nf', ':Neoformat<CR>')

-- TODO: yapf_config_path should be buffer-local and set as a function to search upwards
--       from buffer path to home directory...
--
vim.go.yapf_config_path = vim.fs.normalize('~/.style.yapf')

-- TODO: I wonder if there's a nicer, lua-native successor to neoformat..
vim.cmd([[
let g:neoformat_python_yapf = {
    \ 'exe': 'yapf',
    \ 'stdin': 1,
    \ }

let g:neoformat_enabled_python = ['yapf']
"let g:neoformat_enabled_python = ['black']

let g:neoformat_json_pyjson = {
    \ 'exe': 'python',
    \ 'args': ['-m', 'json.tool'],
    \ 'stdin': 1,
    \ }
let g:neoformat_enabled_json = ['jq']

let g:neoformat_enabled_clangformat = ['clang-format']

let g:neoformat_enabled_cmakeformat = ['cmake-format']
]])

-- #################################################################################################
-- ####### NERDTree Settings #######################################################################
-- #################################################################################################
-- Settings to tweak the NERDTree configuration.
-- TODO: IIRC there's a nice lua successor to nerdtree.

vim.go.NERDTreeQuitOnOpen=3  -- Close the window after opening a file.
vim.go.NERDTreeShowLineNumbers=1  -- Show Line Numbers in the NERDTree window
vim.go.NERDTreeNaturalSort=1  -- Sort using natural numbers, i.e. 1.txt, 2.txt, 10.txt

-- Try putting dirs after files in NERDTree view
-- See :h NERDTreeSortOrder for more info
vim.cmd("let g:NERDTreeSortOrder=['*', '\\.swp$',  '\\.bak$', '\\~$', '\\/$']")

-- whether or not to show the nerdtree brackets around flags
vim.go.webdevicons_conceal_nerdtree_brackets = 0


-- Add a Modeline function, appends modeline after last line in buffer.
-- TODO: This can be a pure-lua function bound directly to the keymap.
vim.cmd([[
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
]])


-- #################################################################################################
-- ####### LSP Settings ############################################################################
-- #################################################################################################
-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menu,menuone,noinsert,noselect'

-- LSP Bindings
vim.keymap.set('n', '<Leader>ldf',   vim.lsp.buf.definition)
vim.keymap.set('n', '<Leader>ldc',   vim.lsp.buf.declaration)
vim.keymap.set('n', '<Leader>ldt',   vim.lsp.buf.type_definition)
vim.keymap.set('n', '<Leader>li',    vim.lsp.buf.implementation)
vim.keymap.set('n', '<Leader>lh',    vim.lsp.buf.hover)
vim.keymap.set('n', '<Leader>la',    vim.lsp.buf.code_action)
vim.keymap.set('n', '<Leader>ls',    vim.lsp.buf.signature_help)
vim.keymap.set('n', '<Leader>lr',    vim.lsp.buf.references)
vim.keymap.set('n', '<Leader>lds',   vim.lsp.buf.document_symbol)
vim.keymap.set('n', '<Leader>lws',   vim.lsp.buf.workspace_symbol)
vim.keymap.set('n', '<Leader>lnf',   vim.lsp.buf.format)

-- Enable several LSP's & Completion settings
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- Setup nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- Completion keybinds
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- select = false only accepts manually selected options.

    -- Lusnip keybinds
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'cmp-nvim-lsp-signature-help' },
    { name = 'nvim_lua' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- IMPORTANT: neodev Lua-LSP setup must be called before lspconfig.
require("neodev").setup({
  override = function(root_dir, library)

    -- Since I'm using nix, my actual source tends to be edited from here...
    if (root_dir == vim.fs.normalize('~/.config/nixpkgs/nvim')) then
      library.enabled = true
      library.plugins = true
    else
      vim.notify("Not enabling neodev")
    end
  end,
})


local lspconfig = require("lspconfig")
lspconfig.pylsp.setup{
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        configurationSources = { "flake8" },
        flake8 = {
          enabled = true
        },
        jedi_completion = {
          eager = true  -- Attempts to eagerly resolve documentation and detail.
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
        pylsp_mypy = {
          enabled = true,
          live_mode = true
        }
      }
    }
  }
}

-- Commented lspconfig for clangd as its called internally by clangd-extensions.
-- lspconfig.clangd.setup{capabilities = capabilities}
require("clangd_extensions").setup {
  server = {
    capabilities = capabilities
  }
}

-- Setup rust-tools, which provides some extensions beyond the base lsp-config for rust-analyzer
local rt = require("rust-tools")
rt.setup({
  server = {
    -- on_attach = function(_, bufnr)
    -- Hover actions
    -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    -- Code action groups
    -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    -- end
  },
  capabilities = capabilities
})
-- Hopefully not needed when using rust-tools above
-- lspconfig.rust_analyzer.setup{capabilities = capabilities}

lspconfig.cmake.setup{capabilities = capabilities}
lspconfig.yamlls.setup{capabilities = capabilities}
lspconfig.bashls.setup{capabilities = capabilities}
lspconfig.rnix.setup{capabilities = capabilities}
lspconfig.terraformls.setup{capabilities = capabilities}
lspconfig.zls.setup{capabilities = capabilities}

-- Setup lua_ls and enable call snippets for neovim config
lspconfig.lua_ls.setup({
  -- settings = {
  --   Lua = {
  --     completion = {
  --       callSnippet = "Replace"
  --     }
  --   }
  -- },
  capabilities = capabilities
})


-- Snippets setup
-- Imports VSCode style snippets (friendly-snippets plugin)
local vscode_snippet_loader = require("luasnip.loaders.from_vscode")
vscode_snippet_loader.lazy_load()
vscode_snippet_loader.lazy_load({ paths = { "./snippets" } }) -- Personal snippets.

-- Tresitter configuration for more awesome highlighting.
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,  -- false will disable the whole extension
  },
}

-- UNCOMMENT THIS FOR DEBUGGING LSPs.
-- vim.lsp.set_log_level("debug")
-- run the below command:
-- :lua vim.cmd('e'..vim.lsp.get_log_path())

-- Use Treesitter grammar for code folding
-- TODO: Only set treesitter-based folding in buffers for which treesitter is in use.
vim.opt_local.foldmethod='expr'
vim.opt_local.foldexpr='nvim_treesitter#foldexpr()'

-- Telescope setup:
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<Leader>rg',  builtin.live_grep, {})
vim.keymap.set('n', '<Leader>ts',  builtin.treesitter, {})
vim.keymap.set('n', '<Leader>tk',  builtin.keymaps, {})

-- Configure LSP Diagnostics
-- Built-in nvim diagostics config.
vim.diagnostic.config({
  -- Enable virtual text
  virtual_text = {
    spacing = 2,
    prefix = ' ',
  },

  -- Enable signs
  signs = true,

  -- Disable underlining - its confusing!
  underline = false,
})

require("trouble").setup {
  -- Notes here: https://github.com/folke/trouble.nvim
}

-- TODO: migrate these to vim.keymap.set
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)
