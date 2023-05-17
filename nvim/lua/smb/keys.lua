-- ################################################
-- ############### General key maps ###############
-- ################################################

-- TODO: Look into which-key or similar to make this a bit more ergonomic

-- copy absolute file path to system clipboard
vim.keymap.set(
    "n",
    "<Leader>yf",
    function()
        local buf_path = vim.api.nvim_buf_get_name(0)
        vim.fn.setreg("+", buf_path)
    end
)

-- Add Ctrl+v Esc as terminal escape key
vim.keymap.set("t", "<C-v><Esc>", "<C-\\><C-n>")

-- in-line scrolling
vim.keymap.set("n", "<Leader>j", "gj")
vim.keymap.set("n", "<Leader>k", "gk")

-- buffer keys
-- List buffers
vim.keymap.set("n", "<Leader>bls", ":ls<CR>")
vim.keymap.set("n", "<Leader>bb", ":b#<CR>")
vim.keymap.set("n", "<Leader>bn", ":bn<CR>")
vim.keymap.set("n", "<Leader>bp", ":bp<CR>")
vim.keymap.set("n", "<Leader>bf", ":bf<CR>")
vim.keymap.set("n", "<Leader>bl", ":bl<CR>")
vim.keymap.set("n", "<Leader>bw", ":w<CR>:bd<CR>")
vim.keymap.set("n", "<Leader>bd", ":bd!<CR>")
-- new buffer/tab
vim.keymap.set("n", "<Leader>e", ":enew<CR>")

-- -- List marks
vim.keymap.set("n", "<Leader>mls", ":marks<CR>")

-- -- List registers
vim.keymap.set("n", "<Leader>rls", ":reg<CR>")

-- window keys
vim.keymap.set("n", "<Leader>w<", "<C-w><")
vim.keymap.set("n", "<Leader>w>", "<C-w>>")
vim.keymap.set("n", "<Leader>w-", "<C-w>-")
vim.keymap.set("n", "<Leader>w+", "<C-w>+")
vim.keymap.set("n", "<Leader>ws", ":split<CR>")
vim.keymap.set("n", "<Leader>wv", ":vsplit<CR>")
vim.keymap.set("n", "<Leader>wx", ":close<CR>")

-- Function keys
vim.keymap.set("n", "<F3>", ":noh<CR>")
vim.keymap.set("n", "<F5>", ":source $HOME/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<Leader>e", ":NERDTreeToggle<CR>")
-- nnoremap <F7> :UndotreeToggle<CR>
-- indent whole file according to syntax rules
vim.keymap.set("n", "<F9>", "gg=G")

-- toggle relative line numbers
vim.keymap.set("n", "<Leader>rn", ":set relativenumber!<CR>")

-- vim paste mode toggle (for fixing indentation issues when pasting text)
vim.keymap.set("n", "<F2>", ":set invpaste paste?<CR>")

-- Location List - mostly used with linters
vim.keymap.set("n", "<Leader>lo", ":lopen<CR>")
vim.keymap.set("n", "<Leader>lc", ":lclose<CR>")
vim.keymap.set("n", "<Leader>ll", ":ll<CR>")
vim.keymap.set("n", "<Leader>ln", ":lnext<CR>")
vim.keymap.set("n", "<Leader>lp", ":lprev<CR>")
vim.keymap.set("n", "<Leader>lw", ":lexpr []<CR>") -- Clear location list (w for wipe)

-- Preview Window - mostly used with linters
vim.keymap.set("n", "<Leader>pc", ":pclose<CR>")

-- Quick fix window is apparently vim wide (shared with all buffers).
-- Mostly used for external commands such as grep or internal like
-- vimgrep etc. suffix with ! to override existing window (IE):
-- `vimgrep!`
vim.keymap.set("n", "<Leader>qo", ":copen<CR>")
vim.keymap.set("n", "<Leader>qc", ":cclose<CR>")
vim.keymap.set("n", "<Leader>ql", ":cl<CR>")
vim.keymap.set("n", "<Leader>qp", ":cprev<CR>")
vim.keymap.set("n", "<Leader>qn", ":cnext<CR>")
vim.keymap.set("n", "<Leader>qw", ":cexpr []<CR>") -- Clear quick fix (w for wipe)

-- Line & Block movement key bindings
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv<Paste>")

-- Attempt mapping ctrl-6 to ctrl-shift-6
-- Let me swap to most recent buffer, but in the same way I do with Tmux
vim.keymap.set("n", "<C-6>", "<C-^>")

vim.keymap.set("n", "<Leader>tt", ":TagbarToggle<CR><C-w><C-w>")

-- Keybind that prepends modeline to first line in buffer.
vim.keymap.set(
    "n",
    "<Leader>ml",
    function()
        local expandtab_set
        if vim.bo.expandtab then
            expandtab_set = "et"
        else
            expandtab_set = "noet"
        end
        local modeline =
            string.format(
            "vim: set ts=%d sw=%d tw=%d filetype=%s %s :",
            vim.bo.tabstop,
            vim.bo.shiftwidth,
            vim.bo.textwidth,
            vim.bo.filetype,
            expandtab_set
        )
        modeline = string.format(vim.bo.commentstring, modeline)
        vim.fn.append(0, modeline)
        -- TODO, this keymap seems to require hitting Esc for it to complete, would be nice to fix that.
    end
)

-- Add binding to show diagnostics in a floating pane
vim.keymap.set("n", "<Leader>x", vim.diagnostic.open_float)

-- LSP Bindings
vim.keymap.set("n", "<Leader>ldf", vim.lsp.buf.definition)
vim.keymap.set("n", "<Leader>ldc", vim.lsp.buf.declaration)
vim.keymap.set("n", "<Leader>ldt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "<Leader>li", vim.lsp.buf.implementation)
vim.keymap.set("n", "<Leader>lh", vim.lsp.buf.hover)
vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>ls", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.references)
vim.keymap.set("n", "<Leader>lds", vim.lsp.buf.document_symbol)
vim.keymap.set("n", "<Leader>lws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<Leader>lnf", vim.lsp.buf.format)

-- Telescope bindings:
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<c-p>", builtin.find_files, {})
vim.keymap.set("n", "<Leader>rg", builtin.live_grep, {})
vim.keymap.set("n", "<Leader>ts", builtin.treesitter, {})
vim.keymap.set("n", "<Leader>tk", builtin.keymaps, {})
vim.keymap.set("n", "<Leader>tb", builtin.buffers, {})

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {})
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", {})
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", {})
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {})
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {})
vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", {})

-- ##################################################################################################
-- ###### Neoformat Settings ########################################################################
-- ##################################################################################################
-- Setup leader n f keybind to trigger beautification of the current buffer
vim.keymap.set("n", "<leader>nf", ":Neoformat<CR>")

-- Setup leader n f keybind on visual mode to format the selection
vim.keymap.set("v", "<leader>nf", ":Neoformat<CR>")


-- Dabble with treesitter stuff...
vim.keymap.set("n", "<leader>te", function()
    -- Plagiarised from https://neovim.discourse.group/t/check-if-treesitter-is-enabled-in-the-current-buffer/902/5
    -- source: https://neovim.discourse.group/t/check-if-treesitter-is-enabled-in-the-current-buffer/902/4?u=srithon
    local buf = vim.api.nvim_get_current_buf()
    local highlighter = require("vim.treesitter.highlighter")
    if highlighter.active[buf] then
        -- treesitter highlighting is enabled
        vim.cmd [[TSHighlightCapturesUnderCursor]]
        vim.notify("Treesitter highlighting is enabled for this buffer")
    else
        vim.notify("Treesitter highlighting is disabled for this buffer")
    end
end
)
