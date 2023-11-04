-- LSP handlers
-- For diagnostics symbols configurations see the file *lua/core/diagnostics.lua*
local H = {}

local d = require("defaults")

function H.setup()
    -- Signature help configuration
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, d.border_opts)

    -- Hover configuration
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, d.border_opts)
end

return H
