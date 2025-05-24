-- Status of LSP / formatters / linters
local S = {}

-- Print active LSP sources, formatters, and linters
local function get_status()
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
end

function S.setup()
    get_status()
end

return S
