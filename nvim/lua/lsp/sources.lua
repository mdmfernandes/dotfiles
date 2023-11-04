-- LSP sources (active and supported)
local S = {}

-- Returns a list with the active LSP sources
function S.active_sources()
    Msg = Msg or ""
    local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }

    if next(buf_clients) == nil then
        if type(Msg) == "boolean" or #Msg == 0 then
            return ""
        end
        return Msg
    end

    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- Add LSP servers
    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    -- Add none-ls code actions
    local ca = require("lsp.none-ls.code_actions")
    local supported_ca = ca.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_ca)

    -- Add none-ls diagnostics
    local diagnostics = require("lsp.none-ls.diagnostics")
    local supported_diagnostics = diagnostics.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_diagnostics)

    -- Add none-ls formatters
    local formatters = require("lsp.none-ls.formatters")
    local supported_formatters = formatters.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)

    -- After
    local hash = {}
    local client_names = {}
    for _, v in ipairs(buf_client_names) do
        if not hash[v] then
            client_names[#client_names + 1] = v
            hash[v] = true
        end
    end
    table.sort(client_names)
    return table.concat(client_names, ", ")
end

-- Returns a list with the supported LSP sources
function S.supported_sources()
    Msg = Msg or ""
    local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }

    if next(buf_clients) == nil then
        if type(Msg) == "boolean" or #Msg == 0 then
            return ""
        end
        return Msg
    end

    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- Add none-ls code actions
    local ca = require("lsp.none-ls.code_actions")
    local supported_ca = ca.list_supported(buf_ft)
    vim.list_extend(buf_client_names, supported_ca)

    -- Add none-ls diagnostics
    local diagnostics = require("lsp.none-ls.diagnostics")
    local supported_diagnostics = diagnostics.list_supported(buf_ft)
    vim.list_extend(buf_client_names, supported_diagnostics)

    -- Add none-ls formatters
    local formatters = require("lsp.none-ls.formatters")
    local supported_formatters = formatters.list_supported(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)

    -- After
    local hash = {}
    local client_names = {}
    for _, v in ipairs(buf_client_names) do
        if not hash[v] then
            client_names[#client_names + 1] = v
            hash[v] = true
        end
    end
    table.sort(client_names)
    return table.concat(client_names, ", ")
end

return S
