--[[
  Cursor ACP adapter for CodeCompanion.nvim

  Authentication:
  Cursor must be pre-authenticated by the user before using this adapter.
  Run `agent login` (or equivalent) in a terminal; Neovim does not handle or
  store any Cursor credentials. The `agent acp` subprocess uses existing
  Cursor CLI auth.

  Session modes (ask / plan / agent):
  In the chat buffer, use the /mode slash command to switch between Cursor's
  session modes: ask (read-only Q&A), plan (planning, read-only), and agent
  (full tool access).

  Verify config is loaded (in Neovim):
    :lua print("chat adapter (from our config):", require("smb.cursor_acp").default_chat_adapter)
  Should print: chat adapter (from our config): cursor_cli
  In the chat buffer, the header should show "Cursor CLI" and pressing ga
  should only offer the cursor_cli adapter when show_presets is false.
  In the chat buffer, press gd to open debug info (if available) to see the resolved adapter.
]]

local M = {}

M.default_chat_adapter = "cursor_cli"

M.adapters = {
  acp = {
    opts = {
      show_presets = false, -- Only show cursor_cli in the adapter list; no Copilot or other presets.
    },
    cursor_cli = function()
      return require("codecompanion.adapters").extend("claude_code", {
        name = "cursor_cli",
        formatted_name = "Cursor CLI",
        commands = {
          default = { "agent", "acp" },
        },
        defaults = {
          mcpServers = "inherit_from_config",
          timeout = 20000,
        },
      })
    end,
  },
}

-- Chat options and callbacks. Merged into interactions.chat by plugins.lua.
-- Disabling on_ready prevents CodeCompanion from running background tasks
-- (e.g. chat_make_title) that use the default background adapter (Copilot).
M.interactions = {
  chat = {
    opts = {
      wait_timeout = 30 * 60, -- 30 minutes
      acp_timeout_response = "reject-once",
    },
    callbacks = {
      on_ready = {
        enabled = false, -- Avoid triggering Copilot for title generation when chat opens.
      },
    },
  },
}

return M
