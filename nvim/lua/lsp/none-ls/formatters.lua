-- Get list of none-ls formatters
local M = {}

local method = require("null-ls").methods.FORMATTING

local utils = require("lsp.none-ls.utils")

-- Get formatters that are installed for the provided file type
function M.list_registered(filetype)
    return utils.list_registered(filetype, method)
end

-- Get formatters that are supported for the provided file type
function M.list_supported(filetype)
    return utils.list_supported(filetype, "formatting")
end

return M
