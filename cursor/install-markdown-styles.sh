#!/bin/bash
#
# Setup Markdown Preview Enhanced stylesheets
# Links the custom styles from dotfiles to the appropriate location

# Ensure target directory exists
mkdir -p "$HOME/.local/state/crossnote"

# Create symbolic link to stylesheet
if [ -f "$HOME/.local/state/crossnote/style.less" ]; then
  echo "Backing up existing style.less..."
  mv "$HOME/.local/state/crossnote/style.less" "$HOME/.local/state/crossnote/style.less.backup"
fi

echo "Creating symlink for markdown stylesheet..."
ln -sf "$(pwd)/cursor/markdown-styles/style.less" "$HOME/.local/state/crossnote/style.less"

echo "Markdown stylesheets installation complete." 