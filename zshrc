#
# Applications
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

#
# Paths
#

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:$HOME/.rbenv/bin:$PATH"

if [[ -s "/usr/local/bin/rbenv"  ]]; then
  # Initialize rbenv
  eval "$(rbenv init - zsh)"
fi

#
# Language
#
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Editors
#
export EDITOR='vim'
export PAGER='less'

#
# Aliases
#
# OSX Specific aliases
if [[ "$OSTYPE" == "darwin"* ]]; then

  # Prefer macvim over regular standard
  if [[ -s "/usr/local/bin/mvim" ]]; then
    alias vim="mvim -v"
  fi
fi

# Bundle
alias bi='bundle install'
alias be='bundle exec'

# Git
alias g='git'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message
alias gp='git push'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'

# Tmux
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Misc
# Output all the term colors and their respective codes
alias colors='( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )'

# Override custom term definitions
alias ssh="TERM=xterm-256color ssh"

# Colorize grep output
export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;33;40'


#
# Settings
#
# ctrl-w removed word backwards

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

if [[ !$KEYBOARD_LAYOUT ]]; then
  echo "KEYBOARD_LAYOUT=qwerty" >> ~/.profile
fi

if [[ $KEYBOARD_LAYOUT == 'workman' ]]; then
  echo "KEYBOARD_LAYOUT=workman" >> ~/.profile
  export FZF_DEFAULT_OPTS="--extended --cycle --bind=ctrl-n:down,ctrl-e:up "

  # see http://www.cs.elte.hu/zsh-manual/zsh_14.html
  bindkey -a 'g' vi-backward-char
  bindkey -a 'n' down-line-or-history
  bindkey -a 'g' vi-backward-char
  bindkey -a 'e' up-line-or-history
  bindkey -a 'o' vi-forward-char
fi

if [[ $KEYBOARD_LAYOUT == 'qwerty' ]]; then
  echo "KEYBOARD_LAYOUT=qwerty" >> ~/.profile
  export FZF_DEFAULT_OPTS="--extended --cycle"
  bindkey -a 'h' vi-backward-char
  bindkey -a 'j' down-line-or-history
  bindkey -a 'k' up-line-or-history
  bindkey -a 'l' vi-forward-char
fi

## Change cursor based on vi mode
echo -ne "\e[4 q" # initial underline
zle-keymap-select() {
  zle editor-info
  if [[ ("$TERM" == "xterm-256color") ||
        ("$TERM" == "screen-256color") ||
        ("$TERM" == "xterm-256color-italic") ||
        ("$TERM" == "screen-256color-italic") ]]; then

    if [ $KEYMAP == vicmd ]; then
      # the command mode for vi
      # echo -ne "\e[2 q" # Solid block
    else
      # the insert mode for vi
      # echo -ne "\e[4 q" # underline
    fi
  fi
}

## Set  layout
workman() {
  export KEYBOARD_LAYOUT="workman"
  source ~/.zshrc
  echo "Keyboard layout switched to $KEYBOARD_LAYOUT"
}

## Set qwerty layout
qwerty() {
  export KEYBOARD_LAYOUT="qwerty";
  source ~/.zshrc
  echo "Keyboard layout switched to $KEYBOARD_LAYOUT"
}

#
# Fuzzy commands
#

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf-tmux +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf-tmux +m) && cd "$dir"
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf-tmux +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# z - display z results within fzf-tmux pane
unalias z 2> /dev/null
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf-tmux +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _z "$@"
  fi
}

# fbr - checkout git branch (including remote branches)
fco() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fshow - git commit browser
fshow() {
  local out sha q
  while out=$(
      git log --decorate=short --graph --oneline --color=always |
      fzf-tmux --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}

# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf-tmux --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# fh - repeat history
fh() {
  print -z $(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf-tmux +s --tac | sed 's/ *[0-9]* *//')
}
