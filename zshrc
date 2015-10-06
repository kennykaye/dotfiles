#
# Source applications and runcom files
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"  ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source Base16
if [[ -s "$HOME/.config/base16-shell/base16-eighties.dark.sh" ]]; then
  source "$HOME/.config/base16-shell/base16-eighties.dark.sh"
fi

# Source Z jump-navigation
source ~/.zsh/z/z.sh

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load our dotfiles like ~/.functions, etc…
#   ~/.extra can be used for settings you don’t want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,aliases,functions}; do
  [ -f "$file" ] && source "$file"
done
unset file



#
# Configurations
#

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"
export PATH="$PATH:$HOME/.rbenv/bin"

if [[ -s "/usr/local/bin/rbenv"  ]]; then
  # Initialize rbenv
  eval "$(rbenv init - zsh)"
fi

# Language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Editors
export EDITOR='vim'
export PAGER='less'

# Colorize grep output
export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;33;40'

# Default to qwerty
bindkey '^w' backward-kill-word

# Paste fzf output to command line
bindkey '^P' fzf-file-widget

# enable extended globbing
setopt extended_glob

# passes the bad match onto the command, so we can HEAD^
setopt NO_NOMATCH

# reduce character sequence timeout from 400ms to 10ms
export KEYTIMEOUT=1

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -l -g ""'

# Default to qwerty layout
if [[ -z $KEYBOARD_LAYOUT ]]; then
  echo "KEYBOARD_LAYOUT=qwerty" >> ~/.profile
fi

# Workman bindings
if [[ $KEYBOARD_LAYOUT == 'workman' ]]; then
  echo "KEYBOARD_LAYOUT=workman" >> ~/.profile
  export FZF_DEFAULT_OPTS="--extended --cycle --bind=ctrl-n:down,ctrl-e:up "
  bindkey -a 'y' vi-backward-char
  bindkey -a 'n' down-line-or-history
  bindkey -a 'y' vi-backward-char
  bindkey -a 'e' up-line-or-history
  bindkey -a 'o' vi-forward-char
fi

# Qwerty bindings
if [[ $KEYBOARD_LAYOUT == 'qwerty' ]]; then
  echo "KEYBOARD_LAYOUT=qwerty" >> ~/.profile
  export FZF_DEFAULT_OPTS="--extended --cycle"
  bindkey -a 'h' vi-backward-char
  bindkey -a 'j' down-line-or-history
  bindkey -a 'k' up-line-or-history
  bindkey -a 'l' vi-forward-char
fi
