#!/usr/bin/env bash
# dotfiles install: brew packages + stow links
set -euo pipefail
cd "$(dirname "$0")"

PACKAGES=(zsh starship ghostty nvim zellij yazi)
BREW=(stow starship zoxide fzf eza bat zsh-autosuggestions zsh-syntax-highlighting
      neovim ripgrep fd lazygit tree-sitter-cli zellij yazi)
CASKS=(ghostty font-jetbrains-mono-nerd-font)

command -v brew >/dev/null || { echo "Homebrew not found: https://brew.sh"; exit 1; }
echo "==> brew packages"
brew install "${BREW[@]}"
brew install --cask "${CASKS[@]}" || true

# back up existing files so they don't block stow
for f in ~/.zshrc ~/.config/starship.toml ~/.config/ghostty/config; do
  [ -e "$f" ] && [ ! -L "$f" ] && mv "$f" "$f.bak-$(date +%Y%m%d%H%M)" && echo "backed up: $f"
done

echo "==> stow"
for p in "${PACKAGES[@]}"; do
  stow --restow --target="$HOME" --verbose=1 "$p"
done

echo "==> yazi flavors/plugins"
ya pkg install || true

echo "Done. Open a new shell; nvim installs its plugins on first launch."
