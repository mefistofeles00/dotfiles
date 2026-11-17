# dotfiles

A terminal-centric, open-source development environment. Each tool lives in its own
package and is linked into `~` with [GNU stow](https://www.gnu.org/software/stow/).
Theme is Catppuccin Mocha everywhere, font is JetBrainsMono Nerd Font.

| Package | Linked to | What |
|---|---|---|
| `zsh/` | `~/.zshrc` | shell: fzf, zoxide, eza, bat, project and workspace helpers |
| `starship/` | `~/.config/starship.toml` | prompt |
| `ghostty/` | `~/.config/ghostty/config` | terminal |
| `nvim/` | `~/.config/nvim` | editor: LazyVim + local LLM (LM Studio) + Claude Code |
| `zellij/` | `~/.config/zellij` | panes / tabs / persistent sessions, `dev` layout |
| `yazi/` | `~/.config/yazi` | file manager |
| `lazygit/` | `~/.config/lazygit` | git TUI |

`~/.zprofile` is not in the repo: machine-specific paths (Java, Postgres, Ghidra, lab) stay there.

## Install

```bash
git clone https://github.com/mefistofeles00/dotfiles ~/Projects/personal/dotfiles
cd ~/Projects/personal/dotfiles
./install.sh
```

`install.sh` installs the Homebrew packages, moves conflicting existing files aside as
`.bak-*`, creates the stow links and fetches the yazi flavor.

## Daily flow

```
cd project && zj      # zellij session named after the folder: code (nvim) | shell | git (lazygit)
```

- `p` pick a project with fzf, `y` browse with yazi and stay in the chosen folder on exit, `lg` lazygit.
- zellij: `Ctrl+p` pane, `Ctrl+t` tab, `Alt+h/j/k/l` focus, `Ctrl+g` lock (pass keys through to nvim),
  `Ctrl+o d` detach, `zj` to come back.

## Neovim

- Based on [LazyVim](https://www.lazyvim.org). Extra plugins in `lua/plugins/`, settings in `lua/config/`.
- `lua/config/llm.lua`: LM Studio URL and model names, changed in one place.
- The `<leader>a` group is for AI (type `<space>a` and which-key lists it):
  - `<leader>aa` chat (CodeCompanion, LM Studio)
  - `<leader>ai` inline edit, `<leader>ap` action palette, `<leader>ad` add selection to chat
  - `<leader>ac` toggle Claude Code as a terminal on the right
  - `<leader>am` toggle inline completion (minuet)
- Inline suggestions: `Alt-a` accept, `Alt-s` accept line, `Alt-, / Alt-.` previous/next, `Alt-e` dismiss.
- The LM Studio server must be running: `lms server start` (port is set in `llm.lua`).
- Models think by default; completion requests send `reasoning_effort = "none"` to turn it off.

## Extending

To add a tool, create a package laid out as `tool/.config/tool/...` and add it to the
`PACKAGES` and `BREW` lists in `install.sh`.
