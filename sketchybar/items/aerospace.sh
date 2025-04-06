#!/usr/bin/env bash

sketchybar --add event aerospace_workspace_change

# Define parameters as an array
SPACE_PARAMS=(
  background.color=0x44ffffff
  background.corner_radius=5
  background.height=20
  background.drawing=off
  label.font.size=14.0
)

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space."$sid" left \
        --subscribe space."$sid" aerospace_workspace_change \
        --set space."$sid" \
        "${SPACE_PARAMS[@]}" \
        label="$sid" \
        click_script="aerospace workspace $sid" \
        script="/Users/omerxx/dotfiles/sketchybar/plugins/aerospacer.sh $sid"
done

