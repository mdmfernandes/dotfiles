-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Hold the configuration
local config = wezterm.config_builder()

-- Actual configuration
config.font_size = 14
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
    left = "1cell",
    right = "0cell",
    top = "1cell",
    bottom = "0cell",
}

-- Force the cursor to use reverse video colors based on the foreground and background colors
config.force_reverse_video_cursor = true

-- Disable window decorations
config.window_decorations = "NONE"

-- Load local configuration
local local_config = require("wezterm_local")
local_config.apply(config)

-- Color scheme
config.color_scheme = "catppuccin-mocha"

-- Font
config.font = wezterm.font_with_fallback({ "JetBrains Mono", "Noto Color Emoji", "DengXian" })

-- Don't complain about missing glyphs
config.warn_about_missing_glyphs = false

-- Return the configuration to wezterm
return config
