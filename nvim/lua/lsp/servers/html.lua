-- HTML language server: https://github.com/hrsh7th/vscode-langservers-extracted
local u = require("lsp.utils")
local capabilities = u.capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local S = {}

function S.setup()
    require("lspconfig").html.setup({
        flags = u.flags(),
        capabilities = capabilities,
        on_attach = function(client, buf)
            u.attach_common(client, buf)
            u.format_document(client, buf)
        end,
    })
end

return S
