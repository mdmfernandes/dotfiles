-- Lualine: https://github.com/nvim-lualine/lualine.nvim
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        { "kyazdani42/nvim-web-devicons", lazy = true },
        "SmiteshP/nvim-navic",
    },
    config = function()
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
    end
}
