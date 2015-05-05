#!/bin/bash
#
# Show the current battery level

# Get the appropriate symbol for the battery value
function tmux_kaye_battery_symbol {
  local result=$1
  local battery_level=$2
  colors=(2 2 11 11 16 1 160)
  thresholds=(86 72 58 44 30 16 1)
  symbols=("⣿" "⣾" "⠿" "⠾" "⠶" "⠴" "⠤")

  for (( i = 0; i <= ${#symbols[*]}; i++ )) do
    if [ $battery_level -ge ${thresholds[$i]} ]; then
      eval "${result}='#[fg=colour${colors[$i]}] ${symbols[$i]}'"
      break
    fi
  done
}

# Get the current battery value
function tmux_kaye_battery {
  local percent_sign="%"
  local battery_symbol=""
  local threshold="100"

  # escape percent "%" in zsh
  [[ -n ${ZSH_VERSION-} ]] && percent_sign="${percent_sign//\%/%%}"

  # osx
  if hash ioreg 2>/dev/null; then
    local ioreg_output
    if ioreg_output=$(ioreg -rc AppleSmartBattery 2>/dev/null); then
      local battery_capacity=${ioreg_output#*MaxCapacity\"\ \=}
      battery_capacity=${battery_capacity%%\ \"*}

      local current_capacity=${ioreg_output#*CurrentCapacity\"\ \=}
      current_capacity=${current_capacity%%\ \"*}

      local battery_level=$(($current_capacity * 100 / $battery_capacity))
      [[ $battery_level -gt $threshold ]] && return 1

    fi
  fi

  # linux
  for possible_battery_dir in /sys/class/power_supply/BAT*; do
    if [[ -d $possible_battery_dir && -f "$possible_battery_dir/energy_full" && -f "$possible_battery_dir/energy_now" ]]; then
      current_capacity=$( <"$possible_battery_dir/energy_now" )
      battery_capacity=$( <"$possible_battery_dir/energy_full" )
      local battery_level=$(($current_capacity * 100 / $battery_capacity))
      [[ $battery_level -gt $threshold ]] && return 1
    fi
  done

  # Only output indicator if battery isn't full
  if (( $battery_level < 99 )); then
    tmux_kaye_battery_symbol battery_symbol $battery_level
    echo $battery_symbol
  fi

return 1
}

tmux_kaye_battery
