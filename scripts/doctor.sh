#!/bin/bash

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ERRORS=0
WARNINGS=0

pass() {
  printf 'PASS: %s\n' "$1"
}

warn() {
  printf 'WARN: %s\n' "$1"
  WARNINGS=$((WARNINGS + 1))
}

fail() {
  printf 'FAIL: %s\n' "$1"
  ERRORS=$((ERRORS + 1))
}

check_file() {
  local path="$1"
  local label="$2"
  if [ -f "$ROOT_DIR/$path" ]; then
    pass "$label"
  else
    fail "$label"
  fi
}

echo "==> claude-team-kit doctor"
echo "Root: $ROOT_DIR"

check_file "README.md" "README.md exists"
check_file "CLAUDE.md" "CLAUDE.md exists"
check_file "AGENTS.md" "AGENTS.md exists"
check_file "docs/ARCHITECTURE.md" "docs/ARCHITECTURE.md exists"
check_file "docs/AGENT_WORKFLOWS.md" "docs/AGENT_WORKFLOWS.md exists"
check_file "docs/PROJECT_CUSTOMIZATION.md" "docs/PROJECT_CUSTOMIZATION.md exists"
check_file ".claude/settings.json" ".claude/settings.json exists"
check_file ".mcp.json" ".mcp.json exists"
check_file ".env.example" ".env.example exists"

if python3 - "$ROOT_DIR/.claude/settings.json" <<'PY' >/dev/null 2>&1
import json
import sys
with open(sys.argv[1]) as f:
    data = json.load(f)
sys.exit(0 if data.get("agent") == "master" else 1)
PY
then
  pass ".claude/settings.json sets master as the default agent"
else
  fail ".claude/settings.json does not set master as the default agent"
fi

if grep -q "@.Codex/rules/" "$ROOT_DIR/AGENTS.md"; then
  fail "AGENTS.md still references @.Codex paths"
elif grep -q "@.claude/rules/" "$ROOT_DIR/AGENTS.md"; then
  pass "AGENTS.md references .claude rules"
else
  warn "AGENTS.md rule references could not be verified"
fi

if grep -q "@.claude/rules/" "$ROOT_DIR/CLAUDE.md"; then
  pass "CLAUDE.md references .claude rules"
else
  fail "CLAUDE.md rule references are missing"
fi

if grep -q 'Every request goes through `@master`. Always\.' "$ROOT_DIR/README.md"; then
  pass "README.md states that master is always the entrypoint"
else
  fail "README.md does not clearly require master as the entrypoint"
fi

if grep -q 'Every request enters through you\.' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt states that every request enters through master"
else
  fail "master agent prompt is missing the mandatory entrypoint rule"
fi

if grep -q 'This is automatic and does not wait for an extra user prompt' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt requires automatic final workspace updates"
else
  fail "master agent prompt is missing the automatic final update rule"
fi

if grep -q 'You must always tell the user which agents you selected' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt requires visible agent selection reporting"
else
  fail "master agent prompt is missing visible agent selection reporting"
fi

if grep -q '## Execution Report' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines a default execution report"
else
  fail "master agent prompt is missing a default execution report"
fi

if [ -f "$ROOT_DIR/.claude/agents/github-safety-guard.md" ]; then
  pass "github-safety-guard agent exists"
else
  fail "github-safety-guard agent is missing"
fi

if grep -q '@github-safety-guard' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt routes commit and push work through github-safety-guard"
else
  fail "master agent prompt does not route commit and push work through github-safety-guard"
fi

if grep -q 'CLAUDE.md, AGENTS.md, and README.md' "$ROOT_DIR/.claude/agents/workspace-updater.md"; then
  pass "workspace-updater prompt covers all core documentation files"
else
  fail "workspace-updater prompt does not cover all core documentation files"
fi

if grep -q 'By default, `@master` also reports which agents were selected' "$ROOT_DIR/README.md"; then
  pass "README.md documents default orchestration reporting"
else
  fail "README.md does not document default orchestration reporting"
fi

if grep -q "workspace kit" "$ROOT_DIR/README.md"; then
  pass "README.md describes the repo as a workspace kit"
else
  warn "README.md may not clearly describe the current product scope"
fi

if [ -d "$ROOT_DIR/.claude/hooks" ]; then
  non_exec_hooks=$(find "$ROOT_DIR/.claude/hooks" -maxdepth 1 -type f ! -perm -111 | wc -l | tr -d ' ')
  if [ "$non_exec_hooks" = "0" ]; then
    pass "All hook scripts are executable"
  else
    fail "Some hook scripts are not executable"
  fi
fi

for path in "$ROOT_DIR/.claude/settings.json" "$ROOT_DIR/.claude/settings.local.json.example" "$ROOT_DIR/.mcp.json"; do
  if python3 -m json.tool "$path" >/dev/null 2>&1; then
    pass "$(basename "$path") is valid JSON"
  else
    fail "$(basename "$path") is not valid JSON"
  fi
done

if [ -f "$ROOT_DIR/.claude/settings.local.json" ]; then
  pass ".claude/settings.local.json exists"
else
  warn ".claude/settings.local.json has not been created yet"
fi

if [ -f "$ROOT_DIR/.env" ]; then
  pass ".env exists"
else
  warn ".env has not been created yet"
fi

agent_count=$(find "$ROOT_DIR/.claude/agents" -maxdepth 1 -type f | wc -l | tr -d ' ')
skill_count=$(find "$ROOT_DIR/.claude/skills" -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d ' ')
rule_count=$(find "$ROOT_DIR/.claude/rules" -maxdepth 1 -type f | wc -l | tr -d ' ')
hook_count=$(find "$ROOT_DIR/.claude/hooks" -maxdepth 1 -type f | wc -l | tr -d ' ')

if grep -q "${agent_count} specialized agents" "$ROOT_DIR/README.md"; then
  pass "README.md agent count matches the repo"
else
  fail "README.md agent count does not match the repo"
fi

if grep -q "${skill_count} reusable skills" "$ROOT_DIR/README.md"; then
  pass "README.md skill count matches the repo"
else
  fail "README.md skill count does not match the repo"
fi

printf 'INFO: agents=%s skills=%s rules=%s hooks=%s\n' "$agent_count" "$skill_count" "$rule_count" "$hook_count"

if [ "$ERRORS" -gt 0 ]; then
  printf 'Doctor finished with %s error(s) and %s warning(s).\n' "$ERRORS" "$WARNINGS"
  exit 1
fi

printf 'Doctor finished with %s warning(s).\n' "$WARNINGS"
exit 0
