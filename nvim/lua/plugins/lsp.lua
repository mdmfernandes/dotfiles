return {
    -- LSP progress status
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        tag = "v1.4.0",
        opts = {}
    },

    -- LSP servers package manager
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = require("icons").lsp.source_installed,
                    package_pending = require("icons").lsp.source_pending,
                    package_uninstalled = require("icons").lsp.source_uninstalled
                },
            },
        },
    },
}
