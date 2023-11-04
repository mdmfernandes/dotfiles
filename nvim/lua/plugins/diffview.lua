-- Diffview: https://github.com/sindrets/diffview.nvim

return {
    "sindrets/diffview.nvim",
    config = function()
        local diffview = require("diffview")

        diffview.setup()

        -- Key Mappings
        local map = require("utils").map

        map("n", "<Leader>gd", diffview.open, { desc = "Git open diff view" })
        map("n", "<Leader>gh", diffview.file_history, { desc = "Git open current file history" })
        map("n", "<Leader>gq", diffview.close, { desc = "Git close diff view" })
    end
}
