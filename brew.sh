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
    "antidote"         # Plugin manager for zsh
    "btop"             # Resource monitor with graphs
    "coreutils"        # GNU core utilities
    "curl"             # HTTP client
    "eza"              # Modern replacement for ls
    "fd"               # Simple, fast alternative to find
    "fzf"              # Fuzzy finder
    "gawk"             # Fast awk replacement
    "git"              # Version control system
    "git-delta"        # Syntax highlighting pager for git
    "git-lfs"          # Git extension for large files
    "jq"               # JSON processor
    "ripgrep"          # Fast grep alternative
    "starship"         # Cross-shell prompt
    "tlrc"             # Terminal session recorder
    "tmux"             # Terminal multiplexer
    "wget"             # Internet file retriever
    "zsh"              # Z shell
    "zoxide"           # Smarter cd command

    # Development tools
    "docker-compose"   # Define multi-container applications
    "go"               # Go programming language
    "gradle"           # Build automation tool
    "jenv"             # Java version manager
    "nvim"             # Neovim text editor
    "nvm"              # Node version manager
    "openjdk"          # Java development kit
    "python"           # Python programming language
    "rbenv"            # Ruby version manager
)

#Applications
casks=(
    ["android-studio"]="homebrew/cask"      # Android IDE
    ["cursor"]="homebrew/cask"              # AI-first code editor
    ["homerow"]="homebrew/cask"             # Keyboard navigation tool
    ["lunar"]="homebrew/cask"               # Display brightness manager
    ["postman"]="homebrew/cask"             # API development platform
    ["raycast"]="homebrew/cask"             # Productivity launcher
    ["tidal"]="homebrew/cask"               # Music Streaming
    ["vysor"]="homebrew/cask"               # Android screen mirroring
    ["wezterm"]="homebrew/cask"             # GPU-accelerated terminal
    ["yellowdot"]="homebrew/cask"           # Hide MacOS privacy notice
    ["aerospace"]="nikitabobko/tap"         # Window manager for macOS
    ["intellij-idea-ce"]="homebrew/cask"    # Java IDE
    ["borders"]="FelixKratz/formulae"       # Window borders for macOS
    ["sketchybar"]="FelixKratz/formulae"    # Custom macOS menubar
)

# Install packages
echo "Installing packages..."
for package in "${packages[@]}"; do
    echo "Installing $package..."
    brew install "$package"
done

# Install applications
echo "Installing applications..."
for app in "${!casks[@]}"; do
    tap="${casks[$app]}"
    echo "Installing $app from $tap..."
    brew tap "$tap" 2>/dev/null
    brew install --cask "$app"
done

# Remove outdated versions from the cellar
brew cleanup

echo "Homebrew setup complete!"
