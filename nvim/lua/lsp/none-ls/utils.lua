-- LSP none-ls utilities
local M = {}

local sources = require("null-ls.sources")

-- List registered sources for a provided file type
local function list_registered_providers_names(filetype)
    local available_sources = sources.get_available(filetype)
    local registered = {}
    for _, source in ipairs(available_sources) do
        for method in pairs(source.methods) do
            registered[method] = registered[method] or {}
            table.insert(registered[method], source.name)
        end
    end
    return registered
end

-- List sources that are installed for the provided file type and method
function M.list_registered(filetype, method)
    local registered_providers = list_registered_providers_names(filetype)
    return registered_providers[method] or {}
end

-- List sources that are supported for the provided file type and method
function M.list_supported(filetype, method)
    local supported_linters = sources.get_supported(filetype, method)
    table.sort(supported_linters)
    return supported_linters
end

return M
