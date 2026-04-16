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
check_file "BACKLOG.example.md" "BACKLOG.example.md exists"
check_file "docs/BACKLOG.example.md" "docs/BACKLOG.example.md exists"
check_file "docs/ARCHITECTURE.md" "docs/ARCHITECTURE.md exists"
check_file "docs/DOCUMENTATION_GOVERNANCE.md" "docs/DOCUMENTATION_GOVERNANCE.md exists"
check_file "docs/ROADMAP.example.md" "docs/ROADMAP.example.md exists"
check_file "docs/SELF_UPGRADE.md" "docs/SELF_UPGRADE.md exists"
check_file "docs/SYSTEM_REFERENCE.md" "docs/SYSTEM_REFERENCE.md exists"
check_file "docs/VISION.example.md" "docs/VISION.example.md exists"
check_file "docs/BOOTSTRAP.md" "docs/BOOTSTRAP.md exists"
check_file "docs/CONTEXT_EFFICIENCY.md" "docs/CONTEXT_EFFICIENCY.md exists"
check_file "docs/LOCAL_CONTEXT.md" "docs/LOCAL_CONTEXT.md exists"
check_file "docs/TEAMS.md" "docs/TEAMS.md exists"
check_file "docs/AGENT_WORKFLOWS.md" "docs/AGENT_WORKFLOWS.md exists"
check_file "docs/PROJECT_CUSTOMIZATION.md" "docs/PROJECT_CUSTOMIZATION.md exists"
check_file "docs/plans/example-execution-plan.md" "docs/plans/example-execution-plan.md exists"
check_file "docs/adr/README.md" "docs/adr/README.md exists"
check_file ".claude/settings.json" ".claude/settings.json exists"
check_file ".mcp.json" ".mcp.json exists"
check_file ".env.example" ".env.example exists"
check_file ".claude/rules/documentation-governance.md" ".claude/rules/documentation-governance.md exists"
check_file ".claude/rules/repo-cleanup.md" ".claude/rules/repo-cleanup.md exists"
check_file ".claude/rules/artifact-governance.md" ".claude/rules/artifact-governance.md exists"
check_file ".claude/rules/context-efficiency.md" ".claude/rules/context-efficiency.md exists"
check_file ".claude/rules/github-quality-gate.md" ".claude/rules/github-quality-gate.md exists"
check_file ".claude/rules/release-governance.md" ".claude/rules/release-governance.md exists"
check_file ".claude/rules/ml-workflow.md" ".claude/rules/ml-workflow.md exists"
check_file ".claude/hooks/warn-doc-drift.sh" ".claude/hooks/warn-doc-drift.sh exists"

if [ -d "$ROOT_DIR/.claude/commands" ]; then
  pass ".claude/commands exists"
else
  fail ".claude/commands directory is missing"
fi

for command in bootstrap-repo save-backlog plan-idea write-adr release-check sync-docs triage-input context-audit; do
  if [ -f "$ROOT_DIR/.claude/commands/${command}.md" ]; then
    pass "${command} command exists"
  else
    fail "${command} command is missing"
  fi
done

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

if grep -q "docs/VISION.example.md" "$ROOT_DIR/README.md" && \
   grep -q "docs/VISION.example.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "docs/VISION.example.md" "$ROOT_DIR/AGENTS.md" && \
   grep -q "docs/ROADMAP.example.md" "$ROOT_DIR/README.md" && \
   grep -q "docs/ROADMAP.example.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "docs/ROADMAP.example.md" "$ROOT_DIR/AGENTS.md" && \
   grep -q "docs/SELF_UPGRADE.md" "$ROOT_DIR/README.md" && \
   grep -q "docs/SELF_UPGRADE.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "docs/SELF_UPGRADE.md" "$ROOT_DIR/AGENTS.md" && \
   grep -q "@.claude/rules/documentation-governance.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "@.claude/rules/documentation-governance.md" "$ROOT_DIR/AGENTS.md" && \
   grep -q "@.claude/rules/repo-cleanup.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "@.claude/rules/repo-cleanup.md" "$ROOT_DIR/AGENTS.md" && \
   grep -q "@.claude/rules/artifact-governance.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "@.claude/rules/artifact-governance.md" "$ROOT_DIR/AGENTS.md" && \
   grep -q "@.claude/rules/context-efficiency.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "@.claude/rules/context-efficiency.md" "$ROOT_DIR/AGENTS.md" && \
   grep -q "@.claude/rules/github-quality-gate.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "@.claude/rules/github-quality-gate.md" "$ROOT_DIR/AGENTS.md"; then
  pass "README.md, CLAUDE.md, and AGENTS.md reference the vision and roadmap templates, self-upgrade guide, and governance docs"
else
  fail "README.md, CLAUDE.md, or AGENTS.md are missing the vision template link, roadmap template link, self-upgrade guide link, or one or more governance rule references"
fi

if grep -q "@.claude/rules/ml-workflow.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "@.claude/rules/ml-workflow.md" "$ROOT_DIR/AGENTS.md"; then
  pass "CLAUDE.md and AGENTS.md reference the AI/ML workflow rule"
else
  fail "CLAUDE.md and AGENTS.md are not aligned on the AI/ML workflow rule"
fi

if grep -q "@.claude/rules/release-governance.md" "$ROOT_DIR/CLAUDE.md" && \
   grep -q "@.claude/rules/release-governance.md" "$ROOT_DIR/AGENTS.md" && \
   [ -f "$ROOT_DIR/docs/RELEASE_GOVERNANCE.md" ]; then
  pass "CLAUDE.md, AGENTS.md, and docs track the release-governance layer"
else
  fail "Release-governance rule or docs are not aligned"
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

if [ -d "$ROOT_DIR/.claude/teams" ]; then
  pass ".claude/teams exists"
else
  fail ".claude/teams directory is missing"
fi

for team in engineering-team ai-ml-team supabase-team content-publishing-team delivery-ops-team git-github-team advisory-review-team; do
  if [ -f "$ROOT_DIR/.claude/teams/${team}.md" ]; then
    pass "${team} manifest exists"
  else
    fail "${team} manifest is missing"
  fi
done

if grep -q '## Team System' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines the team system"
else
  fail "master agent prompt is missing the team system section"
fi

if grep -q '## New Repo Bootstrap' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'Do not trigger bootstrap when:' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'Bootstrap question areas:' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q '### Guided Initialization Mode' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines the new-repo bootstrap flow and guided initialization mode"
else
  fail "master agent prompt is missing the new-repo bootstrap flow or guided initialization mode"
fi

if grep -q 'Guided initialization should:' "$ROOT_DIR/docs/BOOTSTRAP.md" && \
   grep -q '## Suggested Rounds' "$ROOT_DIR/docs/BOOTSTRAP.md" && \
   grep -q 'guided initialization' "$ROOT_DIR/README.md"; then
  pass "bootstrap docs define guided initialization behavior"
else
  fail "bootstrap docs are missing guided initialization behavior"
fi

if grep -q '## Context Efficiency And Scope Discipline' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'read narrow first' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'prefer local CLI tools over equivalent MCP tools' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines context-efficiency and scope-discipline rules"
else
  fail "master agent prompt is missing context-efficiency and scope-discipline rules"
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

for agent in code-reviewer pr-operator production-readiness-reviewer; do
  if [ -f "$ROOT_DIR/.claude/agents/${agent}.md" ]; then
    pass "${agent} agent exists"
  else
    fail "${agent} agent is missing"
  fi
done

if grep -q '.claude/local-context/' "$ROOT_DIR/.claude/agents/github-safety-guard.md"; then
  pass "github-safety-guard protects the private local-context layer"
else
  fail "github-safety-guard does not protect the private local-context layer"
fi

if [ -f "$ROOT_DIR/.claude/agents/backlog-updater.md" ]; then
  pass "backlog-updater agent exists"
else
  fail "backlog-updater agent is missing"
fi

if grep -q 'Assigned' "$ROOT_DIR/.claude/agents/backlog-updater.md" && \
   grep -q 'Artifact / Plan' "$ROOT_DIR/.claude/agents/backlog-updater.md" && \
   grep -q 'docs/BACKLOG.md' "$ROOT_DIR/.claude/agents/backlog-updater.md"; then
  pass "backlog-updater prompt defines assignment, artifact links, and public/private backlog modes"
else
  fail "backlog-updater prompt is missing assignment, artifact links, or backlog mode rules"
fi

if [ -f "$ROOT_DIR/.claude/agents/idea-executor.md" ]; then
  pass "idea-executor agent exists"
else
  fail "idea-executor agent is missing"
fi

for agent in data-scientist ml-engineer model-evaluator mlops-engineer research-scientist; do
  if [ -f "$ROOT_DIR/.claude/agents/${agent}.md" ]; then
    pass "${agent} agent exists"
  else
    fail "${agent} agent is missing"
  fi
done

if grep -q '@github-safety-guard' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt routes commit and push work through github-safety-guard"
else
  fail "master agent prompt does not route commit and push work through github-safety-guard"
fi

if grep -q '@backlog-updater' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt routes backlog capture through backlog-updater"
else
  fail "master agent prompt does not route backlog capture through backlog-updater"
fi

if grep -q '@idea-executor' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt routes idea planning through idea-executor"
else
  fail "master agent prompt does not route idea planning through idea-executor"
fi

if grep -q 'Backlog mode rules' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'backlog + linked plan' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines backlog mode selection and linked-plan behavior"
else
  fail "master agent prompt is missing backlog mode selection or linked-plan behavior"
fi

if grep -q 'AI/ML: Model training & pipeline implementation' "$ROOT_DIR/.claude/agents/master.md" || \
   grep -q 'AI/ML: Model training & pipelines' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines AI/ML routing"
else
  fail "master agent prompt is missing AI/ML routing"
fi

if grep -q 'ADR-worthy decision / durable trade-off' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'treat it as ADR-candidate work by default' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines default ADR routing for durable decisions"
else
  fail "master agent prompt is missing default ADR routing for durable decisions"
fi

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

if grep -q 'Optional ADR sections:' "$ROOT_DIR/docs/adr/README.md" && \
   grep -q 'Include when useful:' "$ROOT_DIR/.claude/agents/tech-writer.md"; then
  pass "Tracked ADR guidance defines optional sections consistently"
else
  fail "Tracked ADR guidance is missing the optional section contract"
fi

if [ -f "$ROOT_DIR/.agents/skills/create-adr/SKILL.md" ]; then
  if grep -q 'docs/adr/\[NNN\]-\[kebab-case-title\]\.md' "$ROOT_DIR/.agents/skills/create-adr/SKILL.md" && \
     grep -q '# ADR-\[NNN\]:' "$ROOT_DIR/.agents/skills/create-adr/SKILL.md" && \
     grep -q 'Optional sections:' "$ROOT_DIR/.agents/skills/create-adr/SKILL.md" && \
     grep -q 'Follow-Up Docs' "$ROOT_DIR/.agents/skills/create-adr/SKILL.md"; then
    pass "Optional local create-adr skill is aligned with the ADR contract"
  else
    warn "Optional local create-adr skill exists but is not aligned with the ADR contract"
  fi
else
  warn "Optional local create-adr skill is not present in this checkout"
fi

if grep -q 'Do not save to `docs/plans/` or `docs/adr/` automatically' "$ROOT_DIR/.claude/agents/idea-executor.md" && \
   grep -q 'must ask the user for explicit approval' "$ROOT_DIR/.claude/agents/idea-executor.md" && \
   grep -q 'explicitly recommend ADR treatment' "$ROOT_DIR/.claude/agents/idea-executor.md"; then
  pass "idea-executor prompt requires approval before saving plan artifacts"
else
  fail "idea-executor prompt is missing artifact approval rules"
fi

if grep -q 'Approve saving it there' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines an explicit approval prompt for saved idea artifacts"
else
  fail "master agent prompt is missing an explicit approval prompt for saved idea artifacts"
fi

if grep -q 'Approve saving it there' "$ROOT_DIR/.claude/agents/master.md" && \
   grep -q 'Before I save this decision' "$ROOT_DIR/.claude/agents/master.md"; then
  pass "master agent prompt defines an explicit ADR approval prompt"
else
  fail "master agent prompt is missing an explicit ADR approval prompt"
fi

if grep -q 'primary writer for the final record' "$ROOT_DIR/.claude/agents/tech-writer.md"; then
  pass "tech-writer prompt defines ADR authorship responsibility"
else
  fail "tech-writer prompt is missing ADR authorship responsibility"
fi

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

if [ -f "$ROOT_DIR/docs/SUPABASE_REFERENCE.md" ] && \
   grep -q 'Supabase Team' "$ROOT_DIR/README.md" && \
   grep -q 'Supabase Team' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'Supabase Team' "$ROOT_DIR/AGENTS.md" && \
   grep -q 'Supabase Team' "$ROOT_DIR/docs/TEAMS.md" && \
   grep -q 'Workflow 10 — Supabase Team Flow' "$ROOT_DIR/docs/AGENT_WORKFLOWS.md" && \
   grep -q 'Supabase domain-pack reference' "$ROOT_DIR/docs/SYSTEM_REFERENCE.md" && \
   grep -q 'If The Project Uses Supabase' "$ROOT_DIR/docs/PROJECT_CUSTOMIZATION.md"; then
  pass "Supabase team docs and reference are aligned"
else
  fail "Supabase team docs and reference are not aligned"
fi

if grep -q 'Teams are reusable orchestration bundles' "$ROOT_DIR/CLAUDE.md" && \
   grep -q '## Available Teams' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'Teams are reusable orchestration bundles' "$ROOT_DIR/AGENTS.md" && \
   grep -q '## Available Teams' "$ROOT_DIR/AGENTS.md"; then
  pass "CLAUDE.md and AGENTS.md document the team abstraction"
else
  fail "CLAUDE.md and AGENTS.md are not aligned on the team abstraction"
fi

if grep -q '## New Repo Bootstrap' "$ROOT_DIR/README.md" && \
   grep -q 'docs/BOOTSTRAP.md' "$ROOT_DIR/README.md" && \
   grep -q 'Bootstrap should stay flexible:' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'Bootstrap should stay flexible:' "$ROOT_DIR/AGENTS.md"; then
  pass "README.md, CLAUDE.md, and AGENTS.md document the bootstrap flow"
else
  fail "Core docs are not aligned on the bootstrap flow"
fi

if grep -q '## Private Local Context' "$ROOT_DIR/README.md" && \
   grep -q 'docs/LOCAL_CONTEXT.md' "$ROOT_DIR/README.md" && \
   grep -q 'private local context layer' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'private local context layer' "$ROOT_DIR/AGENTS.md"; then
  pass "README.md, CLAUDE.md, and AGENTS.md document the private local-context layer"
else
  fail "Core docs are not aligned on the private local-context layer"
fi

if grep -q '## Context Efficiency' "$ROOT_DIR/README.md" && \
   grep -q 'docs/CONTEXT_EFFICIENCY.md' "$ROOT_DIR/README.md" && \
   grep -q 'docs/CONTEXT_EFFICIENCY.md' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'docs/CONTEXT_EFFICIENCY.md' "$ROOT_DIR/AGENTS.md"; then
  pass "README.md, CLAUDE.md, and AGENTS.md document context-efficiency guidance"
else
  fail "Core docs are not aligned on context-efficiency guidance"
fi

if grep -q '## How To Ask Well' "$ROOT_DIR/README.md" && \
   grep -q 'exact file paths' "$ROOT_DIR/CLAUDE.md" && \
   grep -q 'exact file paths' "$ROOT_DIR/AGENTS.md"; then
  pass "README.md, CLAUDE.md, and AGENTS.md document request-shaping guidance"
else
  fail "Core docs are not aligned on request-shaping guidance"
fi

if grep -q '^\.claude/local-context/$' "$ROOT_DIR/.gitignore"; then
  pass ".gitignore protects the private local-context folder"
else
  fail ".gitignore does not protect the private local-context folder"
fi

check_file "docs/assets/claude-team-kit-hero.svg" "docs/assets/claude-team-kit-hero.svg exists"

if grep -q 'github/actions/workflow/status/Konstantinos-Sakellariou/claude-team-kit/validate.yml' "$ROOT_DIR/README.md"; then
  pass "README.md includes the validation badge"
else
  fail "README.md is missing the validation badge"
fi

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

if grep -q 'propose an ADR by default' "$ROOT_DIR/README.md"; then
  pass "README.md documents default ADR handling"
else
  fail "README.md does not document default ADR handling"
fi

if grep -q 'AI/ML Team' "$ROOT_DIR/README.md"; then
  pass "README.md documents the AI/ML team"
else
  fail "README.md does not document the AI/ML team"
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

if [ -f "$ROOT_DIR/BACKLOG.md" ]; then
  pass "BACKLOG.md exists locally"
else
  warn "BACKLOG.md has not been created locally yet"
fi

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
