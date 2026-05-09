-- Lualine: https://github.com/nvim-lualine/lualine.nvim
vim.pack.add({
    { src = "https://github.com/nvim-lualine/lualine.nvim",  name = "lualine" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("lualine").setup({
    options = {
        theme = "catppuccin-nvim",
    },
    sections = {
        lualine_c = {
            {
                "filename",
                path = 1,
            },
            {
                function()
                    return require("nvim-navic").get_location()
                end,
                cond = function()
                    return require("nvim-navic").is_available()
                end,
            },
        },
        lualine_z = {
            "selectioncount",
            "searchcount",
            "location",
        },
    },
})
