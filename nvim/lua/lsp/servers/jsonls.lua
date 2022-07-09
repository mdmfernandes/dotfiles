-- Language server for json: https://github.com/hrsh7th/vscode-langservers-extracted
local u = require("lsp.utils")

local S = {}

function S.setup()
    require("lspconfig").jsonls.setup({
        flags = u.flags(),
        capabilities = u.capabilities(),
        on_attach = function(client, buf)
            u.attach_common(client, buf)
        end,
    })
end

return S
