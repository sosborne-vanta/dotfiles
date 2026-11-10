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
link "$DOTFILES_DIR/claude/voice.md"      "$HOME/.claude/voice.md"
link "$DOTFILES_DIR/claude/voice-samples.md" "$HOME/.claude/voice-samples.md"

# THABTO skill, tracked from wihli/dotfiles main
WIHLI_DOTFILES_DIR="$HOME/.local/share/wihli-dotfiles"
THABTO_SUBDIR="skills/.local/share/skills/thabto"
if [[ -d "$WIHLI_DOTFILES_DIR/.git" ]]; then
  if git -C "$WIHLI_DOTFILES_DIR" pull --quiet --ff-only; then
    success "updated wihli/dotfiles"
  else
    info "could not update $WIHLI_DOTFILES_DIR — using existing checkout"
  fi
elif git clone --quiet --depth 1 --filter=blob:none --sparse \
    https://github.com/wihli/dotfiles.git "$WIHLI_DOTFILES_DIR" \
  && git -C "$WIHLI_DOTFILES_DIR" sparse-checkout set "$THABTO_SUBDIR"; then
  success "cloned wihli/dotfiles"
else
  info "could not clone wihli/dotfiles — skipping thabto skill"
fi
if [[ -f "$WIHLI_DOTFILES_DIR/$THABTO_SUBDIR/SKILL.md" ]]; then
  # SKILL.md hardcodes ~/.local/share/skills/thabto; the agent dirs point at that shared path
  link "$WIHLI_DOTFILES_DIR/$THABTO_SUBDIR" "$HOME/.local/share/skills/thabto"
  link "$HOME/.local/share/skills/thabto"   "$HOME/.claude/skills/thabto"
  link "$HOME/.local/share/skills/thabto"   "$HOME/.agents/skills/thabto"
  link "$HOME/.local/share/skills/thabto"   "$HOME/.codex/skills/thabto"
fi

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

# Buildkite CLI, from the BUILDKITE_API_TOKEN Ona secret
if command -v bk >/dev/null && [[ -n "${BUILDKITE_API_TOKEN:-}" ]]; then
  if bk configure --org VantaInc --token "$BUILDKITE_API_TOKEN" --force >/dev/null; then
    success "configured Buildkite CLI for VantaInc"
  else
    info "bk configure failed — run: bk configure --org VantaInc --force"
  fi
else
  info "skipping Buildkite CLI config (bk or BUILDKITE_API_TOKEN missing)"
fi

success "Done. Open a new shell or run: source ~/.zshrc"
