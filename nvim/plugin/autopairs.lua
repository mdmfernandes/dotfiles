-- autopairs: https://github.com/windwp/nvim-autopairs
vim.pack.add({
    { src = "https://github.com/windwp/nvim-autopairs", name = "autopairs" },
})

require("nvim-autopairs").setup({
    -- Use treesitter to check for pairs
    check_ts = true,
})
