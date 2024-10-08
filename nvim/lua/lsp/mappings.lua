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

    buf_map("n", "<Leader>k", vim.lsp.buf.signature_help,
        "Display signature information about the symbol under the cursor")
    buf_map("n", "gd", vim.lsp.buf.definition, "Jump to the definition of the symbol under the cursor")
    buf_map("n", "gD", vim.lsp.buf.declaration, "Jump to the declaration of the symbol under the cursor")
    buf_map("n", "gt", tb.lsp_type_definitions, "Jump to the definition of the type of the symbol under the cursor")
    buf_map("n", "<Leader>rn", vim.lsp.buf.rename, "Rename all references to the symbol under the cursor")
    buf_map("n", "<Leader>fi", tb.lsp_implementations, "Find all the implementations for the symbol under the cursor")
    buf_map("n", "gr", tb.lsp_references, "List all the references to the symbol under the cursor")
    buf_map("n", "<Leader>ca", vim.lsp.buf.code_action, "List code actions available at the current cursor position")
    buf_map("n", "<Leader>cl", vim.lsp.codelens.run, "Run code lens in the current line")

    -- Language specific mappings
    if client.name == "clangd" then
        buf_map("n", "<Leader>ch", "<Cmd>ClangdSwitchSourceHeader<CR>", "Switch source/header (C/C++)")
        buf_map("n", "<Leader>cs", "<Cmd>ClangdShowSymbolInfo<CR>", "Show symbol info (C/C++)")
    end

    -- Show LSP symbols, if supported.
    local documentSymbol = require("vim.lsp.protocol").Methods.textDocument_documentSymbol
    if client.supports_method(documentSymbol) then
        -- Document symbols. If not supported by the LSP client it uses
        -- Treesitter to show the symbols (defined in telescope.lua).
        buf_map("n", "<Leader>ls", tb.lsp_document_symbols, "Show LSP symbols (document)")
        buf_map("n", "<Leader>lS", tb.lsp_dynamic_workspace_symbols, "Show LSP symbols (workspace)")
    end

    -- Toggle LSP inlay hints, if supported.
    local inlayHint = require("vim.lsp.protocol").Methods.textDocument_inlayHint
    if client.supports_method(inlayHint) then
        buf_map("n", "<Leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "Toggle LSP inlay hints")
    end
end

-- Global mappings (only set once)
function M.global_mappings()
    -- Print active LSP sources, formatters, and linters
    map("n", "<Leader>\\", function()
        -- LSP sources
        local lsp_sources = require("lsp.sources").active_sources()

        if lsp_sources ~= "" then
            vim.notify(string.format("Active LSP sources: %s", require("lsp.sources").active_sources()),
                vim.log.levels.INFO)
        else
            vim.notify("No active LSP sources", vim.log.levels.WARN)
        end

        -- Formatters
        local print_active_formaters = function(formatters)
            vim.notify(string.format("Active formatters: %s", table.concat(formatters, ", ")),
                vim.log.levels.INFO)
        end
        -- Get conform formatters (priority)
        local formatters = require("conform").list_formatters_for_buffer()
        if not vim.tbl_isempty(formatters) then
            print_active_formaters(formatters)
        else
            -- If there are not conform formatters, check for LSP formatters
            local formatters_lsp = require("conform.lsp_format").get_format_clients({
                bufnr = vim.api
                    .nvim_get_current_buf()
            })
            if not vim.tbl_isempty(formatters_lsp) then
                print_active_formaters(vim.tbl_map(function(c)
                    return c.name
                end, formatters_lsp))
            else
                vim.notify("No available formatters", vim.log.levels.WARN)
            end
        end

        -- Linters
        local linters = require("lint")._resolve_linter_by_ft(vim.bo.filetype)
        if not vim.tbl_isempty(linters) then
            vim.notify(string.format("Active linters: %s", table.concat(linters, ", ")), vim.log.levels.INFO)
        else
            vim.notify("No available linters", vim.log.levels.WARN)
        end
    end, { desc = "Print active LSP sources, formatters, and linters" })
end

function M.setup(client, bufnr)
    mappings(client, bufnr)
end

return M
