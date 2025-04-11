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
    "btop"
    "coreutils"
    "curl"
    "eza"
    "fd"
    "fzf"
    "gawk"
    "git"
    "git-delta"
    "git-lfs"
    "jq"
    "ripgrep"
    "tlrc"
    "tmux"
    "wget"
    "zsh"
    "zoxide"

    # Development tools
    "docker-compose"
    "go"
    "gradle"
    "jenv"
    "nvim"
    "nvm"
    "openjdk"
    "python"
    "rbenv"
)

#Applications
casks=(
    ["android-studio"]="homebrew/cask"
    ["cursor"]="homebrew/cask"
    ["homerow"]="homebrew/cask"
    ["lunar"]="homebrew/cask"
    ["postman"]="homebrew/cask"
    ["raycast"]="homebrew/cask"
    ["tidal"]="homebrew/cask"
    ["vysor"]="homebrew/cask"
    ["wezterm"]="homebrew/cask"
    ["yellowdot"]="homebrew/cask"
    ["aerospace"]="nikitabobko/tap"
    ["intellij-idea-ce"]="homebrew/cask"
    ["borders"]="FelixKratz/formulae"
    ["sketchybar"]="FelixKratz/formulae"
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
