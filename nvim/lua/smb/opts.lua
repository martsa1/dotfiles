-- General settings

vim.opt.syntax = "on"

vim.opt.hlsearch = true

vim.opt.number = true

-- allow backspacing over everything in insert mode
vim.opt.backspace = {"indent", "eol", "start"}

-- Set delay/timeout of key mapping sequences
vim.opt.timeoutlen = 2000

-- Set vim swap file write frequency and various plugin update frequency
-- like tagbar
vim.opt.updatetime = 50

-- Preserve undo-history per buffer
vim.opt.undodir = vim.fs.normalize("~/.config/nvim/undodir")
vim.opt.undofile = true
vim.opt.undolevels = 100
vim.opt.undoreload = 1000

vim.opt.backupdir = vim.fs.normalize("~/.config/nvim/backup")

-- TODO this will hide swap files away from source buffers, not sure if I actually want that...
vim.opt.directory = vim.fs.normalize("~/.config/nvim/backup")

vim.opt.showcmd = true -- display incomplete commands

if vim.fn.has("mouse") then
    vim.opt.mouse = "a"
end

vim.opt.wildmenu = true -- enhanced autocomplete
vim.opt.wildignore =
    "*.so,*.swp,*.zip,*node_modules*,*.jpg,*.png,*.svg,*.ttf,*.woff,*.woff3,*.eot,*public/css/*,*public/js*"

-- default tab stuff - some file types are overriden in `ftplugin` section.
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 0 -- match tabstop
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 4

-- Allow 100ms between keys in a key-sequence.  Defaults to 1000ms
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100

-- Unix as standard file type
vim.opt.ffs = {"unix", "dos", "mac"}

-- Always utf8
vim.opt.fileencoding = "utf-8"

vim.opt.scrolloff = 5 -- lines above/below cursor to keep visible
vim.opt.sidescrolloff = 5 -- horizontal columns to keep visible either side of the cursor

vim.opt.listchars = "tab:>\\ ,trail:-,extends:>,precedes:<,nbsp:+"

vim.opt.autoread = true

vim.opt.history = 1000
vim.opt.tabpagemax = 50

-- TODO: Look into whether I should customise ShaDa
-- TODO: Look into whether I need to tweak default sessionoptions

-- buffer settings

-- Make things like substitute commands act incrementally, and provide offscreen operations
-- in a preview window.  Command acts exactly the same, but shows you what will happen live.
vim.opt.inccommand = "split"

-- Use Treesitter grammar for code folding
-- TODO: Only set treesitter-based folding in buffers for which treesitter is in use.
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"

-- Configure LSP Diagnostics
-- Built-in nvim diagostics config.
-- TODO: vim.diagnostic.open_float looks really handy, lets see if we can get that auto-showing..?
vim.diagnostic.config(
    {
        -- Enable virtual text
        virtual_text = {
            spacing = 2,
            prefix = " ",
            source = "if_many"
        },
        -- Enable signs
        signs = true,
        -- Disable underlining - its confusing!
        underline = false,
        severity_sort = true
    }
)

-- #################################################################################################
-- ####### NERDTree Settings #######################################################################
-- #################################################################################################
-- Settings to tweak the NERDTree configuration.
-- TODO: IIRC there's a nice lua successor to nerdtree.

vim.go.NERDTreeQuitOnOpen = 3 -- Close the window after opening a file.
vim.go.NERDTreeShowLineNumbers = 1 -- Show Line Numbers in the NERDTree window
vim.go.NERDTreeNaturalSort = 1 -- Sort using natural numbers, i.e. 1.txt, 2.txt, 10.txt

-- Try putting dirs after files in NERDTree view
-- See :h NERDTreeSortOrder for more info
vim.cmd("let g:NERDTreeSortOrder=['*', '\\.swp$',  '\\.bak$', '\\~$', '\\/$']")

-- whether or not to show the nerdtree brackets around flags
vim.go.webdevicons_conceal_nerdtree_brackets = 0

-- #################################################################################################
-- ####### LSP Settings ############################################################################
-- #################################################################################################
-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menu,menuone,noinsert,noselect"

-- TODO: yapf_config_path should be buffer-local and set as a function to search upwards
--       from buffer path to home directory...
vim.go.yapf_config_path = vim.fs.normalize("~/.style.yapf")

-- TODO: I wonder if there's a nicer, lua-native successor to neoformat..
vim.cmd(
    [[
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
]]
)

-- Remap markdown preview as we want Ctrl+p for other things...
vim.o.vim_markdown_preview_hotkey = "<C-S-p>"

-- Tweak Gutentags behaviour
vim.go.gutentags_cache_dir = "/tmp/gutentags"
vim.go.gutentags_ctags_tagfile = "tags"
