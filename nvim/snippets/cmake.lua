-- See https://github.com/L3MON4D3/LuaSnip/blob/master/lua/luasnip/config.lua#L22-L48 for available globals
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
    s("cmakevar", {
        t({
            "# Get a list of all CMake variables",
            "get_cmake_property(_variableNames VARIABLES)",
            "",
            "foreach (_variableName ${_variableNames})",
            "    # Check if the variable name starts with the desired prefix",
            "    if (_variableName MATCHES \"^PYTHON_\")",
            "        # Print the variable name and its value",
            "        message(STATUS \"${_variableName}=${${_variableName}}\")",
            "    endif()",
            "endforeach()"
        })
    })
}
