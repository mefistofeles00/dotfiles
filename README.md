# dotfiles

Terminal odaklı, açık kaynak geliştirme ortamı. Her araç kendi paketinde durur ve
[GNU stow](https://www.gnu.org/software/stow/) ile `~` altına bağlanır.

| Paket | Nereye bağlanır | Ne |
|---|---|---|
| `nvim/` | `~/.config/nvim` | Neovim (LazyVim tabanlı) + yerel LLM (LM Studio) + Claude Code |

## Kurulum

```bash
git clone <bu-repo> ~/Projects/personal/dotfiles
cd ~/Projects/personal/dotfiles
./install.sh
```

`install.sh` Homebrew paketlerini kurar ve `stow` ile bağlantıları oluşturur.
Mevcut bir `~/.config/nvim` varsa önce onu kenara al.

## Neovim

- Tabanı [LazyVim](https://www.lazyvim.org). Ek paketler `lua/plugins/`, ayarlar `lua/config/`.
- `lua/config/llm.lua`: LM Studio adresi ve model adları tek yerden değişir.
- `<leader>a` grubu AI içindir (`<space>a` yazınca which-key listeler):
  - `<leader>aa` sohbet (CodeCompanion, LM Studio)
  - `<leader>ai` satır içi düzenleme
  - `<leader>ap` eylem paleti
  - `<leader>ac` Claude Code'u sağda terminal olarak aç/kapat
  - `<leader>am` satır içi tamamlamayı (minuet) aç/kapat
- Satır içi tamamlama önerisi: `Alt-a` kabul, `Alt-l` sadece satır, `Alt-e` kapat.
- LM Studio sunucusu açık olmalı: `lms server start` (port `llm.lua` içinde).

## Geliştirme

Yeni bir araç eklemek için `araç/.config/araç/...` yapısında paket aç, `install.sh`
içindeki `PACKAGES` listesine ekle.
