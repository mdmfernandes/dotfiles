-- LSP module
local d = require("defaults")

-- Handlers
local lsp = vim.lsp
lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, d.border_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, d.border_opts)

-- Enabled servers. The server configs are in the ./servers directory
for _, server in
    ipairs({
        "bashls",
        "gopls",
        "jsonls",
        "pyright",
        -- "sqls",
        "sumneko_lua",
    })
do
    require("lsp.servers." .. server).setup()
end

-- Key mappings
local map = require("utils").map

-- Start and stop clients
map("", "<F12>", "<Cmd>LspStart<CR>", {})
map("", "<C-F12>", "<Cmd>:LspStop<CR>", {})
-- Get info
map("", "<F11>", function()
    require("lspconfig.ui.lspinfo")()
end, {})
