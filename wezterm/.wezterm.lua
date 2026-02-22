local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" }

config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.90
config.font_size = 12

config.enable_tab_bar = false
--config.window_decorations = "TITLE | RESIZE"
config.window_decorations = "RESIZE"


return config
