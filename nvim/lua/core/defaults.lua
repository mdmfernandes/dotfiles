-- Default values

local M = {}

-- Use rounded borders
-- Disable focus for floating windows to avoid entering them
M.border_opts = { border = "rounded", focusable = false, scope = "line" }

-- key mapps
M.keymap_opts = { noremap = true, silent = true }

return M
