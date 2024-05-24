-- LSP inlay hints

local I = {}

local group = vim.api.nvim_create_augroup("LspInlayHint", { clear = true })
local inlayHint = require("vim.lsp.protocol").Methods.textDocument_inlayHint

-- Inlay hints
local function inlay_hints()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)

            if client.supports_method(inlayHint.textDocument_inlayHint) then
                vim.lsp.inlay_hint.enable(true, { buffer = bufnr })
            end
        end,
    })
end

function I.setup()
    inlay_hints()
end

return I
