-- LSP document formatting
local F = {}

local formatting = require("vim.lsp.protocol").Methods.textDocument_formatting

-- Print formatter(s) used to format the buffer
local function print_formatter(client)
    local formatter = client.name

    vim.notify(string.format("Formatter(s): %s", formatter), vim.log.levels.INFO)
end

-- Create group for formatting
local format_au = vim.api.nvim_create_augroup("LspFormatting", {})

local function format_document(client, bufnr, filter)
    -- Format on save
    if client:supports_method(formatting) then
        vim.api.nvim_clear_autocmds({ group = format_au, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = format_au,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = filter,
                    timeout_ms = 1000,
                })
                print_formatter(client)
            end,
        })
    end

    -- Manually (live formatting)
    local map = require("utils").map
    if client:supports_method(formatting) then
        map("n", "<Leader>lf", function()
            vim.lsp.buf.format({
                bufnr = bufnr,
                filter = filter,
                async = true,
            })
            print_formatter(client)
        end, { buffer = bufnr, desc = "Format current buffer" })
    end
end

function F.setup(client, bufnr)
    format_document(client, bufnr)
end

return F
