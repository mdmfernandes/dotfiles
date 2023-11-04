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

    -- LSP server for diagnostics, formatting, code actions, etc.
    {
        "nvimtools/none-ls.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },

    -- Neovim setup for init.lua and plugin development
    "folke/neodev.nvim",

    -- LSP progress status
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {
            text = {
                spinner = "dots" }
        }
    },

}
