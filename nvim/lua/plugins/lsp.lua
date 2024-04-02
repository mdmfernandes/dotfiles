return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp").setup()
        end,
    },

    -- LSP servers package manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Neovim setup for init.lua and plugin development
    "folke/neodev.nvim",

    -- LSP progress status
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        tag = "v1.4.0",
        opts = {}
    },

}
