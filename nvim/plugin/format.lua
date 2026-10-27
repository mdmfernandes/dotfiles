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
    format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        return {
            -- Timeout of 5s for the slow machines :/
            timeout_ms = 5000,
            -- If no formatter is available for the filetype, use the LSP formatter as fallback
            lsp_fallback = true,
        }
    end,
})

---- Key Mappings ----

-- Format buffer (live)
vim.keymap.set("n", "<Leader>lf", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer (live)" })

-- Toggle auto format for current buffer
vim.keymap.set("n", "<Leader>tf", function()
    if vim.b.disable_autoformat then
        vim.g.disable_autoformat = false
        vim.b.disable_autoformat = false
        vim.notify("Auto format enabled for this buffer", vim.log.levels.INFO)
    else
        vim.b.disable_autoformat = true
        vim.notify("Auto format disabled for this buffer", vim.log.levels.INFO)
    end
end, { desc = "Toggle auto format for current buffer" })

-- Toggle auto format globally
vim.keymap.set("n", "<Leader>tF", function()
    if vim.g.disable_autoformat then
        vim.g.disable_autoformat = false
        vim.b.disable_autoformat = false
        vim.notify("Auto format enabled globally", vim.log.levels.INFO)
    else
        vim.g.disable_autoformat = true
        vim.b.disable_autoformat = true
        vim.notify("Auto format disabled globally", vim.log.levels.INFO)
    end
end, { desc = "Toggle auto format globally" })
