#!/usr/bin/env bash
# SSH configuration validation script
# This runs during home-manager activation to verify SSH config is properly decrypted
# Note: This script warns but does not fail to avoid blocking activation

set -euo pipefail

SSH_HOSTS_FILE="$HOME/.ssh/config.d/hosts"

if [ ! -f "$SSH_HOSTS_FILE" ]; then
  echo "WARNING: SSH hosts file not found at $SSH_HOSTS_FILE" >&2
  echo "This is expected on first activation or if age key is missing." >&2
  echo "SSH will work but encrypted hosts won't be available." >&2
  echo "To fix: Ensure age key exists at ~/.config/sops/age/keys.txt and rebuild." >&2
  exit 0  # Don't block activation
fi

# Log symlink information for debugging sops decryption
if [ -L "$SSH_HOSTS_FILE" ]; then
  TARGET=$(readlink "$SSH_HOSTS_FILE")
  echo "  SSH hosts symlink: $SSH_HOSTS_FILE -> $TARGET"

  # Verify symlink target exists (indicates successful sops decryption)
  if [ ! -e "$TARGET" ]; then
    echo "WARNING: Symlink target does not exist: $TARGET" >&2
    echo "This indicates sops decryption failed." >&2
    exit 0  # Don't block activation
  fi
fi

# Verify permissions (SSH requires 600 or stricter)
# Follow symlink and check that group/others have no permissions
PERMS=$(ls -lL "$SSH_HOSTS_FILE" 2>/dev/null || true)
PERM_STR=$(echo "$PERMS" | cut -d' ' -f1)

# Check that file is not readable/writable by group or others
if [[ ! "$PERM_STR" =~ ^-rw------- ]] && [[ ! "$PERM_STR" =~ ^-r-------- ]]; then
  echo "WARNING: $SSH_HOSTS_FILE has insecure permissions ($PERM_STR)" >&2
  echo "Expected: -rw------- (600) or -r-------- (400)" >&2
  echo "SSH may refuse to use this file. Attempting to fix..." >&2

  # Try to fix permissions
  if chmod 600 "$SSH_HOSTS_FILE" 2>/dev/null; then
    echo "✓ Fixed permissions to 600" >&2
  else
    echo "ERROR: Failed to fix permissions. Manual intervention required." >&2
    exit 0  # Still don't block activation
  fi
fi

echo "✓ SSH hosts configuration validated"
