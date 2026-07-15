#!/usr/bin/env bash
# Generate keymaps.md from the live nvim config (headless).
# Loads full config, force-loads NvimTree so tree buffer-local maps are captured,
# then dumps all keymaps grouped by focus/mode/domain.
#
# Usage:
#   scripts/gen-keymaps.sh [output.md]
# Default output: ./keymaps.md

set -euo pipefail

OUT="${1:-$(pwd)/keymaps.md}"

# Resolve to an absolute path so nvim's cwd changes don't matter.
case "$OUT" in
  /*) ;;
  *) OUT="$(pwd)/$OUT" ;;
esac

nvim --headless \
  -c 'lua vim.wait(5000, function() return package.loaded["lazy"] ~= nil end)' \
  -c 'lua pcall(function() require("lazy").load({ plugins = { "nvim-tree.lua" } }) end)' \
  -c 'silent! NvimTreeOpen' \
  -c 'lua vim.wait(800)' \
  -c "lua require('configs.keymap_dump').generate('${OUT}')" \
  -c 'qa!' 2>/dev/null

if [ -f "$OUT" ]; then
  echo "Keymaps written to $OUT"
else
  echo "Failed: $OUT not created" >&2
  exit 1
fi
