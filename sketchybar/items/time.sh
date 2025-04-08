#!/usr/bin/env sh

# Remove any existing time item
sketchybar --remove time 2>/dev/null

# Script to update the time
TIME_SCRIPT='
  date=$(date "+%-I:%M %p")
  sketchybar --set $NAME label="$date"
'

# Define parameters as an array
PARAMS=(
  update_freq=10
  script="$TIME_SCRIPT"
  label.font="$FONT:Semibold:13.0"
  label.color=$LABEL_COLOR
  label.padding_left=10
  label.padding_right=10
  background.padding_left=5
  background.padding_right=5
  background.height=26
  background.corner_radius=11
)

# Add time item to the right
sketchybar --add item time right \
           --set time "${PARAMS[@]}"