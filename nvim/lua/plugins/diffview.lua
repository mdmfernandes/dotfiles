-- Diffview: https://github.com/sindrets/diffview.nvim
local diffview = require("diffview")

diffview.setup()

-- Key Mappings
local map = require("utils").map

map("n", "<Leader>gd", diffview.open)
map("n", "<Leader>gh", diffview.file_history)
map("n", "<Leader>gx", diffview.close)
