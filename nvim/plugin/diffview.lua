-- Diffview: https://github.com/sindrets/diffview.nvim
vim.pack.add({
    { src = "https://github.com/sindrets/diffview.nvim", name = "diffview" },
})

local diffview = require("diffview")

diffview.setup()

-- Key Mappings
vim.keymap.set("n", "<Leader>gd", diffview.open, { desc = "Git open diff view" })
vim.keymap.set("n", "<Leader>gh", diffview.file_history, { desc = "Git open current file history" })
vim.keymap.set("n", "<Leader>gq", diffview.close, { desc = "Git close diff view" })
