#!/usr/bin/env bash
set -euo pipefail

PRIMARY_USER="${1:-}"
if [[ -z "$PRIMARY_USER" ]]; then
  echo "ERROR: PRIMARY_USER not provided" >&2
  exit 1
fi

AGE_KEY_FILE="/Users/$PRIMARY_USER/.config/sops/age/keys.txt"

if [[ ! -f "$AGE_KEY_FILE" ]]; then
  echo "ERROR: sops age key not found at $AGE_KEY_FILE" >&2
  echo "   Secrets decryption will fail. Generate key with:" >&2
  echo "   mkdir -p ~/.config/sops/age && age-keygen -o ~/.config/sops/age/keys.txt" >&2
  echo "   Then add public key to .sops.yaml" >&2
  exit 1
fi

if [[ ! -r "$AGE_KEY_FILE" ]]; then
  echo "ERROR: Age key exists but is not readable" >&2
  exit 1
fi

# Validate file has age key format
if ! grep -q "^AGE-SECRET-KEY-" "$AGE_KEY_FILE"; then
  echo "ERROR: $AGE_KEY_FILE does not contain valid age secret key" >&2
  exit 1
fi

echo "✓ sops age key validated at $AGE_KEY_FILE"
