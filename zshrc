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


# Source Base16
if [[ $ITERM_PROFILE == 'dark' ]]; then
  if [[ -s "$HOME/.config/base16-shell/scripts/base16-eighties-dark.sh" ]]; then
    source "$HOME/.config/base16-shell/scripts/base16-eighties-dark.sh"
  fi
else
  if [[ -s "$HOME/.config/base16-shell/scripts/base16-solarized-light.sh" ]]; then
    source "$HOME/.config/base16-shell/scripts/base16-solarized-light.sh"
  fi
fi

# Load our dotfiles like ~/.functions, etc…
#   ~/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,aliases,functions}; do
  [ -f "$file" ] && source "$file"
done
unset file

# Set correct iterm profile and vim colors
setItermProfile; clear


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

export TERM=xterm-256color-italic

export MANPATH="/opt/local/man:/usr/local/man:/usr/bin/:$MANPATH"
export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"

export GOPATH="$HOME/Development/go"

if [[ -s "/usr/local/bin/rbenv"  ]]; then
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
if [ $ITERM_PROFILE == 'light' ]; then
  export FZF_COLOR="--color=light,bg+:-1,bg:-1,fg+:012,hl+:162,hl:162
                    --color=info:002,prompt:012,border:#6c71c4"
else
  export FZF_COLOR="--color=16,bg+:-1,bg:-1,fg:#a09f93,fg+:#f2f0ec,hl+:#ffcc66,hl:#ffcc66
                    --color=info:#ffcc66,prompt:#f2777a,pointer:#f99157,border:#515151"
fi

# Default to qwerty layout
if [[ -z $KEYBOARD_LAYOUT ]]; then
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Kenny/.google-cloud-sdk/path.zsh.inc' ]; then source '/Users/Kenny/.google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Kenny/.google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/Kenny/.google-cloud-sdk/completion.zsh.inc'; fi
