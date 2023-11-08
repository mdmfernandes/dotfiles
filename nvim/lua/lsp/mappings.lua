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

    --  List all the implementations for the symbol under the cursor.
    --  `gi` is to place the cursor at the same position where it was
    --  left last time in the Insert mode.
    buf_map("n", "<Leader>gi", tb.lsp_implementations)
    --u.buf_map("n", "gi", vim.lsp.buf.implementation())

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

    -- Workspaces
    buf_map("n", "<space>wa", vim.lsp.buf.add_workspace_folder)
    buf_map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder)
    map("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = bufnr, desc = "LSP list workspace folders" })
end

-- Global mappings (only set once)
function M.global_mappings()
    -- Print active LSP sources
    map("n", "<Leader>\\", function()
        vim.notify(string.format("Active LSP sources: %s", require("lsp.sources").active_sources()),
            vim.log.levels.INFO)
    end, { desc = "Print active LSP sources" })

    -- Get info
    map("", "<F6>", function()
        require("lspconfig.ui.lspinfo")()
    end, { desc = "Show LSP info" })

    -- Start and stop clients
    map("", "<F8>", function()
        vim.cmd("LspStart")
        vim.notify(string.format("Start LSP server"), vim.log.levels.INFO)
    end, { desc = "Start LSP" })
    map("", "<C-F8>", function()
        vim.cmd("LspStop")
        vim.notify(string.format("Stop LSP server"), vim.log.levels.INFO)
    end, { desc = "Stop LSP" })
end

function M.setup(client, bufnr)
    mappings(client, bufnr)
end

return M
