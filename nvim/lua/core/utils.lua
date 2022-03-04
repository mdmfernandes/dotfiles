-- Utils
local d = require("core.defaults")
local api = vim.api

local get_map_options = function(custom_options)
  local options = d.keymap_opts
  if custom_options then
    options = vim.tbl_extend("force", options, custom_options)
  end
  return options
end

local M = {}

-- Map keys
-- TODO: Change this when NeoVIM >= 0.7.0
M.map = function(mode, target, source, opts)
  api.nvim_set_keymap(mode, target, source, get_map_options(opts))
end

-- TODO: Change this when NeoVIM >= 0.7.0
M.buf_map = function(bufnr, mode, target, source, opts)
  api.nvim_buf_set_keymap(bufnr, mode, target, source, get_map_options(opts))
end

-- TODO: Add this when NeoVIM >= 0.7.0
-- Commands
--M.command = function(name, fn, opts)
--	api.nvim_add_user_command(name, fn, get_map_options(opts))
--end

return M
