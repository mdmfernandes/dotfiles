-- Todo comments: https://github.com/folke/todo-comments.nvim
vim.pack.add({
    { src = "https://github.com/folke/todo-comments.nvim", name = "todo-comments" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

require("todo-comments").setup()
