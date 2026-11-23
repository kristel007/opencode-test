#!/usr/bin/env bash
set -euo pipefail

echo "=== OpenCode setup (Codespace) ==="
curl -fsSL https://opencode.ai/v2/install | bash

BIN="$HOME/.opencode/bin/opencode"
if [ ! -x "$BIN" ]; then
  echo "ERROR: opencode binary not found at $BIN" >&2
  exit 1
fi

grep -qF '.opencode/bin' "$HOME/.bashrc" 2>/dev/null || echo 'export PATH="$HOME/.opencode/bin:$PATH"' >> "$HOME/.bashrc"
sudo ln -sf "$BIN" /usr/local/bin/opencode
sudo ln -sf "$BIN" /usr/local/bin/oc

echo "--- proof ---"
oc --version
echo "=== OK. OpenCode is available as: oc ==="
