#!/usr/bin/env sh

# Check if Raycast is running
if pgrep -x "Raycast" >/dev/null; then
  # Check if the Raycast calendar item exists
  if sketchybar --query default_menu_items | grep "raycastCalendarStatusItem" >/dev/null; then
    # Check if we need to create an alias
    if ! sketchybar --query item calendar > /dev/null 2>&1; then
      # Create the alias
      sketchybar --add alias "Raycast,raycastCalendarStatusItem" right --rename "Raycast,raycastCalendarStatusItem" calendar
      sketchybar --set calendar update_freq=1                         label.padding_left=5                         label.padding_right=0                         background.color=0x44ffffff                         background.height=26                         background.corner_radius=5
    fi
    # Make it visible
    sketchybar --set calendar drawing=on
  else
    # Hide it if it exists
    sketchybar --set calendar drawing=off 2>/dev/null
  fi
else
  # Hide it if it exists
  sketchybar --set calendar drawing=off 2>/dev/null
fi
