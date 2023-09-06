-- clangd for C/C++: https://clangd.llvm.org/
local u = require("lsp.utils")
local S = {}

function S.setup()
    require("lspconfig").clangd.setup({
        flags = u.flags(),
        capabilities = u.capabilities(),
        on_attach = function(client, buf)
            u.attach_common(client, buf)
        end,
        cmd = { "clangd", "--offset-encoding=utf-16" },
    })
end

return S
