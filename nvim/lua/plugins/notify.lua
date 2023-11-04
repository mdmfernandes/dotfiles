-- nvim-notify: https://github.com/rcarriga/nvim-notify
return {
    "rcarriga/nvim-notify",
    version = "*",
    opts = {
        -- render = "minimal",
        minimum_width = 30,
        timeout = 2000,
    },
    init = function()
        vim.notify = require("notify")
    end
}
