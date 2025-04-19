local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font configuration
config.font = wezterm.font('FiraCode Nerd Font')

config.font_size = 14.0
config.line_height = 1.2

-- Enable comprehensive ligature support
config.harfbuzz_features = {
  "calt",  -- Contextual alternates
  "liga",  -- Standard ligatures
  "dlig",  -- Discretionary ligatures
}

config.color_scheme = 'Eighties (base16)'

-- Improve glyph rendering - make symbols like ❯ wider
config.allow_square_glyphs_to_overflow_width = "Always"
config.freetype_load_target = "Light"  -- Enhanced clarity on Retina

-- Font rules - prevent bold and enable italics
config.bold_brightens_ansi_colors = false
config.font_rules = {
  -- Normal text (Regular)
  {
    intensity = "Normal",
    italic = false,
    font = wezterm.font({ family = "FiraCode Nerd Font", weight = "Regular" }),
  },
  -- Bold text (disable bold by using Regular weight)
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font({ family = "FiraCode Nerd Font", weight = "Bold" }),
  },
  -- Italic text (enable italics)
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font({ family = "FiraCode Nerd Font", weight = "Regular", italic = true }),
  },
  -- Bold+Italic text (Regular weight but with italic style)
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font({ family = "FiraCode Nerd Font", weight = "Bold", italic = true }),
  },
}

-- Enable proper true color and italic support with proper terminal type
config.term = "wezterm"

-- Always use RGB color (24-bit color) even in tmux
config.enable_kitty_graphics = true
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- Ensure proper color handling
config.use_fancy_tab_bar = false
config.force_reverse_video_cursor = false

-- Tab bar configuration - only show when multiple tabs are active
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
config.tab_max_width = 50
config.window_decorations = 'RESIZE'
config.window_padding = { left = '.75cell', right = '.5cell', top = '0.3cell', bottom = '0cell' }


-- Theme configuration

config.colors = {
--   -- Custom cursor colors
--   cursor_bg = "#f2777a",
--   cursor_fg = "#000000", -- Black cursor text
--   cursor_border = "#f2777a",

  -- Selection colors
  selection_fg = "#000000",
  selection_bg = "#f2777a",

  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = 'orange',
    -- Tab bar colors
  tab_bar = {
    background = "#2d2d2d",
    active_tab = {
      bg_color = "#2d2d2d",
      fg_color = "#ffffff",
    },
    inactive_tab = {
      bg_color = "#2d2d2d",
      fg_color = "#747369",
    },
    inactive_tab_hover = {
      bg_color = "#2d2d2d",
      fg_color = "#d3d0c8",
    },
    new_tab = {
      bg_color = "#2d2d2d",
      fg_color = "#d3d0c8",
    },
    new_tab_hover = {
      bg_color = "#2d2d2d",
      fg_color = "#f2777a",
    },
  },
}

-- Cursor configuration
config.default_cursor_style = "SteadyBlock"

return config
