-- conform.nvim (formatters): https://github.com/stevearc/conform.nvim
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<Leader>lf",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "Format buffer (live)",
        },
    },
    opts = {
        formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
            css = { "prettier" },
            html = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            markdown = { "prettier" },
            sh = { "shfmt" },
            yaml = { "prettier" },

        },
        format_on_save = {
            timeout_ms = 500,
            -- If not formatter is available for the filetype, use the LSP formatter
            lsp_fallback = true,
        },
    }
}
