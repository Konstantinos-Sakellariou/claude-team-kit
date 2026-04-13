#!/bin/bash
# warn-doc-drift.sh
# PostToolUse hook — warns when core docs may be drifting after governance-sensitive edits
# Never blocks; exit 0 always

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path','') or d.get('tool_input',{}).get('path',''))" 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

ROOT="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null)}"
if [ -z "$ROOT" ] || [ ! -d "$ROOT/.git" ]; then
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
CORE_DOCS_REGEX='^(README\.md|CLAUDE\.md|AGENTS\.md)$'
GOVERNANCE_REGEX='^(\.claude/agents/master\.md|\.claude/agents/workspace-updater\.md|\.claude/rules/[^/]+\.md|\.claude/teams/[^/]+\.md|\.claude/settings\.json|docs/BOOTSTRAP\.md|docs/ARCHITECTURE\.md|docs/PROJECT_CUSTOMIZATION\.md|docs/AGENT_WORKFLOWS\.md)$'

if ! echo "$REL_PATH" | grep -qE "$CORE_DOCS_REGEX|$GOVERNANCE_REGEX"; then
  exit 0
fi

CHANGED_CORE_DOCS=$(git -C "$ROOT" diff --name-only -- README.md CLAUDE.md AGENTS.md 2>/dev/null | sort -u)
CHANGED_CORE_COUNT=$(printf '%s\n' "$CHANGED_CORE_DOCS" | sed '/^$/d' | wc -l | tr -d ' ')

if echo "$REL_PATH" | grep -qE "$CORE_DOCS_REGEX"; then
  if [ "$CHANGED_CORE_COUNT" -le 1 ]; then
    echo "⚠️  DOC DRIFT CHECK — You changed $REL_PATH." >&2
    echo "   Review README.md, CLAUDE.md, and AGENTS.md together if repo facts or workflow behavior changed." >&2
  fi
  exit 0
fi

if echo "$REL_PATH" | grep -qE "$GOVERNANCE_REGEX"; then
  if [ "$CHANGED_CORE_COUNT" -eq 0 ]; then
    echo "⚠️  DOC DRIFT CHECK — You changed $REL_PATH." >&2
    echo "   This file can affect the core briefings. Review README.md, CLAUDE.md, and AGENTS.md for alignment." >&2
  fi
fi

exit 0
