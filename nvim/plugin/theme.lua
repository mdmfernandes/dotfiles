-- Theme
-- Catppuccin: https://github.com/catppuccin/nvim
vim.pack.add({
    { src = "https://github.com/catppuccin/nvim",             name = "catppuccin" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "devicons" },
})

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

vim.cmd.colorscheme("catppuccin-nvim")
