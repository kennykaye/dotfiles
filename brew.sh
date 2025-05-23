#!/bin/bash

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for the current session
    if [[ $(uname -m) == "arm64" ]]; then
        # For Apple Silicon Macs
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        # For Intel Macs
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Homebrew is already installed."
fi

# Make sure we're using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Array of packages to install
packages=(
    # Core utils
    "antidote"                       # Plugin manager for zsh
    "bat"                            # Pager and preview
    "btop"                           # Resource monitor with graphs
    "coreutils"                      # GNU core utilities
    "curl"                           # HTTP client
    "eza"                            # Modern replacement for ls
    "fd"                             # Simple, fast alternative to find
    "fzf"                            # Fuzzy finder
    "gawk"                           # Fast awk replacement
    "git"                            # Version control system
    "git-delta"                      # Syntax highlighting pager for git
    "git-lfs"                        # Git extension for large files
    "gitmux"                         # Git tmux extension
    "jq"                             # JSON processor
    "reattach-to-user-namespace"     # Tmux clipboard utility
    "ripgrep"                        # Fast grep alternative
    "sesh"                           # Tmux session management
    "starship"                       # Cross-shell prompt
    "tlrc"                           # Terminal session recorder
    "tmux"                           # Terminal multiplexer
    "tmp"                            # Tmux Plugin Manager
    "wget"                           # Internet file retriever
    "zsh"                            # Z shell
    "zoxide"                         # Smarter cd command

    # Development tools
    "docker-compose"                 # Define multi-container applications
    "luarocks"                       # Lua package manager
    "go"                             # Go programming language
    "gradle"                         # Build automation tool
    "jenv"                           # Java version manager
    "nvim"                           # Neovim text editor
    "nvm"                            # Node version manager
    "openjdk"                        # Java development kit
    "python"                         # Python programming language
    "rbenv"                          # Ruby version manager

    # Just for fun
    "cmatrix"
)

# Casks
declare -a cask_names=(
    "android-studio"
    "areospace"
    "borders"
    "cursor"
    "elgato-wave-link"
    "font-fira-code-nerd-font"
    "homerow"
    "intellij-idea-ce"
    "lunar"
    "postman"
    "raycast"
    "sf-symbols"
    "sketchybar"
    "tidal"
    "vysor"
    "wezterm"
    "yellowdot"
)

# Special taps and their casks
brew tap nikitabobko/tap
brew tap FelixKratz/formulae
brew tap arl/arl

# Install packages
echo "Installing packages..."
for package in "${packages[@]}"; do
    echo "Installing $package..."
    brew install "$package"
done

# Install standard casks
echo "Installing casks..."
for cask in "${cask_names[@]}"; do
    echo "Installing $cask..."
    brew install --cask "$cask"
done

# Remove outdated versions from the cellar
brew cleanup

echo "Homebrew setup complete!"
