-- nvim-notify: https://github.com/rcarriga/nvim-notify
local notify = require("notify")

notify.setup({
    -- render = "minimal",
    minimum_width = 30,
    timeout = 0,
})

vim.notify = notify
