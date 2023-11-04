-- LSP code context: show code context in status line
local C = {}

local function code_context(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end
end

function C.setup(client, bufnr)
    code_context(client, bufnr)
end

return C
