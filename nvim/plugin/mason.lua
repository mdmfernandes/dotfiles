-- LSP servers package manager
vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim", name = "mason" }
})

require("mason").setup({
    opts = {
        ui = {
            icons = {
                package_installed = require("icons").lsp.source_installed,
                package_pending = require("icons").lsp.source_pending,
                package_uninstalled = require("icons").lsp.source_uninstalled,
            },
        },
    },
})
