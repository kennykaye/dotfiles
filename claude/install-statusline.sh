#!/bin/bash
# Claude Code Status Line Installer
#
# Replicates the base16-eighties powerline status line configuration for Claude Code.
# Run this script on any machine where you want the same status line setup.
#
# Prerequisites:
#   - jq        (brew install jq)
#   - A Nerd Font installed and configured in your terminal (for powerline/icon glyphs)
#
# Usage:
#   bash install-statusline.sh

set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
SCRIPT_PATH="$CLAUDE_DIR/statusline-command.sh"
SETTINGS_PATH="$CLAUDE_DIR/settings.json"

echo "Installing Claude Code base16-eighties powerline status line..."

# Ensure ~/.claude exists
mkdir -p "$CLAUDE_DIR"

# ---------------------------------------------------------------------------
# 1. Write the status line command script
# ---------------------------------------------------------------------------
cat > "$SCRIPT_PATH" << 'STATUSLINE_EOF'
#!/bin/bash

input=$(cat)

# Extract values
current_dir=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // "."')
model_name=$(echo "$input" | jq -r '.model.display_name // "Claude"')
total_cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
input_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
output_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')

# Powerline separator (actual UTF-8 character)
SEP=""

# Colors (RGB true color for base16-eighties palette)
# Format: \e[38;2;R;G;Bm for foreground, \e[48;2;R;G;Bm for background
RESET=$'\e[0m'

# base16-eighties color palette (matches nvim/lua/utils/colors.lua)
# base     = #2d2d2d (45,45,45)   - main bg
# surface0 = #393939 (57,57,57)   - slightly lighter bg
# overlay1 = #747369 (116,115,105) - muted fg / inactive
# text     = #d3d0c8 (211,208,200) - default fg
# red      = #f2777a (242,119,122)
# orange   = #f99157 (249,145,87)
# yellow   = #ffcc66 (255,204,102)
# green    = #99cc99 (153,204,153)
# teal     = #66cccc (102,204,204)
# mauve    = #cc99cc (204,153,204)

# Segment colors (bg, fg for text, sep for separator)
# Directory segment: surface0 bg + teal text
DIR_BG=$'\e[48;2;57;57;57m'
DIR_FG=$'\e[38;2;102;204;204m'
DIR_SEP=$'\e[38;2;57;57;57m'

# Model segment: base bg + mauve text
MODEL_BG=$'\e[48;2;45;45;45m'
MODEL_FG=$'\e[38;2;204;153;204m'
MODEL_SEP=$'\e[38;2;45;45;45m'

# Git segment: surface0 bg + green text
GIT_BG=$'\e[48;2;57;57;57m'
GIT_FG=$'\e[38;2;153;204;153m'
GIT_SEP=$'\e[38;2;57;57;57m'

# Cost segment: base bg + yellow text
COST_BG=$'\e[48;2;45;45;45m'
COST_FG=$'\e[38;2;255;204;102m'
COST_SEP=$'\e[38;2;45;45;45m'

# Context segment: surface0 bg + orange text
CTX_BG=$'\e[48;2;57;57;57m'
CTX_FG=$'\e[38;2;249;145;87m'
CTX_SEP=$'\e[38;2;57;57;57m'

# Get directory path (use ~ for home)
dir_name="${current_dir/#$HOME/~}"

# Get git info
git_info=""
if [ -n "$current_dir" ] && [ "$current_dir" != "null" ] && git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$current_dir" --no-optional-locks branch --show-current 2>/dev/null)

    # Count staged, unstaged, and untracked
    staged=$(git -C "$current_dir" --no-optional-locks diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    unstaged=$(git -C "$current_dir" --no-optional-locks diff --numstat 2>/dev/null | wc -l | tr -d ' ')
    untracked=$(git -C "$current_dir" --no-optional-locks ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

    # Check ahead/behind remote
    ahead_behind=$(git -C "$current_dir" --no-optional-locks rev-list --left-right --count HEAD...@{upstream} 2>/dev/null)
    ahead=$(echo "$ahead_behind" | cut -f1)
    behind=$(echo "$ahead_behind" | cut -f2)

    status_parts=""
    [ "$staged" -gt 0 ] 2>/dev/null && status_parts+=" ${GREEN}${YELLOW}"
    [ "$unstaged" -gt 0 ] 2>/dev/null && status_parts+=" ${MAUVE}${YELLOW}"
    [ "$untracked" -gt 0 ] 2>/dev/null && status_parts+=" ${WHITE}${YELLOW}"
    [ "$ahead" -gt 0 ] 2>/dev/null && status_parts+=" ⇡"
    [ "$behind" -gt 0 ] 2>/dev/null && status_parts+=" ⇣"

    [ -n "$branch" ] && git_info=" ${branch}${status_parts}"
fi

# Format cost (ensure exactly 2 decimal places)
if [ -n "$total_cost" ] && [ "$total_cost" != "null" ] && [ "$total_cost" != "0" ]; then
    # Use awk for reliable formatting
    cost_display=$(echo "$total_cost" | awk '{printf "$%.2f", $1}')
else
    cost_display="\$0.00"
fi

# Format context usage (cap percentage at 100)
used_int=${used_pct%.*}
[ -z "$used_int" ] && used_int=0
[ "$used_int" -gt 100 ] 2>/dev/null && used_int=100
input_k=$((input_tokens / 1000))
output_k=$((output_tokens / 1000))

# Build progress bar (20 chars wide)
bar_width=20
filled=$((used_int * bar_width / 100))
empty=$((bar_width - filled))
bar=""
for ((i=0; i<filled; i++)); do bar+="━"; done
for ((i=0; i<empty; i++)); do bar+="─"; done

# Color the bar based on usage (base16-eighties: green < 50, yellow < 80, red >= 80)
if [ "$used_int" -lt 50 ]; then
    bar_color=$'\e[38;2;153;204;153m'  # #99cc99 green
elif [ "$used_int" -lt 80 ]; then
    bar_color=$'\e[38;2;255;204;102m'  # #ffcc66 yellow
else
    bar_color=$'\e[38;2;242;119;122m'  # #f2777a red
fi

context_info="${used_int}% ${bar_color}${bar}${CTX_FG} ${input_k}k↓ ${output_k}k↑"


# Build powerline status
output=""

# Segment 1: Directory (selection bg + cyan text)
output+="${DIR_BG}${DIR_FG}  ${dir_name} "
output+="${MODEL_BG}${DIR_SEP}${SEP}"

# Segment 2: Model (monokai bg + purple text)
output+="${MODEL_BG}${MODEL_FG} 󰚩 ${model_name} "

# Segment 3: Git (selection bg + green text) - only if git info exists
if [ -n "$git_info" ]; then
    output+="${GIT_BG}${MODEL_SEP}${SEP}"
    output+="${GIT_BG}${GIT_FG} ${git_info} "
    output+="${COST_BG}${GIT_SEP}${SEP}"
else
    output+="${COST_BG}${MODEL_SEP}${SEP}"
fi

# Segment 4: Cost (monokai bg + yellow text)
output+="${COST_BG}${COST_FG}  ${cost_display} "
output+="${CTX_BG}${COST_SEP}${SEP}"

# Segment 5: Context usage (selection bg + orange text)
output+="${CTX_BG}${CTX_FG} 󰍛 ${context_info} "
output+="${RESET}${CTX_SEP}${SEP}${RESET}"

printf "%s" "$output"
STATUSLINE_EOF

chmod +x "$SCRIPT_PATH"
echo "  Written: $SCRIPT_PATH"

# ---------------------------------------------------------------------------
# 2. Merge the statusLine key into settings.json (preserving existing keys)
# ---------------------------------------------------------------------------
if [ ! -f "$SETTINGS_PATH" ]; then
    echo "{}" > "$SETTINGS_PATH"
fi

# Resolve symlink so we always write to the real file
real_settings=$(readlink -f "$SETTINGS_PATH" 2>/dev/null || realpath "$SETTINGS_PATH" 2>/dev/null || echo "$SETTINGS_PATH")

# Use jq to merge/upsert the statusLine key, leaving everything else intact
tmp=$(mktemp)
jq '. + {"statusLine": {"type": "command", "command": "bash '"$SCRIPT_PATH"'"}}' "$real_settings" > "$tmp" && mv "$tmp" "$real_settings"
echo "  Updated: $real_settings"

echo ""
echo "Installation complete."
echo ""
echo "Segments displayed (left to right):"
echo "  1. Current directory    (teal on surface0)"
echo "  2. Claude model name    (mauve on base)"
echo "  3. Git branch + status  (green on surface0, hidden when not in a repo)"
echo "  4. Session cost         (yellow on base)"
echo "  5. Context window usage (orange on surface0, with color-coded progress bar)"
echo ""
echo "Requirements:"
echo "  - jq must be installed  (brew install jq)"
echo "  - A Nerd Font must be active in your terminal for powerline/icon glyphs"
