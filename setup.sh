#!/usr/bin/env bash
# Free edition: one thin company. No roster, skills library, hop, or history.
set -euo pipefail
NAME="${1:-}"
if [[ -z "$NAME" || "$NAME" == -* ]]; then
  echo "usage: ./setup.sh <product-name>" >&2
  exit 1
fi
SLUG="$(printf '%s' "$NAME" | tr '[:upper:]' '[:lower:]' | tr -c 'a-z0-9-' '-' | sed 's/-*$//')"
ROOT="$(cd "$(dirname "$0")" && pwd)"
DEST="$ROOT/.agents/${SLUG}-company"
if [[ -e "$DEST" ]]; then
  echo "already exists: $DEST" >&2
  exit 1
fi
mkdir -p "$DEST/system/staffs/leadership" "$DEST/system/staffs/build" \
  "$DEST/cache/plans" "$DEST/system/skills/free/write-plan"
cp "$ROOT/free/COMPANY.md" "$DEST/COMPANY.md"
sed "s/{{SLUG}}/$SLUG/g" "$ROOT/free/ceo.md" > "$DEST/system/staffs/leadership/ceo.md"
sed "s/{{SLUG}}/$SLUG/g" "$ROOT/free/engineer.md" > "$DEST/system/staffs/build/engineer.md"
cp "$ROOT/free/write-plan/SKILL.md" "$DEST/system/skills/free/write-plan/SKILL.md"
printf '%s\n' "# Plans" > "$DEST/cache/plans/README.md"
echo "company: $DEST"
echo "start at: $DEST/system/staffs/leadership/ceo.md"
