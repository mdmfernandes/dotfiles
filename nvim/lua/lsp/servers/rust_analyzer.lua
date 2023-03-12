-- LSP server for Rust: https://github.com/rust-analyzer/rust-analyzer
local settings = {
    ["rust-analyzer"] = {
        diagnostics = {
            enable = false,
        }
    }
}

local u = require("lsp.utils")
local S = {}

function S.setup()
    require("lspconfig").rust_analyzer.setup({
        flags = u.flags(),
        capabilities = u.capabilities(),
        on_attach = function(client, buf)
            u.attach_common(client, buf)
            u.format_document(client, buf)
        end,
        settings = settings,
    })
end

return S
