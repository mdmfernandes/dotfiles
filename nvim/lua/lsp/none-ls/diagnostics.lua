-- Get list of none-ls diagnostics
local M = {}

local method = require("null-ls").methods.DIAGNOSTICS

local utils = require("lsp.none-ls.utils")

-- Get diagnostics that are installed for the provided file type
function M.list_registered(filetype)
    return utils.list_registered(filetype, method)
end

-- Get diagnostics that are supported for the provided file type
function M.list_supported(filetype)
    return utils.list_supported(filetype, "diagnostics")
end

return M
