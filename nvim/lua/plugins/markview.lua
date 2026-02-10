-- https://github.com/OXY2DEV/markview.nvim
return {
    "OXY2DEV/markview.nvim",
    enabled = true,
    lazy = false,
    -- Completion for `blink.cmp`
    dependencies = { "saghen/blink.cmp" },
    config = function()
        local map = require("utils").map

        map("n", "<Leader>mp", "<Cmd>Markview Toggle<CR>")
        map("n", "<Leader>ms", "<Cmd>Markview splitToggle<CR>")
    end,
}
