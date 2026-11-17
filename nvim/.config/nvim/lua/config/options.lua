-- LazyVim varsayılanlarının üstüne eklenenler
local opt = vim.opt

opt.scrolloff = 8
opt.wrap = false
opt.spelllang = { "en", "tr" }
-- Ghostty arka planı yarı saydam; terminal rengini kullan
opt.termguicolors = true

-- LazyVim: snacks picker + blink.cmp (varsayılan)
vim.g.autoformat = true
