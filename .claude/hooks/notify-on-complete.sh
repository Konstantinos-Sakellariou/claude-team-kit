#!/bin/bash
# notify-on-complete.sh
# Stop hook — sends a macOS notification when Claude finishes a long task
# Only fires if the session has been running for more than 30 seconds

START_TIME="${CLAUDE_SESSION_START:-0}"
NOW=$(date +%s)
ELAPSED=$((NOW - START_TIME))

# Only notify for tasks that took longer than 30 seconds
if [ "$ELAPSED" -lt 30 ]; then
  exit 0
fi

# macOS notification (works on macOS)
if command -v osascript &>/dev/null; then
  osascript -e 'display notification "Claude has finished your task." with title "Claude Code ✓" sound name "Glass"' 2>/dev/null
fi

# Terminal bell (universal fallback)
echo -e "\a"

exit 0
