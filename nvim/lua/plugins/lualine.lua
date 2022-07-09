-- Lualine: https://github.com/nvim-lualine/lualine.nvim
local navic = require("nvim-navic")

require("lualine").setup({
    options = {
        theme = "onedark",
    },
    sections = {
        lualine_c = {
            { navic.get_location, cond = navic.is_available },
        },
    },
})
