#!/bin/bash
# protect-files.sh
# PreToolUse hook — blocks writes to protected files
# Exit 2 = block the action | Exit 0 = allow

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path','') or d.get('tool_input',{}).get('path',''))" 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Files and patterns that should never be modified by Claude
PROTECTED_PATTERNS=(
  "\.env$"
  "\.env\.local$"
  "\.env\.production$"
  "\.env\.staging$"
  "package-lock\.json$"
  "yarn\.lock$"
  "poetry\.lock$"
  "Pipfile\.lock$"
  "\.git/"
  "\.gitconfig$"
  "id_rsa"
  "id_ed25519"
  "\.pem$"
  "\.key$"
  "secrets\."
  "credentials\."
)

for pattern in "${PROTECTED_PATTERNS[@]}"; do
  if echo "$FILE_PATH" | grep -qE "$pattern"; then
    echo "🛡️  BLOCKED: Claude attempted to write to protected file: $FILE_PATH" >&2
    echo "   Pattern matched: $pattern" >&2
    echo "   If this is intentional, make the change manually." >&2
    exit 2
  fi
done

exit 0
