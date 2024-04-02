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

    local buf_client_names = {}

    -- Add LSP servers
    for _, client in pairs(buf_clients) do
        table.insert(buf_client_names, client.name)
    end

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

    local buf_client_names = {}

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
