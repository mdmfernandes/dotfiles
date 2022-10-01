-- LSP utilities
local api = vim.api
local map = require("utils").map
local ts_utils = require("nvim-treesitter.ts_utils")

local U = {}

-- Add nvim-cmp to the LS capabilities with cmp-nvim-lsp
function U.capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    return require("cmp_nvim_lsp").update_capabilities(capabilities)
end

-- LSP servers flags that are common to all servers
function U.flags()
    local flags = {
        -- Use incremental sync for buffer edits
        allow_incremental_sync = true,
        debounce_text_changes = 200,
    }
    return flags
end

-- Format document
local format_au = api.nvim_create_augroup("LspFormatting", {})
function U.format_document(client, bufnr, filter)
    -- Format on save
    if client.supports_method("textDocument/formatting") then
        api.nvim_clear_autocmds({ group = format_au, buffer = bufnr })
        api.nvim_create_autocmd("BufWritePre", {
            group = format_au,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = filter,
                })
                vim.notify(string.format("Formatted with %s", client.name), vim.log.levels.INFO)
            end,
        })
    end

    -- Manually
    if client.supports_method("textDocument/formatting") then
        map("n", "<Leader>lf", function()
            vim.lsp.buf.format({
                bufnr = bufnr,
                filter = filter,
            })
            vim.notify(string.format("Formatted with %s", client.name), vim.log.levels.INFO)
        end, { buffer = bufnr })
    end
end

-- Show signature help on hover (insert mode)
local help_au = api.nvim_create_augroup("LspShowSignatureHelp", { clear = true })
function U.signature_help(client, bufnr)
    if client.supports_method("textDocument/signatureHelp") then
        api.nvim_create_autocmd("CursorHoldI", {
            group = help_au,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.signature_help()
            end,
        })
    end
end

-- Highlight code on hover
local highlight_au = vim.api.nvim_create_augroup("LspDocumentHighlight", {})
function U.document_highlight(client, bufnr)
    if client.supports_method("textDocument/documentHighlight") then
        api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
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
        api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = highlight_au,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

-- Show code context
function U.code_context(client, bufnr)
    if client.supports_method("textDocument/documentSymbol") then
        require("nvim-navic").attach(client, bufnr)
    end
end

-- LSP mappings
function U.mappings(bufnr)
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

    --  List all the implementations for the symbol under the cursor
    buf_map("n", "gi", tb.lsp_implementations)
    --u.buf_map("n", "gi", vim.lsp.buf.implementation())

    -- List all the references to the symbol under the cursor
    buf_map("n", "gr", tb.lsp_references)
    --u.map("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>")

    -- List code actions available at the current cursor position
    buf_map("n", "<leader>ca", vim.lsp.buf.code_action)

    -- Diagnostics key mappings
    buf_map("n", "çd", vim.diagnostic.goto_prev)
    buf_map("n", "ºd", vim.diagnostic.goto_next)
    buf_map("n", "<Leader>q", vim.diagnostic.setqflist)
    buf_map("n", "<Leader>d", tb.diagnostics)
end

-- Functions that are attached to all LSP servers
function U.attach_common(client, bufnr)
    -- Currently using the 'nvim_lsp_signature_help' plugin
    -- U.signature_help(client, bufnr)

    U.code_context(client, bufnr)
    U.mappings(bufnr)
end

return U
