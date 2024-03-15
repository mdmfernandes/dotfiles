-- Lualine: https://github.com/nvim-lualine/lualine.nvim
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
        "SmiteshP/nvim-navic",
    },
    config = function()
        local navic = require("nvim-navic")

        navic.setup({
            highlight = true
        })

        require("lualine").setup({
            options = {
                theme = "catppuccin",
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
