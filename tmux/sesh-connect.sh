#!/bin/zsh
# Standalone sesh session picker — no .zshrc sourcing for fast launch
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"

session=$(sesh list --icons | fzf-tmux \
    --reverse \
    --highlight-line \
    -p 40%,40% \
    -y 4 \
    --no-sort --ansi --border-label ' Tmux Sessions ' --prompt '❯ ' \
    --bind 'tab:down,btab:up' \
    --bind 'ctrl-a:change-prompt(❯ )+reload(sesh list --icons)' \
    --bind 'ctrl-t:change-prompt( )+reload(sesh list --tmux --icons)' \
    --bind 'ctrl-g:change-prompt( )+reload(sesh list --config --icons)' \
    --bind 'ctrl-x:change-prompt(󰬡 )+reload(sesh list --zoxide --icons)' \
    --bind 'ctrl-f:change-prompt( )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
    --bind 'ctrl-w:execute(tmux kill-session -t {2..})+change-prompt(❯ )+reload(sesh list --icons)'
)

[[ -z "$session" ]] && exit 0

actual_session_name=$(echo "$session" | awk '{print $2}')
sesh connect "$actual_session_name"
