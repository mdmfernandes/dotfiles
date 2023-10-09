-- Lualine: https://github.com/nvim-lualine/lualine.nvim
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        { "kyazdani42/nvim-web-devicons" },
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
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            return navic.is_available()
                        end
                    },
                },
                lualine_z = {
                    "selectioncount",
                    "searchcount",
                    "location"
                }
            },
        })
    end
}
