#!/bin/bash
# validate-sql-query.sh
# PreToolUse hook — checks Bash commands for dangerous SQL patterns
# Specifically looks for raw string-concatenated SQL that could be injection vectors
# Exit 2 = block | Exit 0 = allow

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(d.get('tool_input', {}).get('command', ''))
" 2>/dev/null)

if [ -z "$COMMAND" ]; then
  exit 0
fi

DANGEROUS=()

# Detect raw SQL execution with potential string interpolation
if echo "$COMMAND" | grep -qE "psql.*-c.*['\"].*\+.*['\"]"; then
  DANGEROUS+=("Potentially concatenated SQL query in psql")
fi

if echo "$COMMAND" | grep -qE "mysql.*-e.*['\"].*\+.*['\"]"; then
  DANGEROUS+=("Potentially concatenated SQL query in mysql")
fi

# Detect DROP TABLE / TRUNCATE without explicit confirmation context
if echo "$COMMAND" | grep -qiE "\bDROP TABLE\b|\bTRUNCATE TABLE\b|\bDELETE FROM\b.*\bWHERE\b.*="; then
  DANGEROUS+=("Destructive SQL operation detected")
fi

if [ ${#DANGEROUS[@]} -gt 0 ]; then
  echo "⚠️  SQL SAFETY CHECK — Review required" >&2
  echo "   Concerns: ${DANGEROUS[*]}" >&2
  echo "   Command: $COMMAND" >&2
  echo "" >&2
  echo "   Please confirm this is safe before proceeding." >&2
  exit 2
fi

exit 0
