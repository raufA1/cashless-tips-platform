#!/usr/bin/env bash
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TS="$(date -u +'%Y-%m-%d %H:%M:%S UTC')"

if command -v claude >/dev/null 2>&1; then
  bash "$ROOT/scripts/claude_cli_analyze.sh"
else
  python3 "$ROOT/scripts/ai_analyze.py"
fi

echo -e "\n---\nGenerated: $TS" >> "$ROOT/STATUS.md"
bash "$ROOT/scripts/extract_next_steps.sh"
echo "Analysis complete → STATUS.md + NEXT_STEPS.md"
