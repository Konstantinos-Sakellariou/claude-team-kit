#!/bin/bash
# block-secrets.sh
# PreToolUse hook — scans file content Claude is about to write for hardcoded secrets
# Blocks the write if secrets are detected
# Exit 2 = block | Exit 0 = allow

INPUT=$(cat)

# Extract the content being written
CONTENT=$(echo "$INPUT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
inp = d.get('tool_input', {})
# Handle both Write (content) and Edit (new_string) tools
print(inp.get('content', '') or inp.get('new_string', ''))
" 2>/dev/null)

if [ -z "$CONTENT" ]; then
  exit 0
fi

FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(d.get('tool_input', {}).get('file_path', ''))
" 2>/dev/null)

# Skip test files (they often have fake credentials intentionally)
if echo "$FILE_PATH" | grep -qE "(test_|_test\.|\.test\.|spec\.|fixture|mock|fake)"; then
  exit 0
fi

# Skip example/template files
if echo "$FILE_PATH" | grep -qE "(\.example$|\.template$|example\.|template\.)"; then
  exit 0
fi

DETECTED_SECRETS=()

# AWS keys
if echo "$CONTENT" | grep -qE "AKIA[0-9A-Z]{16}"; then
  DETECTED_SECRETS+=("AWS Access Key ID")
fi

# Generic high-entropy patterns with secret-sounding variable names
if echo "$CONTENT" | grep -qiE "(password|passwd|pwd|secret|api_key|apikey|access_token|auth_token|private_key)\s*[=:]\s*['\"][^'\"]{8,}['\"]"; then
  DETECTED_SECRETS+=("Hardcoded credential (password/secret/api_key)")
fi

# JWT tokens
if echo "$CONTENT" | grep -qE "eyJ[a-zA-Z0-9_-]+\.eyJ[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+"; then
  DETECTED_SECRETS+=("JWT Token")
fi

# GitHub tokens
if echo "$CONTENT" | grep -qE "gh[pousr]_[A-Za-z0-9_]{36,}"; then
  DETECTED_SECRETS+=("GitHub Token")
fi

# Stripe keys
if echo "$CONTENT" | grep -qE "sk_live_[0-9a-zA-Z]{24}"; then
  DETECTED_SECRETS+=("Stripe Live Secret Key")
fi

# Private keys
if echo "$CONTENT" | grep -q "BEGIN.*PRIVATE KEY"; then
  DETECTED_SECRETS+=("Private Key Block")
fi

if [ ${#DETECTED_SECRETS[@]} -gt 0 ]; then
  echo "🚨 SECRET DETECTED — Write blocked!" >&2
  echo "   File: $FILE_PATH" >&2
  echo "   Detected: ${DETECTED_SECRETS[*]}" >&2
  echo "" >&2
  echo "   Use environment variables instead:" >&2
  echo "   Python: os.environ.get('MY_SECRET')" >&2
  echo "   Node:   process.env.MY_SECRET" >&2
  echo "" >&2
  echo "   Add real secrets to .env (gitignored) or your secrets manager." >&2
  exit 2
fi

exit 0
