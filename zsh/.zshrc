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

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/inanc/.lmstudio/bin"
# End of LM Studio CLI section

# >>> projects >>>
# p: ~/Projects ve ~/lab/repos altındaki git projelerinden birini fzf ile seçip oraya geç
p() {
  local d
  d=$(find ~/Projects ~/lab/repos -mindepth 2 -maxdepth 5 -name .git -type d -prune 2>/dev/null \
      | sed -e 's|/\.git$||' -e "s|^$HOME/||" | sort | fzf --height 40% --reverse --query "${1:-}") && cd ~/"$d"
}
# gclone sahip/repo: GitHub reposunu ~/Projects/oss/sahip/repo altına klonla
gclone() {
  [ -z "$1" ] && { echo "Kullanım: gclone sahip/repo"; return 1; }
  local dest=~/Projects/oss/"$1"
  [ -d "$dest" ] || gh repo clone "$1" "$dest" || return
  cd "$dest"
}
# newproj isim [personal|work|playground]: yeni proje klasörü + git init
newproj() {
  [ -z "$1" ] && { echo "Kullanım: newproj isim [personal|work|playground]"; return 1; }
  local dest=~/Projects/"${2:-personal}"/"$1"
  [ -e "$dest" ] && { echo "Zaten var: $dest"; return 1; }
  mkdir -p "$dest" && cd "$dest" && git init -q && echo "# $1" > README.md && echo "Oluşturuldu: $dest"
}
# labnew isim: güvenlik çalışması için engagement + repos + reports klasörleri
labnew() {
  [ -z "$1" ] && { echo "Kullanım: labnew isim"; return 1; }
  local e=~/lab/engagements/"$1"
  [ -e "$e" ] && { echo "Zaten var: $e"; return 1; }
  mkdir -p "$e" ~/lab/repos/"$1" ~/lab/reports/"$1"
  sed -e "s/ornek-proje/$1/g" ~/lab/engagements/_template/engagement.yaml > "$e/engagement.yaml"
  echo "Oluşturuldu. Önce yetki ve kapsamı doldur: $e/engagement.yaml"
}
# <<< projects <<<

# >>> nvim-setup >>>
export EDITOR=nvim VISUAL=nvim
alias vim=nvim
alias vi=nvim
# <<< nvim-setup <<<

# >>> workspace >>>
# y: yazi ile gez, çıkınca seçili klasörde kal
y() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
# zj [isim]: bulunduğun klasör adıyla zellij oturumu aç ya da varsa bağlan (dev layout)
zj() {
  zellij attach --create "${1:-${PWD:t}}"
}
alias lg=lazygit
# <<< workspace <<<
