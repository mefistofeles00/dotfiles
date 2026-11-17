-- LazyVim keymaps: https://www.lazyvim.org/keymaps
-- These are additions. AI keys live in lua/plugins/ai.lua.
local map = vim.keymap.set

map("n", "<leader>ac", function()
  Snacks.terminal.toggle("claude", {
    cwd = LazyVim.root(),
    win = { position = "right", width = 0.45 },
  })
end, { desc = "Claude Code (terminal)" })
