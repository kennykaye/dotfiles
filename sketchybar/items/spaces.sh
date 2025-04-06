#!/usr/bin/env sh

sketchybar --add event aerospace_workspace_change
RED=0xffed8796

# Define space parameters as an array
SPACE_PARAMS=(
  icon.padding_left=22
  icon.padding_right=22
  label.padding_right=33
  icon.highlight_color=$RED
  background.color=$LIGHT_GREY
  background.corner_radius=5
  background.height=30
  background.drawing=off
  label.font="sketchybar-app-font:Regular:16.0"
  label.background.height=30
  label.background.drawing=on
  label.background.color=0xff494d64
  label.background.corner_radius=9
  label.drawing=off
)

for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item "space.$sid" left \
        --subscribe "space.$sid" aerospace_workspace_change \
        --set "space.$sid" \
        icon="$sid" \
        "${SPACE_PARAMS[@]}" \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospacer.sh $sid"
done

# Define separator parameters as an array
SEPARATOR_PARAMS=(
  icon=
  icon.font="Hack Nerd Font:Regular:16.0"
  background.padding_left=15
  background.padding_right=15
  label.drawing=off
  associated_display=active
  icon.color=$WHITE
)

sketchybar --add item separator left \
           --set separator "${SEPARATOR_PARAMS[@]}"
