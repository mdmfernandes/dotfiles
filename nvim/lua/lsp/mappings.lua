-- LSP mappings
local M = {}

local map = require("utils").map

-- LSP server mappings
local function mappings(client, bufnr)
    -- Helper for buffer funtions
    local function buf_map(mode, target, source, desc)
        map(mode, target, source, { buffer = bufnr, desc = desc })
    end

    local tb = require("telescope.builtin")

    -- Display hover information about the symbol under the cursor
    -- Not needed anymore since it's enabled by default
    -- buf_map("n", "K", vim.lsp.buf.hover)

    buf_map("n", "<C-S>", vim.lsp.buf.signature_help,
        "Display signature information about the symbol under the cursor")
    buf_map("n", "gd", vim.lsp.buf.definition, "Jump to the definition of the symbol under the cursor")
    buf_map("n", "gD", vim.lsp.buf.declaration, "Jump to the declaration of the symbol under the cursor")
    buf_map("n", "gt", tb.lsp_type_definitions, "Jump to the definition of the type of the symbol under the cursor")
    -- buf_map("n", "<Leader>rn", vim.lsp.buf.rename, "Rename all references to the symbol under the cursor")
    -- Replace default list by telescope
    buf_map("n", "gri", tb.lsp_implementations, "Find all the implementations for the symbol under the cursor")
    -- Replace default list by telescope
    buf_map("n", "grr", tb.lsp_references, "List all the references to the symbol under the cursor")
    -- buf_map("n", "<Leader>ca", vim.lsp.buf.code_action, "List code actions available at the current cursor position")
    buf_map("n", "<Leader>cl", vim.lsp.codelens.run, "Run code lens in the current line")

    -- Language specific mappings
    if client.name == "clangd" then
        buf_map("n", "<Leader>ch", "<Cmd>LspClangdSwitchSourceHeader<CR>", "Switch source/header (C/C++)")
        buf_map("n", "<Leader>cs", "<Cmd>LspClangdShowSymbolInfo<CR>", "Show symbol info (C/C++)")
    end

    -- Show LSP symbols, if supported.
    local documentSymbol = require("vim.lsp.protocol").Methods.textDocument_documentSymbol
    if client:supports_method(documentSymbol) then
        -- Document symbols. If not supported by the LSP client it uses
        -- Treesitter to show the symbols (defined in telescope.lua).
        buf_map("n", "<Leader>ls", tb.lsp_document_symbols, "Show LSP symbols (document)")
        buf_map("n", "<Leader>lS", tb.lsp_dynamic_workspace_symbols, "Show LSP symbols (workspace)")
    end

    -- Toggle LSP inlay hints, if supported.
    local inlayHint = require("vim.lsp.protocol").Methods.textDocument_inlayHint
    if client:supports_method(inlayHint) then
        buf_map("n", "<Leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "Toggle LSP inlay hints")
    end
end

function M.setup(client, bufnr)
    mappings(client, bufnr)
end

return M
