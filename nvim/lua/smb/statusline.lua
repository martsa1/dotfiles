require("lualine").setup(
    {
        options = {theme = "dracula"},
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch", "diff", "diagnostics"},
            lualine_c = {
                {
                    "filename",
                    path = 1
                },
                "lsp_progress"
            },
            lualine_x = {"filetype", "encoding", "fileformat"},
            lualine_y = {"progress"},
            lualine_z = {"searchcount", "location"}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {"filename"},
            lualine_x = {"location"},
            lualine_y = {},
            lualine_z = {}
        }
    }
)

-- Section layout:
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
--
-- Available components

--    branch (git branch)
--    buffers (shows currently available buffers)
--    diagnostics (diagnostics count from your preferred source)
--    diff (git diff status)
--    encoding (file encoding)
--    fileformat (file format)
--    filename
--    filesize
--    filetype
--    hostname
--    location (location in file in line:column format)
--    mode (vim mode)
--    progress (%progress in file)
--    searchcount (number of search matches when hlsearch is active)
--    tabs (shows currently available tabs)
--    windows (shows currently available windows)
