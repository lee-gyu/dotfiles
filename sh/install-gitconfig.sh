#!/bin/sh
# install-gitconfig.sh
# Adds an include of this repository's gitconfig to the global git config (~/.gitconfig).

set -e

# Parent of the directory containing this script (dotfiles repo path)
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
GITCONFIG="$DOTFILES_DIR/config/gitconfig"

# Verify the target gitconfig file exists
if [ ! -f "$GITCONFIG" ]; then
  echo "Error: $GITCONFIG not found." >&2
  exit 1
fi

# Skip if the include path is already present
if git config --global --get-all include.path | grep -qxF "$GITCONFIG"; then
  echo "Already configured: include.path = $GITCONFIG"
else
  git config --global --add include.path "$GITCONFIG"
  echo "Added: ~/.gitconfig -> include.path = $GITCONFIG"
fi
