#
# Source applications and runcom files
#
eval "$(/opt/homebrew/bin/brew shellenv)"

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

# zsh-vi mode config
zvm_config() {
  ZVM_INIT_MODE=sourcing
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
  ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT  # Always start new prompt in insert mode
}

# zsh plugin management, see ~/.zsh_plugins.txt
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load

# Deferred Plugin loading

lazyload zoxide -- 'eval "$(zoxide init zsh)"'
lazyload nvm -- 'source /opt/homebrew/opt/nvm/nvm.sh && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"'
lazyload jenv -- 'eval "$(jenv init -)"; jenv enable-plugin export'
lazyload rbenv -- '[[ -s "/opt/homebrew/bin/rbenv" ]] && eval "$(rbenv init - zsh)"'
lazyload pyenv -- 'eval "$(pyenv init - zsh)"'

# Auto-activate environment managers when version files are detected
auto_activate_env_managers() {
  [[ -f .python-version ]] && pyenv &>/dev/null
  [[ -f .java-version ]] && jenv &>/dev/null
  [[ -f .ruby-version ]] && rbenv &>/dev/null
}

autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate_env_managers
auto_activate_env_managers

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh prompt
eval "$(fzf --zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

type starship_zle-keymap-select >/dev/null || \
  {
    eval "$(starship init zsh)"
  }

# Load our dotfiles like ~/.functions, etc…
#   ~/.extra can be used for settings you don't want to commit,
#   Use it to configure your PATH, thus it being first in line.
for file in ~/.{extra,aliases,functions}; do
  [ -f "$file" ] && source "$file"
done
unset file

# General configuration
export EDITOR='nvim'
export PAGER='less'
export MANPAGER='nvim +Man!'
export KEYTIMEOUT=1
export BAT_CONFIG_PATH="$HOME/.bat.conf"
[[ -z "$LANG" ]] && export LANG='en_US.UTF-8'
[[ -n "$TMUX" ]] && export TERM="tmux-256color" || export TERM="wezterm"

# Use prefixed search as widget
zle -N up-line-or-search-prefix

# Raise max file limit
ulimit -n 2048

setopt autocd                # allow implicit cd. e.g: ../..
setopt extended_glob         # enable extended globbing
setopt NO_NOMATCH            # passes the bad match onto the command, so we can HEAD^
# stty -ixon                   # disable flow control  (^S/^Q)

# ---- Key Bindings -----
bindkey '^w' backward-kill-word      # Delete prior word
bindkey '^P' fzf-file-widget         # Search files and folders
bindkey '^Z' _zoxide_zi_with_accept  # Interactize z
bindkey '^G' fzf-cd-widget           # (G)o to a directory
bindkey '^F' ripgrep_fzf_vim         # (F)ind text in a file, then open it

# ---- FZF -----
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"


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

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview' --border-label=' Files '"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_CTRL_R_OPTS="--preview-window=hidden --reverse --border-label=' Command History '"
local fzf_color="--color=fg:${fg},bg:${bg},hl:${yellow},fg+:${fg},bg+:${bg_highlight},hl+:${yellow},info:${gray},prompt:${red},pointer:${bg_highlight},marker:${cyan},spinner:${green},header:${cyan},gutter:${black},border:${gray}"
local fzf_ops="--prompt='❯ ' --info=inline-right --margin=1,2  --color=label:yellow"

# Set base FZF options with better styling

# Support for FZF_DEFAULT_COMMAND and other FZF environment variables
# Keep static settings for compatibility with plugins
if [[ "$TERM" == *"tmux"* ]]; then
  export FZF_DEFAULT_OPTS="$fzf_color $fzf_ops --tmux=60%"

else
  export FZF_DEFAULT_OPTS="$fzf_color $fzf_ops"
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
    preview_pos="right:50%:border-left"
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

# Path configuration
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="$PATH:/usr/local/mysql/bin/"
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
export PATH="$PATH:/Users/kenny.kaye/Library/Python/3.9/bin"

export MANPATH="/opt/local/man:/usr/local/man:/usr/bin/:$MANPATH"
export MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"

export GOPATH="$HOME/Development/go"
