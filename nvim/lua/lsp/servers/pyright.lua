-- Static type checker for Python: https://github.com/microsoft/pyright
local u = require("lsp.utils")

local S = {}

function S.setup()
    require("lspconfig").pyright.setup({
        flags = u.flags(),
        capabilities = u.capabilities(),
        on_attach = function(client, buf)
            u.signature_help(client, buf)
            u.mappings(buf)
        end,
    })
end

return S
