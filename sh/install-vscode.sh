#!/bin/sh
# install-vscode.sh
# Copies this repository's vscode/*.json files (settings.json, keybindings.json, ...)
# to the local VSCode user (global) settings directory.

set -e

# Parent of the directory containing this script (dotfiles repo path)
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$DOTFILES_DIR/vscode"

# Resolve the VSCode user settings directory per OS
case "$(uname -s)" in
  Darwin) VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User" ;;
  Linux) VSCODE_USER_DIR="$HOME/.config/Code/User" ;;
  MINGW* | MSYS*) VSCODE_USER_DIR="$APPDATA/Code/User" ;;
  *)
    echo "Error: unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
esac

# Verify there are json files to install
if ! ls "$SRC_DIR"/*.json >/dev/null 2>&1; then
  echo "Error: no json files found in $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$VSCODE_USER_DIR"

for SRC in "$SRC_DIR"/*.json; do
  DEST="$VSCODE_USER_DIR/$(basename "$SRC")"

  # Skip if identical, otherwise back up the existing file
  if [ -f "$DEST" ]; then
    if cmp -s "$SRC" "$DEST"; then
      echo "Already up to date: $DEST"
      continue
    fi
    BACKUP="$DEST.bak.$(date +%Y%m%d%H%M%S)"
    cp "$DEST" "$BACKUP"
    echo "Backed up: $DEST -> $BACKUP"
  fi

  cp "$SRC" "$DEST"
  echo "Copied: $SRC -> $DEST"
done
