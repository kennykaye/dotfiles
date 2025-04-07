local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Font configuration - simplified for compatibility
config.font = wezterm.font 'Fira Code'

config.font_size = 14.0

-- Enable comprehensive ligature support
config.harfbuzz_features = {
  "calt",  -- Contextual alternates
  "liga",  -- Standard ligatures
  "dlig",  -- Discretionary ligatures
}
 
config.color_scheme = 'Eighties (base16)'

-- Improve glyph rendering - make symbols like ❯ wider
config.allow_square_glyphs_to_overflow_width = "Always"

-- Font rules - prevent bold and enable italics
config.bold_brightens_ansi_colors = false
config.font_rules = {
  -- Normal text (Regular)
  {
    intensity = "Normal",
    italic = false,
    font = wezterm.font {
      family = "Fira Code",
      weight = "Regular",
    },
  },
  -- Bold text (disable bold by using Regular weight)
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font {
      family = "Fira Code",
      weight = "Regular",
    },
  },
  -- Italic text (enable italics)
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font {
      family = "Fira Code",
      weight = "Regular",
      italic = true,
    },
  },
  -- Bold+Italic text (Regular weight but with italic style)
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font {
      family = "Fira Code",
      weight = "Regular",
      italic = true,
    },
  },
}

-- Enable proper italic support with a standard terminal type
config.term = "xterm-256color"

-- Tab bar configuration - only show when multiple tabs are active
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = true
config.tab_max_width = 50
config.use_fancy_tab_bar = true

-- Theme configuration

-- -- Explicitly force colors (Base16 Eighties)
config.colors = {
--   -- Default colors
--   foreground = "#d3d0c8",
--   background = "#2d2d2d",

--   -- Normal colors (ANSI 0-7)
--   ansi = {
--     "#2d2d2d", -- black 
--     "#f2777a", -- red
--     "#99cc99", -- green
--     "#ffcc66", -- yellow
--     "#6699cc", -- blue
--     "#cc99cc", -- magenta
--     "#66cccc", -- cyan
--     "#d3d0c8", -- white
--   },

--   -- Bright colors (ANSI 8-15)
--   brights = {
--     "#747369", -- bright black
--     "#f2777a", -- bright red
--     "#99cc99", -- bright green
--     "#ffcc66", -- bright yellow
--     "#6699cc", -- bright blue
--     "#cc99cc", -- bright magenta
--     "#66cccc", -- bright cyan
--     "#f2f0ec", -- bright white
--   },

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
--   tab_bar = {
--     background = "#2d2d2d",
--     active_tab = {
--       bg_color = "#2d2d2d",
--       fg_color = "#f2777a",
--     },
--     inactive_tab = {
--       bg_color = "#2d2d2d",
--       fg_color = "#747369",
--     },
--     inactive_tab_hover = {
--       bg_color = "#2d2d2d",
--       fg_color = "#d3d0c8",
--     },
--     new_tab = {
--       bg_color = "#2d2d2d",
--       fg_color = "#d3d0c8",
--     },
--     new_tab_hover = {
--       bg_color = "#2d2d2d",
--       fg_color = "#f2777a",
--     },
--   },
}

-- Cursor configuration
config.default_cursor_style = "SteadyBlock"

return config