#!/bin/bash
# auto-format.sh
# PostToolUse hook — auto-formats files after Claude writes/edits them
# Runs silently; format failures are warnings, not blockers

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path','') or d.get('tool_input',{}).get('path',''))" 2>/dev/null)

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

EXT="${FILE_PATH##*.}"

case "$EXT" in
  py)
    # Python: try black, then autopep8 as fallback
    if command -v black &>/dev/null; then
      black --quiet "$FILE_PATH" 2>/dev/null
    elif command -v autopep8 &>/dev/null; then
      autopep8 --in-place "$FILE_PATH" 2>/dev/null
    fi
    # Also run isort if available
    if command -v isort &>/dev/null; then
      isort --quiet "$FILE_PATH" 2>/dev/null
    fi
    ;;
  ts|tsx|js|jsx|mjs|cjs)
    # TypeScript/JavaScript: try prettier
    if command -v prettier &>/dev/null; then
      prettier --write --log-level=silent "$FILE_PATH" 2>/dev/null
    elif command -v npx &>/dev/null; then
      npx --yes prettier --write --log-level=silent "$FILE_PATH" 2>/dev/null
    fi
    ;;
  json)
    # JSON: pretty-print with python (always available)
    if python3 -c "import json; json.load(open('$FILE_PATH'))" 2>/dev/null; then
      python3 -c "
import json
with open('$FILE_PATH', 'r') as f:
    data = json.load(f)
with open('$FILE_PATH', 'w') as f:
    json.dump(data, f, indent=2)
    f.write('\n')
" 2>/dev/null
    fi
    ;;
  md|mdx)
    # Markdown: prettier if available
    if command -v prettier &>/dev/null; then
      prettier --write --log-level=silent --prose-wrap=always "$FILE_PATH" 2>/dev/null
    fi
    ;;
  yaml|yml)
    # YAML: prettier if available
    if command -v prettier &>/dev/null; then
      prettier --write --log-level=silent "$FILE_PATH" 2>/dev/null
    fi
    ;;
esac

# Always exit 0 — formatting failures should not block Claude
exit 0
