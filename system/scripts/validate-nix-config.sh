#!/usr/bin/env bash
set -euo pipefail

CONFIG_PATH="${1:-}"
if [[ -z "$CONFIG_PATH" ]]; then
  echo "ERROR: CONFIG_PATH not provided" >&2
  exit 1
fi

if [[ ! -f "$CONFIG_PATH" ]]; then
  echo "ERROR: Nix configuration file not found at $CONFIG_PATH" >&2
  echo "   Private repository access will fail" >&2
  echo "   Ensure sops secrets are properly configured and decrypted" >&2
  exit 1
fi

if [[ ! -r "$CONFIG_PATH" ]]; then
  echo "ERROR: Nix configuration file exists but is not readable" >&2
  exit 1
fi

# Validate configuration format (Nix access-tokens format)
if ! grep -qE "^access-tokens\s*=\s*github\.com\s*=" "$CONFIG_PATH"; then
  echo "ERROR: Nix configuration file has invalid format" >&2
  echo "Expected: access-tokens = github.com=ghp_..." >&2
  echo "Note: Secret contents not displayed for security" >&2
  exit 1
fi

# Check configuration is not placeholder
if grep -q "REPLACE_ME\|CHANGEME\|example" "$CONFIG_PATH"; then
  echo "ERROR: Nix configuration appears to contain placeholders" >&2
  exit 1
fi

echo "✓ Nix configuration validated at $CONFIG_PATH"
