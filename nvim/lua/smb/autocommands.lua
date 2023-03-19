if vim.fn.has("autocmd") then
    -- TODO: Setup lua-powered autocommands...
    vim.cmd(
        [[
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 100 characters.
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
  ]]
    )
end -- has("autocmd")
