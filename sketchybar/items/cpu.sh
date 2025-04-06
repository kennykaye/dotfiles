#!/usr/bin/env sh

# Define parameters as arrays
CPU_TOP_PARAMS=(
  label.font="$FONT:Semibold:7"
  label=CPU
  icon.drawing=off
  width=15
  background.padding_right=23
  drawing=off
)

CPU_PERCENT_PARAMS=(
  label.font="$FONT:Heavy:12"
  label=CPU
  icon.drawing=off
  update_freq=2
  mach_helper="$HELPER"
  background.padding_right=20
)

CPU_SYS_PARAMS=(
  width=0
  graph.color=$RED
  graph.fill_color=$RED
  label.drawing=off
  icon.drawing=off
  background.padding_right=10
  background.padding_left=10
  background.height=30
  background.drawing=on
  background.color=$TRANSPARENT
)

CPU_USER_PARAMS=(
  graph.color=$BLUE
  label.drawing=off
  icon.drawing=off
  background.padding_right=10
  background.padding_left=10
  background.height=30
  background.drawing=on
  background.color=$TRANSPARENT
)

sketchybar --add item cpu.top right \
           --set cpu.top "${CPU_TOP_PARAMS[@]}" \
           \
           --add item cpu.percent right \
           --set cpu.percent "${CPU_PERCENT_PARAMS[@]}" \
           \
           --add graph cpu.sys right 55 \
           --set cpu.sys "${CPU_SYS_PARAMS[@]}" \
           \
           --add graph cpu.user right 55 \
           --set cpu.user "${CPU_USER_PARAMS[@]}"
