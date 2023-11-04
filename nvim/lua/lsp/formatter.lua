-- LSP document formatting
local F = {}

-- Print formatter(s) used to format the buffer
local function print_formatter(client)
    local formatter = client.name

    if formatter == "null-ls" then
        local formatter_tbl = require("lsp.none-ls.formatters").list_registered(vim.bo.filetype)
        table.sort(formatter_tbl)
        formatter = table.concat(formatter_tbl, " ◆ ")
    end

    vim.notify(string.format("Formatter(s): %s", formatter), vim.log.levels.INFO)
end

-- Create group for formatting
local format_au = vim.api.nvim_create_augroup("LspFormatting", {})

local function format_document(client, bufnr, filter)
    -- Format on save
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = format_au, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = format_au,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = filter,
                    timeout_ms = 2000,
                })
                print_formatter(client)
            end,
        })
    end

    -- Manually
    local map = require("utils").map
    if client.supports_method("textDocument/formatting") then
        map("n", "<Leader>bf", function()
            vim.lsp.buf.format({
                bufnr = bufnr,
                filter = filter,
                timeout_ms = 2000,
            })
            print_formatter(client)
        end, { buffer = bufnr, desc = "Format current buffer" })
    end
end

function F.setup(client, bufnr)
    format_document(client, bufnr)
end

return F
