#!/usr/bin/env bash
# dotfiles kurulumu: brew paketleri + stow bağlantıları
set -euo pipefail
cd "$(dirname "$0")"

PACKAGES=(nvim)
BREW=(neovim stow ripgrep fd lazygit tree-sitter-cli)

command -v brew >/dev/null || { echo "Homebrew yok: https://brew.sh"; exit 1; }
echo "==> brew paketleri"
brew install "${BREW[@]}"

echo "==> stow"
for p in "${PACKAGES[@]}"; do
  stow --restow --target="$HOME" --verbose=1 "$p"
done
echo "Tamam. nvim'i açınca eklentiler kendiliğinden kurulur."
