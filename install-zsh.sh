#!/bin/sh
# install-zsh.sh
# Adds a line to ~/.zshrc to source this repository's .zshrc file.

set -e

# Directory containing this script (dotfiles repo path)
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

ZSHRC="$HOME/.zshrc"
SOURCE_LINE="source \"$DOTFILES_DIR/.zshrc\""

# Verify the target .zshrc file exists
if [ ! -f "$DOTFILES_DIR/.zshrc" ]; then
  echo "Error: $DOTFILES_DIR/.zshrc not found." >&2
  exit 1
fi

# Create ~/.zshrc if it does not exist
if [ ! -f "$ZSHRC" ]; then
  touch "$ZSHRC"
  echo "Created: $ZSHRC"
fi

# Skip if the source line is already present
if grep -qF "$SOURCE_LINE" "$ZSHRC"; then
  echo "Already configured: $SOURCE_LINE"
else
  {
    echo ""
    echo "# Load dotfiles configuration"
    echo "$SOURCE_LINE"
  } >> "$ZSHRC"
  echo "Added: $ZSHRC -> $SOURCE_LINE"
fi

echo "Done! Run 'source ~/.zshrc' or open a new terminal to apply."
