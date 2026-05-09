-- nvim-notify: https://github.com/rcarriga/nvim-notify
vim.pack.add({
    { src = "https://github.com/rcarriga/nvim-notify", name = "notify" },
})

require("notify").setup({
    -- render = "minimal",
    minimum_width = 30,
    timeout = 2000,
})

vim.notify = require("notify")
