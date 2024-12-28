-- autopairs: https://github.com/windwp/nvim-autopairs
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({
            -- Use treesitter to check for pairs
            check_ts = true,
        })
    end
}
