#!/usr/bin/env bash
set -euo pipefail

echo "=== OpenCode setup (Codespace) ==="
npm install -g @opencode/cli

BIN="$(command -v opencode)"
if [ -z "$BIN" ]; then
  echo "ERROR: opencode binary not found after install" >&2
  exit 1
fi

sudo ln -sf "$BIN" /usr/local/bin/oc

echo "--- proof ---"
oc --version
echo "=== OK. OpenCode is available as: oc ==="
