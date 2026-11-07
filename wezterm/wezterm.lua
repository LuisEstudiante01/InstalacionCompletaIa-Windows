-- WezTerm config for native Windows (PowerShell). Needs "IosevkaTerm Nerd Font".
local wezterm = require 'wezterm'
local config = wezterm.config_builder and wezterm.config_builder() or {}

config.default_prog = { 'pwsh.exe', '-NoLogo' }
config.font = wezterm.font('IosevkaTerm Nerd Font')
config.font_size = 11.0
config.colors = { background = '#0d0e14' }
config.initial_cols = 200
config.initial_rows = 32
-- Virtual machines (e.g. Hyper-V) have no real GPU: use the software WebGPU adapter.
-- Remove these two lines on a real machine to use the GPU.
config.front_end = 'WebGpu'
config.webgpu_force_fallback_adapter = true

return config
