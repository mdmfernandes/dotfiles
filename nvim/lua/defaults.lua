-- Default values
local D = {}

-- Use rounded borders
-- Disable focus for floating windows to avoid entering them
D.border_opts = { border = "rounded", focusable = false, scope = "line" }

-- key mapps
D.keymap_opts = { noremap = true, silent = true }

return D
