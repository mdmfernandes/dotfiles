-- Google's lsp server for golang: https://github.com/golang/tools/tree/master/gopls
local settings = {
    gopls = {
        analyses = {
            unusedparams = true,
        },
        staticcheck = true,
    },
}

local u = require("lsp.utils")
local S = {}

function S.setup()
    require("lspconfig").gopls.setup({
        flags = u.flags(),
        capabilities = u.capabilities(),
        on_attach = function(client, buf)
            u.format_document(client, buf)
            u.signature_help(client, buf)
            u.mappings(buf)
        end,
        settings = settings,
        cmd = { "gopls", "serve" },
        filetypes = { "go", "gomod", "gotmpl" },
        root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
    })
end

return S
