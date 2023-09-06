return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp")
        end
    },
    {
        "j-hui/fidget.nvim", -- LSP progress status
        tag = "legacy",
        event = "LspAttach",
        opts = {
            text = {
                spinner = "dots" }
        }
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    }
}
