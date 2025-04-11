#
# Source applications and runcom files
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"  ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# set vi mode for fzf
set -o vi

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Load our dotfiles like ~/.functions, etc…
#   ~/.extra can be used for settings you don't want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,aliases,functions}; do
  [ -f "$file" ] && source "$file"
done
unset file

#
# Configurations
#
fpath=(/usr/local/share/zsh-completions $fpath)


# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export PATH="/usr/local/bin/go_appengine_sdk:$PATH"
export PATH="$PATH:/usr/local/mysql/bin/"
# Add WezTerm to path
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# Set TERM for true color support
if [[ -n "$TMUX" ]]; then
  # In tmux session
  export TERM="tmux-256color"
else
  # Direct terminal
  export TERM="wezterm"
fi

export MANPATH="/opt/local/man:/usr/local/man:/usr/bin/:$MANPATH"
export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"

export GOPATH="$HOME/Development/go"

if [[ -s "/opt/homebrew/bin/rbenv"  ]]; then
  # Initialize rbenv
  eval "$(rbenv init - zsh)"
fi

# Language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Editors
export EDITOR='nvim'
export PAGER='less'


# Colorize grep output
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33;40'

# Default to qwerty
bindkey '^w' backward-kill-word

# Paste fzf output to command line
bindkey '^P' fzf-file-widget

# Use prefixed search as widget
zle -N up-line-or-search-prefix

# Raise max file limit
ulimit -n 2048

# enable extended globbing
setopt extended_glob

# passes the bad match onto the command, so we can HEAD^
setopt NO_NOMATCH

# reduce character sequence timeout from 400ms to 10ms
export KEYTIMEOUT=1

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Initialize zoxide
eval "$(zoxide init zsh)"

# Interactize z
bindkey "^Z" _zoxide_zi_with_accept

#  fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"


# (G)o to a directory
bindkey "^G" fzf-cd-widget

# (F)ind text in a file, then open it
bindkey "^F" ripgrep_fzf_vim

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# --- setup fzf theme ---
# Base16 Eighties colors
fg="#d3d0c8"           # foreground
bg="#2d2d2d"           # background
bg_highlight="#393939" # selection background
black="#2d2d2d"        # black
red="#f2777a"          # red
green="#99cc99"        # green
yellow="#ffcc66"       # yellow
blue="#6699cc"         # blue
purple="#cc99cc"       # purple
cyan="#66cccc"         # cyan
white="#d3d0c8"        # white
gray="#747369"         # bright black
orange="#f99157"       # orange

export FZF_COLOR="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${yellow},prompt:${red},pointer:${orange},marker:${cyan},spinner:${green},header:${cyan}"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_CTRL_R_OPTS="--preview-window=hidden --reverse"

# Set base FZF options with better styling

# Support for FZF_DEFAULT_COMMAND and other FZF environment variables
# Keep static settings for compatibility with plugins
if [[ "$TERM" == *"tmux"* ]]; then
  export FZF_DEFAULT_OPTS="--style=full --border=rounded $FZF_COLOR --tmux=80% --margin=1,2"
else
  export FZF_DEFAULT_OPTS="--style=full --border=rounded $FZF_COLOR --margin=1,2"
fi

# Create a wrapper function for fzf to handle dynamic options on every invocation
fzf() {
  local width=$(tput cols)
  local height=$(tput lines)
  
  # Set preview position based on terminal dimensions
  local preview_pos
  if (( width < height * 2 )); then
    preview_pos="down:50%:border-top,rounded:wrap"
   else
    preview_pos="right:50%:border-left,rounded:wrap"
  fi
  
  # Call original fzf with dynamic options
  command fzf --preview="$show_file_or_dir_preview" \
    --preview-window="$preview_pos" \
    "$@"
}


# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# # Default to qwerty layout
# if [[ -z $KEYBOARD_LAYOUT ]]; then
#   # export KEYBOARD_LAYOUT='workman'
#   export KEYBOARD_LAYOUT='qwerty'
# fi

# # Workman bindings
# if [[ $KEYBOARD_LAYOUT == 'workman' ]]; then
#   export FZF_DEFAULT_OPTS="$FZF_CUSTOM_OPTS --bind=ctrl-n:down,ctrl-e:up $FZF_COLOR"
#   bindkey -a 'y' vi-backward-char
#   bindkey -a 'n' down-line-or-history
#   bindkey -a 'e' up-line-or-search-prefix
#   bindkey -a 'o' vi-forward-char
# fi

# # Qwerty bindings
# if [[ $KEYBOARD_LAYOUT == 'qwerty' ]]; then
#   export FZF_DEFAULT_OPTS="$FZF_CUSTOM_OPTS $FZF_COLOR"
#   bindkey -a 'h' vi-backward-char
#   bindkey -a 'j' down-line-or-history
#   bindkey -a 'k' up-line-or-search-prefix
#   bindkey -a 'l' vi-forward-char
# fi