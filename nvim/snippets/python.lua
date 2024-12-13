-- vim: set ts=4 sw=4 tw=0 filetype=lua et :
-- See https://github.com/L3MON4D3/LuaSnip/blob/master/lua/luasnip/config.lua#L22-L48 for available globals
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
    s("impath", {
        t({
            "from pathlib import Path",
        })
    }),

    s("imt", {
        t({
            "import typing as t",
        })
    }),

    s("LOG", {
        t({
            "LOG = logging.getLogger(__name__)"
        })
    }),

    s("recursive_iter_files", {
        t({
            "def recursive_iter_files(entrypoint: Path) -> t.Iterator[Path]:",
            '    """Recursively iterates through files from the provided entrypoint."""',
            "    if not entrypoint.is_dir():",
            "        msg = (",
            "            f\"Must be provided with a directory to iterate from, given: \"",
            "            f\"'{entrypoint}'.\"",
            "        )",
            "        raise ValueError(",
            "            msg,",
            "        )",
            "",
            "    for file_ in entrypoint.iterdir():",
            "        if file_.is_dir():",
            "            yield from recursive_iter_files(file_)  # noqa: DOC402",
            "",
            "        elif file_.is_file():",
            "            yield file_",
            "",
            "        else:",
            "            LOG.debug(",
            "                \"Found an entity thats neither a file nor a directory, \"",
            "                \"ignoring: '%s'\",",
            "                str(file_),",
            "            )",
        })
    })
}
