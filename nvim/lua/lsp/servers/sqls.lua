-- Language server for sql: https://github.com/lighttiger2505/sqls
local u = require("lsp.utils")

local S = {}

function S.setup()
    require("lspconfig").sqls.setup({
        flags = u.flags(),
        capabilities = u.capabilities(),
        on_attach = function(client, buf)
            u.signature_help(client, buf)
            u.mappings(buf)
        end,
    })
end

return S
