#!/usr/bin/env sh

# Remove the existing calendar item if it exists
sketchybar --remove calendar 2>/dev/null
sketchybar --remove calendar_watcher 2>/dev/null

# Define parameters as an array
CALENDAR_PARAMS=(
  update_freq=1
  label.padding_left=5
  label.padding_right=0
  background.color=$LIGHT_GREY
  background.height=26
  background.corner_radius=5
  drawing=on
  position=right
)

# Create a watcher item that will constantly check for Raycast calendar status
calendar_watcher_script="
# Check if Raycast is running and the calendar item exists
if pgrep -x \"Raycast\" >/dev/null && sketchybar --query default_menu_items | grep \"raycastCalendarStatusItem\" >/dev/null; then
  # If calendar doesn't exist, create it
  if ! sketchybar --query item calendar >/dev/null 2>&1; then
    # Create the alias with the correct position on the far right
    sketchybar --add alias \"Raycast,raycastCalendarStatusItem\" right \\
               --rename \"Raycast,raycastCalendarStatusItem\" calendar \\
               --set calendar update_freq=1 \\
                          label.padding_left=5 \\
                          label.padding_right=0 \\
                          background.color=$LIGHT_GREY \\
                          background.height=26 \\
                          background.corner_radius=5 \\
                          drawing=off \\
                          position=right

    # Handle placement with delay in background, 
    # this is a bit of a hack but we don't get the alias screen recording callback
    (
      sleep 5s
      sketchybar --move calendar before time
      sketchybar --set calendar drawing=on
    ) &
  fi
else
  # Remove calendar if it exists but shouldn't
  if sketchybar --query item calendar >/dev/null 2>&1; then
    sketchybar --remove calendar
  fi
fi
"

# Create a hidden watcher item that periodically checks for Raycast
sketchybar --add item calendar_watcher left \
           --set calendar_watcher script="$calendar_watcher_script" \
                                 update_freq=1 \
                                 drawing=on

# Check if Raycast is running initially
if pgrep -x "Raycast" >/dev/null; then
  # Check if the Raycast calendar item exists
  if sketchybar --query default_menu_items | grep "raycastCalendarStatusItem" >/dev/null; then
    # Create the alias directly 
    sketchybar --add alias "Raycast,raycastCalendarStatusItem" right \
               --rename "Raycast,raycastCalendarStatusItem" calendar \
               --set calendar "${CALENDAR_PARAMS[@]}"
  fi
fi

# Trigger the watcher to start monitoring
sketchybar --trigger script calendar_watcher