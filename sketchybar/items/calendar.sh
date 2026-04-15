#!/usr/bin/env sh

sketchybar --remove calendar_watcher 2>/dev/null
sketchybar --remove calendar 2>/dev/null

sketchybar --add item calendar right \
           --set calendar script="$PLUGIN_DIR/calendar_plugin.sh" \
                          update_freq=30 \
                          updates=when_shown \
                          label.padding_left=5 \
                          label.padding_right=13 \
                          background.color=$LIGHT_GREY \
                          background.height=26 \
                          background.corner_radius=5 \
                          background.drawing=off \
                          drawing=on \
           --subscribe calendar system_woke
