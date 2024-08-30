-- See https://github.com/L3MON4D3/LuaSnip/blob/master/lua/luasnip/config.lua#L22-L48 for available globals
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
    s("impath", {
        t({
            "from pathlib import Path",
        })
    })
}
