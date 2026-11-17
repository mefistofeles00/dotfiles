#!/usr/bin/env bash
# dotfiles kurulumu: brew paketleri + stow bağlantıları
set -euo pipefail
cd "$(dirname "$0")"

PACKAGES=(zsh starship ghostty nvim zellij yazi)
BREW=(stow starship zoxide fzf eza bat zsh-autosuggestions zsh-syntax-highlighting
      neovim ripgrep fd lazygit tree-sitter-cli zellij yazi)
CASKS=(ghostty font-jetbrains-mono-nerd-font)

command -v brew >/dev/null || { echo "Homebrew yok: https://brew.sh"; exit 1; }
echo "==> brew paketleri"
brew install "${BREW[@]}"
brew install --cask "${CASKS[@]}" || true

# mevcut dosyalar stow'u engellemesin: yedekle
for f in ~/.zshrc ~/.config/starship.toml ~/.config/ghostty/config; do
  [ -e "$f" ] && [ ! -L "$f" ] && mv "$f" "$f.bak-$(date +%Y%m%d%H%M)" && echo "yedeklendi: $f"
done

echo "==> stow"
for p in "${PACKAGES[@]}"; do
  stow --restow --target="$HOME" --verbose=1 "$p"
done
echo "==> yazi tema/eklentileri"
ya pkg install || true

echo "Tamam. Yeni bir kabuk aç; nvim'i açınca eklentiler kendiliğinden kurulur."
