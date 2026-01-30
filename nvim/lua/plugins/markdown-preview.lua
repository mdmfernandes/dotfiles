-- https://github.com/iamcco/markdown-preview.nvim
return {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    lazy = true,
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    config = function()
        local map = require("utils").map

        map("n", "<Leader>mp", "<Cmd>MarkdownPreview<CR>")
        map("n", "<Leader>ms", "<Cmd>MarkdownPreviewStop<CR>")
        map("n", "<Leader>mt", "<Cmd>MarkdownPreviewToggle<CR>")
    end,
}
