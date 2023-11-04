-- Get list of none-ls code actions
local M = {}

local method = require("null-ls").methods.CODE_ACTION

local utils = require("lsp.none-ls.utils")

-- Get code actions that are installed for the provided file type
function M.list_registered(filetype)
    return utils.list_registered(filetype, method)
end

-- Get code actions that are supported for the provided file type
function M.list_supported(filetype)
    return utils.list_supported(filetype, "code_action")
end

return M
