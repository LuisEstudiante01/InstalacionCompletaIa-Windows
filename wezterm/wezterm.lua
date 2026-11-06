-- WezTerm config for native Windows (PowerShell). Needs "IosevkaTerm Nerd Font".
local wezterm = require 'wezterm'
local config = wezterm.config_builder and wezterm.config_builder() or {}

config.default_prog = { 'pwsh.exe', '-NoLogo' }
config.font = wezterm.font('IosevkaTerm Nerd Font')
config.font_size = 11.0
config.colors = { background = '#0d0e14' }
config.initial_cols = 200
config.initial_rows = 32

return config
