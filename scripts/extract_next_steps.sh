#!/usr/bin/env bash
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
IN="$ROOT/STATUS.md"
OUT="$ROOT/NEXT_STEPS.md"

if [ ! -f "$IN" ]; then
  echo "STATUS.md not found. Run make analyze first." >&2
  exit 1
fi

awk '
  BEGIN{capture=0}
  /^##[[:space:]]*Next[[:space:]]*steps/i {print "# Next Steps"; capture=1; next}
  /^##[[:space:]]/ { if(capture==1){exit} }
  { if(capture==1 && ($0 ~ /^- [\[\(]/ || $0 ~ /^- \[/ || $0 ~ /^- /)) print $0 }
' "$IN" > "$OUT"

if [ ! -s "$OUT" ]; then
  echo "# Next Steps" > "$OUT"
  echo "- [ ] (could not parse from STATUS.md) Pick 1–3 tasks manually and update this file." >> "$OUT"
fi

echo -e "\n> Tip: check items as you finish; commit this file daily." >> "$OUT"
