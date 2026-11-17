# >>> terminal-setup >>>
HISTSIZE=50000; SAVEHIST=50000; HISTFILE=~/.zsh_history
setopt SHARE_HISTORY HIST_IGNORE_DUPS AUTO_CD
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
BREW="$(brew --prefix)"
source "$BREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$BREW/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source <(fzf --zsh)
eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --git --group-directories-first'
alias tree='eza --tree --icons'
alias cat='bat --paging=never --style=plain'
# <<< terminal-setup <<<

# LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"

# >>> projects >>>
# p: pick a git project under ~/Projects or ~/lab/repos with fzf and cd into it
p() {
  local d
  d=$(find ~/Projects ~/lab/repos -mindepth 2 -maxdepth 5 -name .git -type d -prune 2>/dev/null \
      | sed -e 's|/\.git$||' -e "s|^$HOME/||" | sort | fzf --height 40% --reverse --query "${1:-}") && cd ~/"$d"
}
# gclone owner/repo: clone a GitHub repo into ~/Projects/oss/owner/repo
gclone() {
  [ -z "$1" ] && { echo "Usage: gclone owner/repo"; return 1; }
  local dest=~/Projects/oss/"$1"
  [ -d "$dest" ] || gh repo clone "$1" "$dest" || return
  cd "$dest"
}
# newproj name [personal|work|playground]: new project folder + git init
newproj() {
  [ -z "$1" ] && { echo "Usage: newproj name [personal|work|playground]"; return 1; }
  local dest=~/Projects/"${2:-personal}"/"$1"
  [ -e "$dest" ] && { echo "Already exists: $dest"; return 1; }
  mkdir -p "$dest" && cd "$dest" && git init -q && echo "# $1" > README.md && echo "Created: $dest"
}
# labnew name: engagement + repos + reports folders for a security assessment
labnew() {
  [ -z "$1" ] && { echo "Usage: labnew name"; return 1; }
  local e=~/lab/engagements/"$1"
  [ -e "$e" ] && { echo "Already exists: $e"; return 1; }
  mkdir -p "$e" ~/lab/repos/"$1" ~/lab/reports/"$1"
  sed -e "s/ornek-proje/$1/g" ~/lab/engagements/_template/engagement.yaml > "$e/engagement.yaml"
  echo "Created. Fill in authorization and scope first: $e/engagement.yaml"
}
# <<< projects <<<

# >>> nvim-setup >>>
export EDITOR=nvim VISUAL=nvim
alias vim=nvim
alias vi=nvim
# <<< nvim-setup <<<

# >>> workspace >>>
# y: browse with yazi and stay in the selected folder on exit
y() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
# zj [name]: open a zellij session named after the current folder, or attach if it exists (dev layout)
zj() {
  zellij attach --create "${1:-${PWD:t}}"
}
alias lg=lazygit
# <<< workspace <<<
