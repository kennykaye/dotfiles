#!/usr/bin/env sh

# Remove the existing calendar item if it exists
sketchybar --remove calendar 2>/dev/null

# Define parameters as an array
CALENDAR_PARAMS=(
  update_freq=10
  label.padding_left=5
  label.padding_right=0
  background.color=$LIGHT_GREY
  background.height=26
  background.corner_radius=5
)

# Check if Raycast is running 
if pgrep -x "Raycast" >/dev/null; then
  # Check if the raycastCalendarStatusItem is in the status bar items list
  if sketchybar --query default_menu_items | grep -q "raycastCalendarStatusItem"; then
    # Add an alias for the Raycast calendar status item
    sketchybar --add alias "Raycast,raycastCalendarStatusItem" right \
               --rename "Raycast,raycastCalendarStatusItem" calendar \
               --set calendar "${CALENDAR_PARAMS[@]}"
  fi
fi

