-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Hold the configuration
local config = wezterm.config_builder()

-- Actual configuration
-- config.default_prog = { '/usr/bin/tmux', 'new-session', '-A', '-s', '🚗' }
config.font_size = 15
config.hide_tab_bar_if_only_one_tab = true

-- Load local configuration
local local_config = require("wezterm_local")
local_config.apply(config)

-- Color scheme
config.color_scheme = "catppuccin-mocha"

-- Return the configuration to wezterm
return config
