-- Language server for bash: https://github.com/mads-hartmann/bash-language-server
local u = require("lsp.utils")

local S = {}

function S.setup()
    require("lspconfig").bashls.setup({
        flags = u.flags(),
        capabilities = u.capabilities(),
        on_attach = function(client, buf)
            u.signature_help(client, buf)
            u.mappings(buf)
        end,
    })
end

return S
