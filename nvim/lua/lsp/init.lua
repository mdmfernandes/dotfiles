-- LSP configuration

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspGroup", { clear = true }),
    callback = function(ev)
        -- Get client
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- If there's no client, return
        if not client then
            vim.notify("No LSP clients are attached", vim.log.levels.INFO)
            return
        end

        -- Get current buffer
        local bufnr = ev.buf

        -- Key mappings
        require("lsp.mappings").setup(client, bufnr)

        -- Highlight code on hover
        require("lsp.highlighter").setup(client, bufnr)

        --  Code lenses
        require("lsp.codelens").setup(client, bufnr)

        -- Inlay hints
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr = bufnr })
        end

        -- Code context (navic)
        if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
        end

        -- Add server specific attachments below
        --- ruff
        if client.name == "ruff" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
        end
    end,

})

-- Enable LSP servers
vim.lsp.enable({
    "asm_lsp",
    "bashls",
    "clangd",
    "gopls",
    "harper",
    "jsonls",
    "luals",
    "pyright",
    "ruff",
    "rust_analyzer",
    "yamlls"
})
