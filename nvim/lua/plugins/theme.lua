-- Theme
return {
    -- Catppuccin: https://github.com/catppuccin/nvim
    {
        "catppuccin/nvim",
        enabled = true,
        name = "catppuccin",
        priority = 1000,
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                integrations = {
                    cmp = true,
                    fidget = true,
                    gitsigns = true,
                    harpoon = true,
                    mason = true,
                    notify = true,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    -- OneDark: https://github.com/navarasu/onedark.nvim
    {
        "navarasu/onedark.nvim",
        enabled = false,
        priority = 1000, -- load the theme before all the other start plugins
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
        opts = {
            style = "cool",
            toggle_style_key = nil,
        },
        init = function()
            require("onedark").load()
        end,
        keys = {
            {
                "<Leader>tt",
                function()
                    require("onedark").toggle()
                    vim.notify(
                        string.format("Switched OneDark theme to '%s'", vim.g.onedark_config.style),
                        vim.log.levels.INFO
                    )
                end,
                desc = "Toggle theme style",
            },
        },
    },
}
