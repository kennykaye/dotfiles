#!/bin/bash
#
# Cursor extensions manager
# Helps export and install Cursor extensions for dotfiles

EXTENSIONS_FILE="$(dirname "$0")/extensions.txt"

# Create directory for extensions file if it doesn't exist
mkdir -p "$(dirname "$EXTENSIONS_FILE")"

export_extensions() {
  echo "Exporting Cursor extensions to $EXTENSIONS_FILE..."
  cursor --list-extensions > "$EXTENSIONS_FILE"
  
  if [ $? -eq 0 ]; then
    echo "Successfully exported $(wc -l < "$EXTENSIONS_FILE") extensions"
  else
    echo "Error: Failed to export extensions"
    exit 1
  fi
}

install_extensions() {
  if [ ! -f "$EXTENSIONS_FILE" ]; then
    echo "Error: Extensions file not found at $EXTENSIONS_FILE"
    exit 1
  fi
  
  echo "Installing Cursor extensions from $EXTENSIONS_FILE..."
  
  total=$(wc -l < "$EXTENSIONS_FILE")
  current=0
  
  while IFS= read -r extension || [ -n "$extension" ]; do
    if [ -n "$extension" ]; then
      current=$((current + 1))
      echo "[$current/$total] Installing $extension..."
      cursor --install-extension "$extension"
    fi
  done < "$EXTENSIONS_FILE"
  
  echo "Finished installing extensions"
}

case "$1" in
  export)
    export_extensions
    ;;
  install)
    install_extensions
    ;;
  *)
    echo "Usage: $0 [export|install]"
    echo ""
    echo "Commands:"
    echo "  export   - Export currently installed Cursor extensions to $EXTENSIONS_FILE"
    echo "  install  - Install extensions from $EXTENSIONS_FILE"
    exit 1
    ;;
esac

exit 0 