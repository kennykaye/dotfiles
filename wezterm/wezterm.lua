local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Determine font size based on display -- REMOVED THIS BLOCK TO PREVENT DEADLOCK
-- local base_font_size = 14
-- local macbook_font_size = 15
-- local current_font_size = base_font_size
--
-- -- wezterm.log_error(wezterm.inspect(wezterm.gui.screens())) -- Uncomment to debug screen names
-- local screens = wezterm.gui.screens()
-- -- Check if the active screen seems like the built-in MacBook display
-- -- Common names include "Color LCD", "Built-in Retina Display"
-- if screens.active and (screens.active.name:find("Color LCD") or screens.active.name:find("Built%-in")) then
--   current_font_size = macbook_font_size
--   wezterm.log_info("Using MacBook font size: " .. current_font_size)
-- else
--   wezterm.log_info("Using default font size: " .. current_font_size .. " for screen: " .. (screens.active and screens.active.name or "Unknown"))
-- end


-- Font configuration
local base_font_size = 15
local font_family = 'Berkeley Mono'
local fallback_font_family = 'FiraCode Nerd Font'
local line_height = 1.22

-- Use the dynamically determined font size -- NOW SETTING DEFAULT
local font = { family = font_family, weight = 400, size = base_font_size, line_height = line_height }
-- local font = { family = 'CommitMono', weight = 'Regular', size = base_font_size, line_height = 1.3 }
-- local font = { family = 'MonoLisa Variable', weight = 350, size = base_font_size, line_height = 1.3 }
-- local font = { family = 'FiraCode Nerd Font', weight = 375, size = base_font_size, line_height = 1.3 }
local fallback_font = { family = fallback_font_family, weight = 'Light', size = base_font_size, line_height = line_height }

config.font = wezterm.font_with_fallback({ font.family, fallback_font.family })
config.font_size = font.size -- Make sure this uses the size from the font table
config.line_height = font.line_height

-- Enable comprehensive ligature support
-- config.harfbuzz_features = {
 -- "calt",  -- Contextual alternates
  -- "liga",  -- Standard ligatures
  -- "dlig",  -- Discretionary ligatures
-- }

config.color_scheme = 'Eighties (base16)'

-- Improve glyph rendering - make symbols like ❯ wider
-- config.allow_square_glyphs_to_overflow_width = "Always"
-- config.freetype_load_target = "Light"  -- Enhanced clarity on Retina

-- Font rules - prevent bold and enable italics
config.bold_brightens_ansi_colors = false
config.font_rules = {
  -- Normal text (Regular)
  {
    intensity = "Normal",
    italic = false,
    font = wezterm.font_with_fallback({
      { family = font_family, weight = 400 }, -- Use defined font weight
      { family = fallback_font_family, weight = 'Light' },
    }),
  },
  -- Bold text (disable bold by using Regular weight)
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font_with_fallback({
      { family = font_family, weight = "Bold" }, -- Use "Bold" weight explicitly
      { family = fallback_font_family, weight = "Bold" },
    }),
  },
  -- Italic text (enable italics)
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font_with_fallback({
      { family = font_family, weight = 400, italic = true }, -- Use defined font weight
      { family = fallback_font_family, weight = 'Light', italic = true }, -- Use fallback weight
    }),
  },
  -- Bold+Italic text (Regular weight but with italic style)
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font_with_fallback({
      { family = font_family, weight = "Bold", italic = true }, -- Use "Bold" weight explicitly
      { family = fallback_font_family, weight = "Bold", italic = true },
    }),
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
config.window_padding = { left = '.75cell', right = '.5cell', top = '0.5cell', bottom = '0cell' }
config.visual_bell = { fade_in_duration_ms = 0, fade_out_duration_ms = 0 }
config.audible_bell = 'Disabled'


-- Theme configuration

config.colors = {
--   -- Custom cursor colors
  cursor_bg = "#e8e6df",
  cursor_fg = "#1f1f1f",
  cursor_border = "#e8e6df",

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

-- Event handler to adjust font size based on the window's screen
wezterm.on('window-config-reloaded', function(window, pane)
  -- Add check: Ensure the window object itself exists
  if not window then
    wezterm.log_warn("window-config-reloaded: Received event with nil window object.")
    return
  end

  -- Log the type and content of the window object RIGHT BEFORE the failing call
  -- wezterm.log_error("window-config-reloaded: Type of window: " .. type(window)) -- Keep commented unless debugging
  -- Be cautious with inspect on potentially complex objects, might be too verbose or error itself
  -- wezterm.log_error("window-config-reloaded: Inspecting window: " .. wezterm.inspect(window))

  -- Check if the gui_window method exists and is callable before using it
  if not window.gui_window or type(window.gui_window) ~= "function" then
      wezterm.log_warn("window-config-reloaded: window object does not have a callable gui_window method in this context.")
      return
  end

  -- Check if we have a GUI window associated with this event
  local gui_win = window:gui_window()
  if not gui_win then
    wezterm.log_warn("window-config-reloaded: No GUI window available yet for this event.")
    return
  end

  local dimensions = gui_win:get_dimensions()
  if not dimensions or not dimensions.screen then
    wezterm.log_warn("Could not get screen dimensions for window")
    return
  end

  local screen = dimensions.screen
  local macbook_font_size = 20
  local new_font_size = base_font_size -- Start with default

  -- Check if the screen for this window seems like the built-in MacBook display
  -- wezterm.log_error("Screen info: " .. wezterm.inspect(screen)) -- Uncomment to debug screen info
  if screen.name and (screen.name:find("Color LCD") or screen.name:find("Built%-in")) then
    new_font_size = macbook_font_size
    wezterm.log_info("Applying MacBook font size: " .. new_font_size .. " for window on screen: " .. screen.name)
  else
    wezterm.log_info("Applying default font size: " .. new_font_size .. " for window on screen: " .. screen.name)
  end

  -- Apply override only if the size needs changing
  if new_font_size ~= window:effective_config().font_size then
    window:set_config_overrides({
      font_size = new_font_size,
      -- The font_rules defined globally should adapt, but we could override them here
      -- if specific size-dependent rules were needed.
    })
  end
end)

return config
