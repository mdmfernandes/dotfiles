-- LSP module
local d = require("defaults")

-- Handlers
local lsp = vim.lsp
lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, d.border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, d.border_opts)

-- Enabled servers. The server configs are in the ./servers directory
for _, server in ipairs({
    "bashls",
    "clangd",
    "gopls",
    "jsonls",
    "lua_ls",
    "pyright",
    -- "sqls",
    "rust_analyzer",
}) do
    require("lsp.servers." .. server).setup()
end

-- null-ls
require("lsp.null-ls")

-- Key mappings
local map = require("utils").map

-- Get info
map("", "<F6>", function()
    require("lspconfig.ui.lspinfo")()
end, {})

-- Start and stop clients
map("", "<F8>", function()
    vim.cmd("LspStart")
    vim.notify(string.format("Start LSP server"), vim.log.levels.INFO)
end, {})
map("", "<C-F8>", function()
    vim.cmd("LspStop")
    vim.notify(string.format("Stop LSP server"), vim.log.levels.INFO)
end, {})
