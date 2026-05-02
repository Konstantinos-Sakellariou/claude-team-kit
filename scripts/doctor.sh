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

# Core files
check_file "README.md" "README.md exists"
check_file "CLAUDE.md" "CLAUDE.md exists"
check_file "AGENTS.md" "AGENTS.md exists"
check_file "BACKLOG.example.md" "BACKLOG.example.md exists"
check_file "docs/BACKLOG.example.md" "docs/BACKLOG.example.md exists"

# Core docs
check_file "docs/ARCHITECTURE.md" "docs/ARCHITECTURE.md exists"
check_file "docs/DOCUMENTATION_GOVERNANCE.md" "docs/DOCUMENTATION_GOVERNANCE.md exists"
check_file "docs/ROADMAP.example.md" "docs/ROADMAP.example.md exists"
check_file "docs/VISION.example.md" "docs/VISION.example.md exists"
check_file "docs/BOOTSTRAP.md" "docs/BOOTSTRAP.md exists"
check_file "docs/CONTEXT_EFFICIENCY.md" "docs/CONTEXT_EFFICIENCY.md exists"
check_file "docs/DURABLE_MEMORY.md" "docs/DURABLE_MEMORY.md exists"
check_file "docs/LOCAL_CONTEXT.md" "docs/LOCAL_CONTEXT.md exists"
check_file "docs/PROJECT_CUSTOMIZATION.md" "docs/PROJECT_CUSTOMIZATION.md exists"
check_file "docs/RTK_INTEGRATION.md" "docs/RTK_INTEGRATION.md exists"
check_file "docs/ARTIFACTS.md" "docs/ARTIFACTS.md exists"
check_file "docs/RESEARCH_AND_DISCOVERY.md" "docs/RESEARCH_AND_DISCOVERY.md exists"
check_file "docs/FEEDBACK_AND_LEARNING.md" "docs/FEEDBACK_AND_LEARNING.md exists"
check_file "docs/adr/README.md" "docs/adr/README.md exists"
check_file "docs/assets/claude-team-kit-hero.svg" "docs/assets/claude-team-kit-hero.svg exists"

# Config and environment
check_file ".claude/settings.json" ".claude/settings.json exists"
check_file ".mcp.json" ".mcp.json exists"
check_file ".env.example" ".env.example exists"

# Starter rules (5)
check_file ".claude/rules/code-quality.md" ".claude/rules/code-quality.md exists"
check_file ".claude/rules/documentation-governance.md" ".claude/rules/documentation-governance.md exists"
check_file ".claude/rules/context-efficiency.md" ".claude/rules/context-efficiency.md exists"
check_file ".claude/rules/security.md" ".claude/rules/security.md exists"
check_file ".claude/rules/git-workflow.md" ".claude/rules/git-workflow.md exists"

# Starter hooks (3)
check_file ".claude/hooks/warn-doc-drift.sh" ".claude/hooks/warn-doc-drift.sh exists"
check_file ".claude/hooks/block-secrets.sh" ".claude/hooks/block-secrets.sh exists"
check_file ".claude/hooks/auto-format.sh" ".claude/hooks/auto-format.sh exists"

# Starter commands (6)
if [ -d "$ROOT_DIR/.claude/commands" ]; then
  pass ".claude/commands exists"
else
  fail ".claude/commands directory is missing"
fi

for command in bootstrap-repo customize-repo plan-idea save-backlog write-adr triage-input; do
  if [ -f "$ROOT_DIR/.claude/commands/${command}.md" ]; then
    pass "${command} command exists"
  else
    fail "${command} command is missing"
  fi
done

# Starter teams (2)
if [ -d "$ROOT_DIR/.claude/teams" ]; then
  pass ".claude/teams exists"
else
  fail ".claude/teams directory is missing"
fi

for team in engineering-team product-team; do
  if [ -f "$ROOT_DIR/.claude/teams/${team}.md" ]; then
    pass "${team} manifest exists"
  else
    fail "${team} manifest is missing"
  fi
done

# settings.json checks
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

if grep -q 'warn-doc-drift.sh' "$ROOT_DIR/.claude/settings.json"; then
  pass ".claude/settings.json registers the doc-drift warning hook"
else
  fail ".claude/settings.json does not register the doc-drift warning hook"
fi

if python3 -m json.tool "$ROOT_DIR/.claude/settings.json" >/dev/null 2>&1; then
  pass "settings.json is valid JSON"
else
  fail "settings.json is not valid JSON"
fi

if python3 -m json.tool "$ROOT_DIR/.claude/settings.local.json.example" >/dev/null 2>&1; then
  pass "settings.local.json.example is valid JSON"
else
  fail "settings.local.json.example is not valid JSON"
fi

if python3 -m json.tool "$ROOT_DIR/.mcp.json" >/dev/null 2>&1; then
  pass ".mcp.json is valid JSON"
else
  fail ".mcp.json is not valid JSON"
fi

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

if [ -f "$ROOT_DIR/BACKLOG.md" ]; then
  pass "BACKLOG.md exists locally"
else
  warn "BACKLOG.md has not been created locally yet"
fi

# CLAUDE.md / AGENTS.md rule references
if grep -q "@.claude/rules/" "$ROOT_DIR/CLAUDE.md"; then
  pass "CLAUDE.md references .claude rules"
else
  fail "CLAUDE.md rule references are missing"
fi

if grep -q "@.Codex/rules/" "$ROOT_DIR/AGENTS.md"; then
  fail "AGENTS.md still references @.Codex paths"
elif grep -q "@.claude/rules/" "$ROOT_DIR/AGENTS.md"; then
  pass "AGENTS.md references .claude rules"
else
  warn "AGENTS.md rule references could not be verified"
fi

# Hook executability
if [ -d "$ROOT_DIR/.claude/hooks" ]; then
  non_exec_hooks=$(find "$ROOT_DIR/.claude/hooks" -maxdepth 1 -type f ! -perm -111 | wc -l | tr -d ' ')
  if [ "$non_exec_hooks" = "0" ]; then
    pass "All hook scripts are executable"
  else
    fail "Some hook scripts are not executable"
  fi
fi

# master.md content checks
if grep -q 'Every request enters through you\.' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt states that every request enters through master"
else
  fail "master agent prompt is missing the mandatory entrypoint rule"
fi

if grep -q '## New Repo Bootstrap' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'Do not trigger bootstrap when:' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'Bootstrap question areas:' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q '### Guided Initialization Mode' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines the new-repo bootstrap flow and guided initialization mode"
else
  fail "master agent prompt is missing the new-repo bootstrap flow or guided initialization mode"
fi

if grep -q '## Context Efficiency And Scope Discipline' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'read narrow first' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'prefer local CLI tools over equivalent MCP tools' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines context-efficiency and scope-discipline rules"
else
  fail "master agent prompt is missing context-efficiency and scope-discipline rules"
fi

if grep -q '## Model Routing Policy' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q '`Haiku`' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q '`Sonnet`' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q '`Opus`' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q '## Model Routing' "$ROOT_DIR/docs/CONTEXT_EFFICIENCY.md"; then
  pass "model-routing guidance is aligned across master and context docs"
else
  fail "model-routing guidance is not aligned across master and context docs"
fi

if grep -q '## Execution Report' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines a default execution report"
else
  fail "master agent prompt is missing a default execution report"
fi

if grep -q '## Private Local Context' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q '.claude/local-context/' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'never copy private local-context details into tracked files automatically' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines the private local-context boundary"
else
  fail "master agent prompt is missing the private local-context boundary"
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

if grep -q 'ADR-worthy decision / durable trade-off' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'treat it as ADR-candidate work by default' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines default ADR routing for durable decisions"
else
  fail "master agent prompt is missing default ADR routing for durable decisions"
fi

# workspace-updater
if grep -q 'CLAUDE.md, AGENTS.md, and README.md' "$ROOT_DIR/.claude/agents/workspace-updater.md"; then
  pass "workspace-updater prompt covers all core documentation files"
else
  fail "workspace-updater prompt does not cover all core documentation files"
fi

if grep -q '## Special Case: Private Local Context Boundary' "$ROOT_DIR/.claude/agents/workspace-updater.md"; then
  pass "workspace-updater respects the private local-context boundary"
else
  fail "workspace-updater is missing the private local-context boundary"
fi

# ADR guidance
if grep -q 'docs/adr/001-decision-name.md' "$ROOT_DIR/docs/adr/README.md" && \
   grep -q 'docs/adr/001-decision-name.md' "$ROOT_DIR/.claude/agents/tech-writer.md"; then
  pass "Tracked ADR docs agree on the canonical filename format"
else
  fail "Tracked ADR docs are not aligned on the canonical filename format"
fi

if grep -q 'Required ADR sections' "$ROOT_DIR/docs/adr/README.md" && \
   grep -q 'Always include:' "$ROOT_DIR/.claude/agents/tech-writer.md"; then
  pass "Tracked ADR guidance defines required sections consistently"
else
  fail "Tracked ADR guidance is missing the required section contract"
fi

# README content checks
if grep -q 'Every request goes through `@master`. Always\.' "$ROOT_DIR/README.md"; then
  pass "README.md states that master is always the entrypoint"
else
  fail "README.md does not clearly require master as the entrypoint"
fi

if grep -q 'By default, `@master` also reports which teams and agents were selected' "$ROOT_DIR/README.md"; then
  pass "README.md documents default orchestration reporting"
else
  fail "README.md does not document default orchestration reporting"
fi

if grep -q '## What Teams Mean' "$ROOT_DIR/README.md" && \
   grep -q '## Available Teams' "$ROOT_DIR/README.md"; then
  pass "README.md documents the reusable team system"
else
  fail "README.md does not document the reusable team system"
fi

if grep -q 'propose an ADR by default' "$ROOT_DIR/README.md"; then
  pass "README.md documents default ADR handling"
else
  fail "README.md does not document default ADR handling"
fi

if grep -q "## Context Efficiency" "$ROOT_DIR/README.md" && \
   grep -q "explicit model-routing stance" "$ROOT_DIR/README.md"; then
  pass "README.md documents context-efficiency and model-routing guidance"
else
  fail "README.md is missing context-efficiency or model-routing guidance"
fi

# Core docs alignment check (Starter scope)
if grep -q "docs/VISION.example.md" "$ROOT_DIR/README.md" && \
   grep -q "docs/VISION.example.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "docs/VISION.example.md" "$ROOT_DIR/AGENTS.md" && \
   grep -q "docs/ROADMAP.example.md" "$ROOT_DIR/README.md" && \
   grep -q "docs/ROADMAP.example.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "docs/ROADMAP.example.md" "$ROOT_DIR/AGENTS.md" && \
   grep -q "@.claude/rules/documentation-governance.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "@.claude/rules/documentation-governance.md" "$ROOT_DIR/AGENTS.md" && \
   grep -q "@.claude/rules/context-efficiency.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "@.claude/rules/context-efficiency.md" "$ROOT_DIR/AGENTS.md"; then
  pass "README.md, CLAUDE.md, and AGENTS.md reference the vision/roadmap templates and governance rules"
else
  fail "README.md, CLAUDE.md, or AGENTS.md are missing vision/roadmap template links or governance rule references"
fi

# Bootstrap alignment
if grep -q '## New Repo Bootstrap' "$ROOT_DIR/README.md" && \
   grep -q 'docs/BOOTSTRAP.md' "$ROOT_DIR/README.md" && \
   grep -q 'Bootstrap should stay flexible:' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'Bootstrap should stay flexible:' "$ROOT_DIR/AGENTS.md"; then
  pass "README.md, CLAUDE.md, and AGENTS.md document the bootstrap flow"
else
  fail "Core docs are not aligned on the bootstrap flow"
fi

# Private local context alignment
if grep -q '## Private Local Context' "$ROOT_DIR/README.md" && \
   grep -q 'docs/LOCAL_CONTEXT.md' "$ROOT_DIR/README.md" && \
   grep -q 'private local context layer' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'private local context layer' "$ROOT_DIR/AGENTS.md"; then
  pass "README.md, CLAUDE.md, and AGENTS.md document the private local-context layer"
else
  fail "Core docs are not aligned on the private local-context layer"
fi

# Context efficiency alignment
if grep -q '## Context Efficiency' "$ROOT_DIR/README.md" && \
   grep -q 'docs/CONTEXT_EFFICIENCY.md' "$ROOT_DIR/README.md" && \
   grep -q 'docs/CONTEXT_EFFICIENCY.md' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'docs/CONTEXT_EFFICIENCY.md' "$ROOT_DIR/AGENTS.md"; then
  pass "README.md, CLAUDE.md, and AGENTS.md document context-efficiency guidance"
else
  fail "Core docs are not aligned on context-efficiency guidance"
fi

# Request shaping
if grep -q '## How To Ask Well' "$ROOT_DIR/README.md" && \
   grep -q 'exact file paths' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'exact file paths' "$ROOT_DIR/AGENTS.md"; then
  pass "README.md, CLAUDE.md, and AGENTS.md document request-shaping guidance"
else
  fail "Core docs are not aligned on request-shaping guidance"
fi

# Team abstraction
if grep -q 'Teams are reusable orchestration bundles' "$ROOT_DIR/CLAUDE.md" && \
   grep -q '## Available Teams' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'Teams are reusable orchestration bundles' "$ROOT_DIR/AGENTS.md" && \
   grep -q '## Available Teams' "$ROOT_DIR/AGENTS.md"; then
  pass "CLAUDE.md and AGENTS.md document the team abstraction"
else
  fail "CLAUDE.md and AGENTS.md are not aligned on the team abstraction"
fi

# Bootstrap docs
if grep -q 'Guided initialization should:' "$ROOT_DIR/docs/BOOTSTRAP.md" && \
   grep -q '## Suggested Rounds' "$ROOT_DIR/docs/BOOTSTRAP.md" && \
   grep -q 'guided initialization' "$ROOT_DIR/README.md"; then
  pass "bootstrap docs define guided initialization behavior"
else
  fail "bootstrap docs are missing guided initialization behavior"
fi

# .gitignore
if grep -q '^\.claude/local-context/$' "$ROOT_DIR/.gitignore"; then
  pass ".gitignore protects the private local-context folder"
else
  fail ".gitignore does not protect the private local-context folder"
fi

# README structural checks
if python3 - "$ROOT_DIR/README.md" "$ROOT_DIR" <<'PY' >/dev/null 2>&1
import re
import sys
from pathlib import Path

readme = Path(sys.argv[1])
root = Path(sys.argv[2])
text = readme.read_text()

if text.count("```") % 2:
    sys.exit(1)

link_pattern = re.compile(r'!?\[[^\]]*\]\(([^)]+)\)')
for raw_target in link_pattern.findall(text):
    target = raw_target.strip()
    if (
        not target
        or target.startswith("#")
        or "://" in target
        or target.startswith("mailto:")
        or target.startswith("tel:")
    ):
        continue
    path_part = target.split("#", 1)[0]
    if not path_part:
        continue
    if not (root / path_part).exists():
        sys.exit(1)

for block in re.findall(r'```mermaid\n(.*?)\n```', text, flags=re.S):
    if not block.strip().startswith(("flowchart ", "sequenceDiagram", "gantt")):
        sys.exit(1)
    try:
        block.encode("ascii")
    except UnicodeEncodeError:
        sys.exit(1)

sys.exit(0)
PY
then
  pass "README.md local links, code fences, and Mermaid blocks are structurally valid"
else
  fail "README.md has broken local links, unbalanced code fences, or risky Mermaid blocks"
fi

if grep -q 'github/actions/workflow/status/Konstantinos-Sakellariou/claude-team-kit/validate.yml' "$ROOT_DIR/README.md"; then
  pass "README.md includes the validation badge"
else
  fail "README.md is missing the validation badge"
fi

# CLAUDE.md / AGENTS.md size check
claude_lines=$(wc -l < "$ROOT_DIR/CLAUDE.md" | tr -d ' ')
agents_lines=$(wc -l < "$ROOT_DIR/AGENTS.md" | tr -d ' ')
if [ "$claude_lines" -le 260 ]; then
  pass "CLAUDE.md stays within the context-efficiency warning threshold"
else
  warn "CLAUDE.md is getting large for an always-loaded briefing file ($claude_lines lines)"
fi

if [ "$agents_lines" -le 260 ]; then
  pass "AGENTS.md stays within the context-efficiency warning threshold"
else
  warn "AGENTS.md is getting large for an always-loaded briefing file ($agents_lines lines)"
fi

# Agent / team / skill counts
agent_count=$(find "$ROOT_DIR/.claude/agents" -maxdepth 1 -type f | wc -l | tr -d ' ')
team_count=$(find "$ROOT_DIR/.claude/teams" -maxdepth 1 -type f 2>/dev/null | wc -l | tr -d ' ')
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

if grep -q "${team_count} reusable team manifests" "$ROOT_DIR/README.md"; then
  pass "README.md team count matches the repo"
else
  fail "README.md team count does not match the repo"
fi

printf 'INFO: agents=%s teams=%s skills=%s rules=%s hooks=%s\n' "$agent_count" "$team_count" "$skill_count" "$rule_count" "$hook_count"

if [ "$ERRORS" -gt 0 ]; then
  printf 'Doctor finished with %s error(s) and %s warning(s).\n' "$ERRORS" "$WARNINGS"
  exit 1
fi

printf 'Doctor finished with %s warning(s).\n' "$WARNINGS"
exit 0
