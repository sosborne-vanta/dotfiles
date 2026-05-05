#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

info()    { echo "[dotfiles] $*"; }
success() { echo "[dotfiles] ✓ $*"; }
backup()  { echo "[dotfiles] ↩ backed up $*"; }

link() {
  local src="$1"   # path inside dotfiles repo
  local dst="$2"   # path in home directory

  # If destination is already the correct symlink, nothing to do
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    success "already linked: $dst"
    return
  fi

  # Back up anything that's currently there (real file or wrong symlink)
  if [[ -e "$dst" || -L "$dst" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "${dst#$HOME/}")"
    mv "$dst" "$BACKUP_DIR/${dst#$HOME/}"
    backup "$dst -> $BACKUP_DIR/${dst#$HOME/}"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  success "linked: $dst -> $src"
}

info "Installing dotfiles from $DOTFILES_DIR"

# Shell
link "$DOTFILES_DIR/zshrc"   "$HOME/.zshrc"
link "$DOTFILES_DIR/zprofile" "$HOME/.zprofile"

# Make zsh the login shell so tmux, VS Code terminals, etc. all source ~/.zshrc
ZSH_BIN="$(command -v zsh || true)"
if [[ -n "$ZSH_BIN" ]]; then
  CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"
  if [[ "$CURRENT_SHELL" != "$ZSH_BIN" ]]; then
    if sudo -n chsh -s "$ZSH_BIN" "$USER" 2>/dev/null; then
      success "login shell set to $ZSH_BIN (was $CURRENT_SHELL)"
    else
      info "could not change login shell to $ZSH_BIN — run: sudo chsh -s $ZSH_BIN $USER"
    fi
  else
    success "login shell already $ZSH_BIN"
  fi
else
  info "zsh not found on PATH — skipping login shell change"
fi

# Git
link "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"

# Claude Code
link "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
link "$DOTFILES_DIR/claude/CLAUDE.md"     "$HOME/.claude/CLAUDE.md"

# Create ~/.aliases if it doesn't exist yet (starter file, not repo-tracked)
if [[ ! -f "$HOME/.aliases" ]]; then
  cat > "$HOME/.aliases" <<'EOF'
# Personal aliases — this file is NOT tracked in the dotfiles repo.
# Add your own aliases here; they'll be sourced by .zshrc automatically.

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Listing
alias ll='ls -lah'
alias la='ls -A'

# Git shortcuts
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline -20'
EOF
  info "Created starter ~/.aliases (not repo-tracked — customize freely)"
fi

success "Done. Open a new shell or run: source ~/.zshrc"
