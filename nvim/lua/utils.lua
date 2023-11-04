-- Utils
local U = {}

local d = require("defaults")

local get_map_options = function(custom_options)
    local options = d.keymap_opts
    if custom_options then
        options = vim.tbl_extend("force", options, custom_options)
    end
    return options
end

-- Map keys
function U.map(mode, target, source, opts)
    vim.keymap.set(mode, target, source, get_map_options(opts))
end

return U
