#!/usr/bin/env bash
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
TS="$(date +'%Y%m%d-%H%M%S')"
LOG="$ROOT/SESSION_LOG.md"
SNAPDIR="$ROOT/snapshots"
mkdir -p "$SNAPDIR"

echo "## Session $TS" >> "$LOG"
echo "- Branch: $(git rev-parse --abbrev-ref HEAD)" >> "$LOG"
echo "- Uncommitted changes: $(git status --porcelain | wc -l)" >> "$LOG"
echo "- Next steps summary:" >> "$LOG"
if [ -f "$ROOT/NEXT_STEPS.md" ]; then
  grep '^- \[.\]' "$ROOT/NEXT_STEPS.md" | sed 's/^/  /' >> "$LOG" || true
fi
echo "" >> "$LOG"

git diff > "$SNAPDIR/$TS.patch" || true
echo "Snapshot written to snapshots/$TS.patch"
