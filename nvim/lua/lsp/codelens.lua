-- LSP code lenses
local C = {}

local group = vim.api.nvim_create_augroup("LSPCodeLens", { clear = true })
local codeLens = require("vim.lsp.protocol").Methods.textDocument_codeLens

-- Code lenses
local function code_lens(client, bufnr)
    if client.supports_method(codeLens) then
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            group = group,
            callback = function()
                vim.lsp.codelens.refresh({ bufnr = bufnr })
            end
        })

        vim.api.nvim_create_autocmd("LspDetach", {
            group = group,
            callback = function()
                vim.lsp.codelens.clear(client.id, bufnr)
            end,
        })
    end
end

function C.setup(client, bufnr)
    code_lens(client, bufnr)
end

return C
