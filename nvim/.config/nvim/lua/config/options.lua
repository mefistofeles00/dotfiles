-- Added on top of the LazyVim defaults
local opt = vim.opt

opt.scrolloff = 8
opt.wrap = false
opt.spelllang = { "en", "tr" }
-- Ghostty background is translucent; use terminal colours
opt.termguicolors = true

-- LazyVim: snacks picker + blink.cmp (defaults)
vim.g.autoformat = true
