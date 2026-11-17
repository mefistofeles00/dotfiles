-- LazyVim tuşları: https://www.lazyvim.org/keymaps
-- Buradakiler ek. AI tuşları lua/plugins/ai.lua içinde.
local map = vim.keymap.set

map("n", "<leader>ac", function()
  Snacks.terminal.toggle("claude", {
    cwd = LazyVim.root(),
    win = { position = "right", width = 0.45 },
  })
end, { desc = "Claude Code (terminal)" })
