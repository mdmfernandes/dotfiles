-- Default values
local D = {}

-- Use rounded borders
-- Enable focus for floating windows for entering them (default)
D.border_opts = { border = "rounded", focusable = true, scope = "line" }

-- key maps
D.keymap_opts = { noremap = true, silent = true }

return D
