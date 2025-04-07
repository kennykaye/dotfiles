#
# Source applications and runcom files
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"  ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source Z jump-navigation
source ~/.zsh/z/z.sh

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

export TERM=xterm-256color-italic

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

# Setting ripgrep as the default source for fzf

# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!**/.git" --no-messages 2>/dev/null'
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CUSTOM_OPTS="--cycle
  --height 33%
  --reverse
  --prompt='> '"
  # --preview-window right:60%
  # --margin 0,2,0,2
  # --preview 'highlight -O ansi -l --force {} || cat {} 2> /dev/null | head -500'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COLOR="--color=16,bg+:-1,bg:-1,fg:#a09f93,fg+:#f2f0ec,hl+:#ffcc66,hl:#ffcc66
                  --color=info:#ffcc66,prompt:#f2777a,pointer:#f99157,border:#515151"

# Default to qwerty layout
if [[ -z $KEYBOARD_LAYOUT ]]; then
  # export KEYBOARD_LAYOUT='workman'
  export KEYBOARD_LAYOUT='qwerty'
fi

# Workman bindings
if [[ $KEYBOARD_LAYOUT == 'workman' ]]; then
  export FZF_DEFAULT_OPTS="$FZF_CUSTOM_OPTS --bind=ctrl-n:down,ctrl-e:up $FZF_COLOR"
  bindkey -a 'y' vi-backward-char
  bindkey -a 'n' down-line-or-history
  bindkey -a 'e' up-line-or-search-prefix
  bindkey -a 'o' vi-forward-char
fi

# Qwerty bindings
if [[ $KEYBOARD_LAYOUT == 'qwerty' ]]; then
  export FZF_DEFAULT_OPTS="$FZF_CUSTOM_OPTS $FZF_COLOR"
  bindkey -a 'h' vi-backward-char
  bindkey -a 'j' down-line-or-history
  bindkey -a 'k' up-line-or-search-prefix
  bindkey -a 'l' vi-forward-char
fi

# ----- FZF + Eza + Bat Improvements -----
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

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

# ----- Bat (better cat) -----
export BAT_THEME=base16
