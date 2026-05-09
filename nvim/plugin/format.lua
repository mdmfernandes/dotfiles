-- conform.nvim (formatters): https://github.com/stevearc/conform.nvim
vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim", name = "conform" },
})

require("conform").setup({
    -- Conform runs the first available formatter in the list
    formatters_by_ft = {
        css = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        javascript = { "prettierd", "prettier" },
        -- json = { "prettierd", "prettier" }, -- jsonls (LSP) uses its own formatter
        markdown = { "prettierd", "prettier" },
        -- sh = { "shfmt" }, -- bashls (LSP) uses shfmt for formatting
        -- yaml = { "prettierd", "prettier" }, -- yamlls (LSP) uses its own formatter
    },
    format_on_save = {
        -- Timeout of 5s for the slow machines :/
        timeout_ms = 5000,
        -- If no formatter is available for the filetype, use the LSP formatter as fallback
        lsp_fallback = true,
    },
})

-- Key Mappings
vim.keymap.set("n", "<Leader>lf", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer (live)" })
