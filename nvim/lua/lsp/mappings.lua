-- LSP mappings
local M = {}

local map = require("utils").map

-- LSP server mappings
local function mappings(client, bufnr)
    -- Helper for buffer funtions
    local function buf_map(mode, target, source)
        map(mode, target, source, { buffer = bufnr })
    end

    local tb = require("telescope.builtin")

    -- Display hover information about the symbol under the cursor
    buf_map("n", "K", vim.lsp.buf.hover)

    -- Display signature information about the symbol under the cursor
    buf_map("n", "<Leader>k", vim.lsp.buf.signature_help)

    -- Jump to the definition of the symbol under the cursor
    buf_map("n", "gd", vim.lsp.buf.definition)

    -- Jump to the declaration of the symbol under the cursor
    buf_map("n", "gD", vim.lsp.buf.declaration)

    -- Jump to the definition of the type of the symbol under the cursor
    buf_map("n", "gt", vim.lsp.buf.type_definition)

    -- Rename all references to the symbol under the cursor
    buf_map("n", "<Leader>rn", vim.lsp.buf.rename)

    --  Find all the implementations for the symbol under the cursor.
    buf_map("n", "<Leader>fi", tb.lsp_implementations)

    -- List all the references to the symbol under the cursor
    buf_map("n", "gr", tb.lsp_references)

    -- List code actions available at the current cursor position
    buf_map("n", "<leader>ca", vim.lsp.buf.code_action)

    -- Show LSP symbols, if supported.
    if client.supports_method("textDocument/documentSymbolProvider") then
        -- Document symbols. If not supported by the LSP client it uses
        -- Treesitter to show the symbols (defined in telescope.lua).
        buf_map("n", "<Leader>fy", tb.lsp_document_symbols)
        -- Worspace symbols
        buf_map("n", "<Leader>fw", tb.lsp_workspace_symbols)
    end
end

-- Global mappings (only set once)
function M.global_mappings()
    -- Print active LSP sources
    map("n", "<Leader>\\", function()
        vim.notify(string.format("Active LSP sources: %s", require("lsp.sources").active_sources()),
            vim.log.levels.INFO)
    end, { desc = "Print active LSP sources" })
end

function M.setup(client, bufnr)
    mappings(client, bufnr)
end

return M
