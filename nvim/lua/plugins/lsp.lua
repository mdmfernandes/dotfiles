return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp")
        end
    },
    {
        "j-hui/fidget.nvim", -- LSP progress status
        config = true
    },
    "jose-elias-alvarez/null-ls.nvim",
}
