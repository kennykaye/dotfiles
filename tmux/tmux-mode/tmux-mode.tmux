#!/usr/bin/env bash

set -e

declare -r mode_indicator_placeholder="\#{tmux_mode_indicator}"

declare -r prefix_prompt_config='@mode_indicator_prefix_prompt'
declare -r copy_prompt_config='@mode_indicator_copy_prompt'
declare -r sync_prompt_config='@mode_indicator_sync_prompt'
declare -r empty_prompt_config='@mode_indicator_empty_prompt'
declare -r custom_prompt_config="@mode_indicator_custom_prompt"
declare -r prefix_mode_style_config='@mode_indicator_prefix_mode_style'
declare -r copy_mode_style_config='@mode_indicator_copy_mode_style'
declare -r sync_mode_style_config='@mode_indicator_sync_mode_style'
declare -r empty_mode_style_config='@mode_indicator_empty_mode_style'
declare -r custom_mode_style_config="@mode_indicator_custom_mode_style"
declare -r prefix_suffix_config='@mode_indicator_prefix_suffix'
declare -r copy_suffix_config='@mode_indicator_copy_suffix'
declare -r sync_suffix_config='@mode_indicator_sync_suffix'
declare -r empty_suffix_config='@mode_indicator_empty_suffix'
declare -r prefix_suffix_style_config='@mode_indicator_prefix_suffix_style'
declare -r copy_suffix_style_config='@mode_indicator_copy_suffix_style'
declare -r sync_suffix_style_config='@mode_indicator_sync_suffix_style'
declare -r empty_suffix_style_config='@mode_indicator_empty_suffix_style'
declare -r prefix_suffix_text_config='@mode_indicator_prefix_suffix_text'
declare -r copy_suffix_text_config='@mode_indicator_copy_suffix_text'
declare -r sync_suffix_text_config='@mode_indicator_sync_suffix_text'
declare -r empty_suffix_text_config='@mode_indicator_empty_suffix_text'
declare -r prefix_suffix_text_style_config='@mode_indicator_prefix_suffix_text_style'
declare -r copy_suffix_text_style_config='@mode_indicator_copy_suffix_text_style'
declare -r sync_suffix_text_style_config='@mode_indicator_sync_suffix_text_style'
declare -r empty_suffix_text_style_config='@mode_indicator_empty_suffix_text_style'

tmux_option() {
  local -r option=$(tmux show-option -gqv "$1")
  local -r fallback="$2"
  echo "${option:-$fallback}"
}

indicator_style() {
  local -r style=$(tmux_option "$1" "$2")
  echo "${style:+#[${style//,/]#[}]}"
}

init_tmux_mode_indicator() {
  local -r \
    prefix_prompt=$(tmux_option "$prefix_prompt_config" " WAIT ") \
    copy_prompt=$(tmux_option "$copy_prompt_config" " COPY ") \
    sync_prompt=$(tmux_option "$sync_prompt_config" " SYNC ") \
    empty_prompt=$(tmux_option "$empty_prompt_config" " TMUX ") \
    prefix_style=$(indicator_style "$prefix_mode_style_config" "bg=blue,fg=black") \
    copy_style=$(indicator_style "$copy_mode_style_config" "bg=yellow,fg=black") \
    sync_style=$(indicator_style "$sync_mode_style_config" "bg=red,fg=black") \
    empty_style=$(indicator_style "$empty_mode_style_config" "bg=cyan,fg=black") \
    prefix_suffix=$(tmux_option "$prefix_suffix_config" "") \
    copy_suffix=$(tmux_option "$copy_suffix_config" "") \
    sync_suffix=$(tmux_option "$sync_suffix_config" "") \
    empty_suffix=$(tmux_option "$empty_suffix_config" "") \
    prefix_suffix_style=$(indicator_style "$prefix_suffix_style_config" "bg=black,fg=blue") \
    copy_suffix_style=$(indicator_style "$copy_suffix_style_config" "bg=black,fg=yellow") \
    sync_suffix_style=$(indicator_style "$sync_suffix_style_config" "bg=black,fg=red") \
    empty_suffix_style=$(indicator_style "$empty_suffix_style_config" "bg=black,fg=cyan")
    prefix_suffix_text=$(tmux_option "$prefix_suffix_text_config" "") \
    copy_suffix_text=$(tmux_option "$copy_suffix_text_config" "") \
    sync_suffix_text=$(tmux_option "$sync_suffix_text_config" "") \
    empty_suffix_text=$(tmux_option "$empty_suffix_text_config" "") \
    prefix_suffix_text_style=$(indicator_style "$prefix_suffix_text_style_config" "bg=black,fg=blue") \
    copy_suffix_text_style=$(indicator_style "$copy_suffix_text_style_config" "bg=black,fg=yellow") \
    sync_suffix_text_style=$(indicator_style "$sync_suffix_text_style_config" "bg=black,fg=red") \
    empty_suffix_text_style=$(indicator_style "$empty_suffix_text_style_config" "bg=black,fg=cyan")

  local -r \
    custom_prompt="#(tmux show-option -qv $custom_prompt_config)" \
    custom_style="#(tmux show-option -qv $custom_mode_style_config)"

  local -r \
    mode_prompt="#{?#{!=:$custom_prompt,},$custom_prompt,#{?client_prefix,$prefix_prompt,#{?pane_in_mode,$copy_prompt,#{?pane_synchronized,$sync_prompt,$empty_prompt}}}}" \
    mode_style="#{?#{!=:$custom_style,},#[$custom_style],#{?client_prefix,$prefix_style,#{?pane_in_mode,$copy_style,#{?pane_synchronized,$sync_style,$empty_style}}}}" \
    mode_suffix="#{?client_prefix,$prefix_suffix,#{?pane_in_mode,$copy_suffix,#{?pane_synchronized,$sync_suffix,$empty_suffix}}}" \
    mode_suffix_style="#{?client_prefix,$prefix_suffix_style,#{?pane_in_mode,$copy_suffix_style,#{?pane_synchronized,$sync_suffix_style,$empty_suffix_style}}}"
    mode_suffix_text="#{?client_prefix,$prefix_suffix_text,#{?pane_in_mode,$copy_suffix_text,#{?pane_synchronized,$sync_suffix_text,$empty_suffix_text}}}" \
    mode_suffix_text_style="#{?client_prefix,$prefix_suffix_text_style,#{?pane_in_mode,$copy_suffix_text_style,#{?pane_synchronized,$sync_suffix_text_style,$empty_suffix_text_style}}}"

  local -r mode_indicator="#[default]$mode_style$mode_prompt$mode_suffix_text_style$mode_suffix_text$mode_suffix_style$mode_suffix#[default]"

  local -r status_left_value="$(tmux_option "status-left")"
  tmux set-option -gq "status-left" "${status_left_value/$mode_indicator_placeholder/$mode_indicator}"

  local -r status_right_value="$(tmux_option "status-right")"
  tmux set-option -gq "status-right" "${status_right_value/$mode_indicator_placeholder/$mode_indicator}"
}

init_tmux_mode_indicator
