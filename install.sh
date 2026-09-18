#!/usr/bin/env bash

set -e

# Automatically detect the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "🚀 Starting dotfiles setup from $DOTFILES_DIR..."

mkdir -p "$CONFIG_DIR"

create_symlink() {
  local src="$1"
  local dest="$2"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "⚠️  $dest already exists. Creating backup ($dest.backup)..."
    mv "$dest" "$dest.backup"
  fi

  echo "🔗 Symlinking $src -> $dest"
  ln -s "$src" "$dest"
}

# -----------------------------------------------------------------------------
# 1. SYMLINKS (.config)
# -----------------------------------------------------------------------------
echo "📦 Setting up .config symlinks..."

if [ -d "$DOTFILES_DIR/.config/ghostty" ]; then
  create_symlink "$DOTFILES_DIR/.config/ghostty" "$CONFIG_DIR/ghostty"
fi

if [ -d "$DOTFILES_DIR/.config/nvim" ]; then
  create_symlink "$DOTFILES_DIR/.config/nvim" "$CONFIG_DIR/nvim"
fi

if [ -d "$DOTFILES_DIR/.config/lazygit" ]; then
  create_symlink "$DOTFILES_DIR/.config/lazygit" "$CONFIG_DIR/lazygit"
fi

# -----------------------------------------------------------------------------
# 2. HOME DIRECTORY FILES
# -----------------------------------------------------------------------------
echo "🏠 Setting up HOME directory files..."

if [ -f "$DOTFILES_DIR/.zshrc" ]; then
  create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
fi

if [ -f "$DOTFILES_DIR/.gitconfig" ]; then
  create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
fi

echo "✨ Installation completed successfully!"
