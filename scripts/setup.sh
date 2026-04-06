#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> claude-team-kit setup"
echo "Root: $ROOT_DIR"

if [ ! -d "$ROOT_DIR/.claude" ]; then
  echo "ERROR: .claude/ directory not found. Run this from a claude-team-kit checkout." >&2
  exit 1
fi

if [ -d "$ROOT_DIR/.claude/hooks" ]; then
  chmod +x "$ROOT_DIR"/.claude/hooks/*.sh
  echo "OK: Hook scripts are executable"
fi

LOCAL_SETTINGS="$ROOT_DIR/.claude/settings.local.json"
LOCAL_SETTINGS_EXAMPLE="$ROOT_DIR/.claude/settings.local.json.example"
if [ ! -f "$LOCAL_SETTINGS" ] && [ -f "$LOCAL_SETTINGS_EXAMPLE" ]; then
  cp "$LOCAL_SETTINGS_EXAMPLE" "$LOCAL_SETTINGS"
  echo "OK: Created .claude/settings.local.json from example"
else
  echo "OK: Local settings already present or no example file needed"
fi

ENV_FILE="$ROOT_DIR/.env"
ENV_EXAMPLE="$ROOT_DIR/.env.example"
if [ ! -f "$ENV_FILE" ] && [ -f "$ENV_EXAMPLE" ]; then
  cp "$ENV_EXAMPLE" "$ENV_FILE"
  echo "OK: Created .env from .env.example"
else
  echo "OK: .env already present or no example file needed"
fi

BACKLOG_FILE="$ROOT_DIR/BACKLOG.md"
BACKLOG_EXAMPLE="$ROOT_DIR/BACKLOG.example.md"
if [ ! -f "$BACKLOG_FILE" ] && [ -f "$BACKLOG_EXAMPLE" ]; then
  cp "$BACKLOG_EXAMPLE" "$BACKLOG_FILE"
  echo "OK: Created local BACKLOG.md from BACKLOG.example.md"
else
  echo "OK: Local backlog already present or no example file needed"
fi

echo
echo "Next steps:"
echo "1. Edit .claude/settings.local.json and/or .env with your GitHub token"
echo "2. Review CLAUDE.md before using this repo as a template in another project"
echo "3. Use BACKLOG.md locally; it is ignored and safe for private planning details"
echo "4. Run ./scripts/doctor.sh to validate the workspace"
