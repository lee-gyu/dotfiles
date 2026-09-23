#!/bin/sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
KARABINER_DIR="$HOME/.config/karabiner/assets/complex_modifications"

mkdir -p "$KARABINER_DIR"
cp "$DOTFILES_DIR/config/karabiner-mac-except-windows-app.json" "$KARABINER_DIR/"

echo "Copied karabiner config"
