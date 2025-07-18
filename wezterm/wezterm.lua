-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Hide the tab bar when only 1 tab.
config.hide_tab_bar_if_only_one_tab = true

-- Use the simpler tab bar.
config.use_fancy_tab_bar = false

-- Set fonts.
config.font = wezterm.font_with_fallback({'0xProto', 'JetBrains Mono NL', 'FiraCode Nerd Font Mono'})
config.font_size = 14.0

-- No window decorations.
-- config.window_decorations = "RESIZE"

-- and finally, return the configuration to wezterm
return config
