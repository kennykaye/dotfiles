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
export PATH=~/.chefdk:/opt/chefdk/bin:$PATH

# Initialize rbenv
eval "$(rbenv init -)"

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
# export VISUAL='nano'
export PAGER='less'

#
# Aliases
#
# OSX Specific aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
  # alias vim="nvim"
  alias vim="mvim -v"
  alias mamp-pro="sudo sh '/Applications/MAMP PRO/bin/start.sh'"
fi

# Vagrant
alias vag="vagrant"

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

# Postgres
alias pg='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'

# Redis
alias redis-start='redis-server /usr/local/etc/redis.conf'

# Pow
alias pow='touch ~/.pow/restart.txt'

# Misc
# Output all the term colors and their respective codes
alias colors='( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )'

#
# Settings
#
# ctrl-w removed word backwards
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
