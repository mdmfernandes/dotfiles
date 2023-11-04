-- LSP code highlighter: highlight code on hover
local H = {}

local ts_utils = require("nvim-treesitter.ts_utils")

local highlight_au = vim.api.nvim_create_augroup("LspDocumentHighlight", {})

local function document_highlight(client, bufnr)
    if client.supports_method("textDocument/documentHighlight") then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = highlight_au,
            buffer = bufnr,
            callback = function()
                local node = ts_utils.get_node_at_cursor()
                while node ~= nil do
                    local node_type = node:type()
                    -- Don't highlight strings
                    if node_type == "string"
                        or node_type == "string_fragment"
                        or node_type == "template_string"
                        or node_type == "document"
                    then
                        return
                    end
                    node = node:parent()
                end
                vim.lsp.buf.document_highlight()
            end,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = highlight_au,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

function H.setup(client, bufnr)
    document_highlight(client, bufnr)
end

return H
