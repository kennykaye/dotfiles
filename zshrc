#
# Applications
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"  ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source Z jump-navigation
source ~/.zsh/z/z.sh

# custom prompt
# source ~/.zsh/zsh_prompt.sh

#
# Paths
#

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:$HOME/.rbenv/bin:$PATH"

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
alias vim="mvim -v"
alias chat="sh ~/.scripts/bin/chat.sh"
alias commitary="sh ~/.scripts/bin/commitary.sh"
alias mcms="sh ~/.scripts/bin/mcms.sh"
alias mcms-vagrant="sh ~/.scripts/bin/mcms-vagrant.sh"
alias pro-services="sh ~/.scripts/bin/pro-services.sh"

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


#
# Vi-mode Improvements
#
# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# reduce character sequence timeout from 400ms to 10ms
KEYTIMEOUT=1

#
# Aesthetics
#
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
