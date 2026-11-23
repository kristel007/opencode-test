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

# Any new terminal starts OpenCode automatically (iPhone: zero typing).
if ! grep -qF 'OpenCode auto-start for iPhone' "$HOME/.bashrc" 2>/dev/null; then
  printf '\n# OpenCode auto-start for iPhone\nif [ -t 0 ] && [ -z "${OC_AUTOSTART_DONE:-}" ] && [ -f "$HOME/.opencode-autostart" ]; then\n  export OC_AUTOSTART_DONE=1\n  cd /workspaces/opencode-test 2>/dev/null || true\n  exec oc\nfi\n' >> "$HOME/.bashrc"
fi
touch "$HOME/.opencode-autostart"

echo "--- proof ---"
oc --version
echo "=== OK. OpenCode starts automatically. ==="
