#!/usr/bin/env bash
# Age key check script
# This runs during home-manager activation to verify age key exists
# Note: This script warns but does not fail to avoid blocking activation

set -euo pipefail

AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
SSH_HOSTS_FILE="$HOME/.ssh/config.d/hosts"

if [ ! -f "$AGE_KEY_FILE" ]; then
  echo "⚠️  WARNING: Age key not found at $AGE_KEY_FILE" >&2
  echo "   SSH host decryption will fail. SSH will work but encrypted hosts won't be available." >&2
  echo "   To fix: Place your age private key at $AGE_KEY_FILE and rebuild." >&2
  echo "" >&2

  # Create empty hosts file as fallback so SSH Include doesn't fail
  mkdir -p "$HOME/.ssh/config.d"
  touch "$SSH_HOSTS_FILE"
  chmod 600 "$SSH_HOSTS_FILE"
  echo "   Created empty $SSH_HOSTS_FILE as fallback" >&2
fi
