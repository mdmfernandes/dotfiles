-- Lualine: https://github.com/nvim-lualine/lualine.nvim
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
        require("lualine").setup({
            options = {
                theme = "catppuccin",
            },
            sections = {
                lualine_c = {
                    {
                        "filename", path = 1,
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
