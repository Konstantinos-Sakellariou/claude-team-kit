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

LOCAL_CONTEXT_DIR="$ROOT_DIR/.claude/local-context"
if [ ! -d "$LOCAL_CONTEXT_DIR" ]; then
  mkdir -p "$LOCAL_CONTEXT_DIR"
  cat > "$LOCAL_CONTEXT_DIR/README.md" <<'EOF'
# Private Local Context

This folder is for local-only context that helps agents work better without putting sensitive material into tracked docs.

Good examples:
- private business or startup context
- customer or stakeholder notes
- unreleased roadmap details
- pricing, fundraising, or GTM notes
- internal constraints, risks, or organizational sensitivities

Do not commit this folder.
EOF
  cat > "$LOCAL_CONTEXT_DIR/project-private.md" <<'EOF'
# Project Private Context

## What This Project Is Really Trying To Achieve

## Important Business Context

## Sensitive Strategic Notes

## Private Success Criteria
EOF
  cat > "$LOCAL_CONTEXT_DIR/customers.md" <<'EOF'
# Customers And Stakeholders

## Primary Users

## Key Stakeholders

## Sensitive Customer Notes
EOF
  cat > "$LOCAL_CONTEXT_DIR/constraints.md" <<'EOF'
# Constraints

## Technical Constraints

## Commercial Constraints

## Legal Or Compliance Constraints

## Timing Or Organizational Constraints
EOF
  cat > "$LOCAL_CONTEXT_DIR/ACTIVITY.md" <<'EOF'
# Activity Log

Optional local-only trace of significant orchestration sessions.

Use compact entries:

## YYYY-MM-DD - Short Session Title

- Request:
- Primary team:
- Agents:
- Artifacts touched:
- Validation:
- Decisions:
- Next action:

Do not paste transcripts, secrets, or detailed private customer notes here.
EOF
  echo "OK: Created .claude/local-context/ starter files"
else
  echo "OK: Private local context already present"
fi

ACTIVITY_FILE="$LOCAL_CONTEXT_DIR/ACTIVITY.md"
if [ -d "$LOCAL_CONTEXT_DIR" ] && [ ! -f "$ACTIVITY_FILE" ]; then
  cat > "$ACTIVITY_FILE" <<'EOF'
# Activity Log

Optional local-only trace of significant orchestration sessions.

Use compact entries:

## YYYY-MM-DD - Short Session Title

- Request:
- Primary team:
- Agents:
- Artifacts touched:
- Validation:
- Decisions:
- Next action:

Do not paste transcripts, secrets, or detailed private customer notes here.
EOF
  echo "OK: Created .claude/local-context/ACTIVITY.md"
fi

echo
echo "Next steps:"
echo "1. Edit .claude/settings.local.json and/or .env with your GitHub token"
echo "2. Review CLAUDE.md before using this repo as a template in another project"
echo "3. Use BACKLOG.md locally for private planning details, or create docs/BACKLOG.md from docs/BACKLOG.example.md for a tracked public backlog"
echo "4. Add any sensitive startup, customer, or strategy notes to .claude/local-context/ and keep that folder local-only"
echo "5. Optionally use .claude/local-context/ACTIVITY.md as a compact local-only session trace"
echo "6. Run ./scripts/doctor.sh to validate the workspace"
