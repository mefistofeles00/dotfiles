# dotfiles

Terminal odaklı, açık kaynak geliştirme ortamı. Her araç kendi paketinde durur ve
[GNU stow](https://www.gnu.org/software/stow/) ile `~` altına bağlanır. Tema her yerde
Catppuccin Mocha, yazı tipi JetBrainsMono Nerd Font.

| Paket | Nereye bağlanır | Ne |
|---|---|---|
| `zsh/` | `~/.zshrc` | kabuk: fzf, zoxide, eza, bat, proje ve iş alanı fonksiyonları |
| `starship/` | `~/.config/starship.toml` | prompt |
| `ghostty/` | `~/.config/ghostty/config` | terminal |
| `nvim/` | `~/.config/nvim` | editör: LazyVim + yerel LLM (LM Studio) + Claude Code |
| `zellij/` | `~/.config/zellij` | panel / sekme / kalıcı oturum, `dev` layout |
| `yazi/` | `~/.config/yazi` | dosya gezgini |

`~/.zprofile` repoda değil: makineye özel yollar (Java, Postgres, Ghidra, lab) orada kalır.

## Kurulum

```bash
git clone <bu-repo> ~/Projects/personal/dotfiles
cd ~/Projects/personal/dotfiles
./install.sh
```

`install.sh` Homebrew paketlerini kurar, çakışan mevcut dosyaları `.bak-*` olarak kenara
alır, `stow` ile bağlantıları oluşturur ve yazi temasını indirir.

## Günlük akış

```
cd proje && zj        # klasör adıyla zellij oturumu: code (nvim) | shell | git (lazygit)
```

- `p` projeler arasında seç (fzf), `y` yazi ile gez ve çıkınca o klasörde kal, `lg` lazygit.
- zellij: `Ctrl+p` panel, `Ctrl+t` sekme, `Alt+h/j/k/l` odak, `Ctrl+g` kilit (tuşları nvim'e bırak),
  `Ctrl+o d` oturumdan ayrıl, `zj` ile geri dön.

## Neovim

- Tabanı [LazyVim](https://www.lazyvim.org). Ek paketler `lua/plugins/`, ayarlar `lua/config/`.
- `lua/config/llm.lua`: LM Studio adresi ve model adları tek yerden değişir.
- `<leader>a` grubu AI içindir (`<space>a` yazınca which-key listeler):
  - `<leader>aa` sohbet (CodeCompanion, LM Studio)
  - `<leader>ai` satır içi düzenleme, `<leader>ap` eylem paleti, `<leader>ad` seçimi sohbete ekle
  - `<leader>ac` Claude Code'u sağda terminal olarak aç/kapat
  - `<leader>am` satır içi tamamlamayı (minuet) aç/kapat
- Satır içi öneri: `Alt-a` kabul, `Alt-s` sadece satır, `Alt-, / Alt-.` önceki/sonraki, `Alt-e` kapat.
- LM Studio sunucusu açık olmalı: `lms server start` (port `llm.lua` içinde).
- Modeller varsayılan olarak "düşünür"; tamamlama isteklerinde `reasoning_effort = "none"` gönderilir.

## Geliştirme

Yeni bir araç eklemek için `araç/.config/araç/...` yapısında paket aç, `install.sh`
içindeki `PACKAGES` ve `BREW` listelerine ekle.
