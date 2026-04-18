#!/bin/bash
# warn-tracked-artifact.sh
# PostToolUse hook — warns when writing to tracked planning/decision artifacts
# Never blocks; exit 0 always

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path','') or d.get('tool_input',{}).get('path',''))" 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

ROOT="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null)}"
if [ -z "$ROOT" ]; then
  exit 0
fi

normalize_path() {
  local path="$1"
  case "$path" in
    "$ROOT"/*) printf '%s\n' "${path#"$ROOT"/}" ;;
    *) printf '%s\n' "$path" ;;
  esac
}

REL_PATH="$(normalize_path "$FILE_PATH")"

case "$REL_PATH" in
  docs/BACKLOG.md)
    ;;
  docs/plans/*.md)
    [ "$REL_PATH" = "docs/plans/example-execution-plan.md" ] && exit 0
    ;;
  docs/adr/*.md)
    [ "$REL_PATH" = "docs/adr/README.md" ] && exit 0
    ;;
  *)
    exit 0
    ;;
esac

echo "⚠️  TRACKED ARTIFACT CHECK — You changed $REL_PATH." >&2
echo "   This surface is tracked in git history." >&2
echo "   Confirm tracked visibility is intentional; otherwise prefer BACKLOG.md, .claude/local-context/plans/, or .claude/local-context/HANDOFF.md." >&2
exit 0
