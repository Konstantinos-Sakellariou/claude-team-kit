# Project Context
<!-- CUSTOMIZE THIS SECTION per project -->
Project: [PROJECT NAME]
Description: [What this project does in 1–2 sentences]
Owner: Konstantinos Sakellariou

## Stack
- Language(s): [e.g. Python 3.11 + TypeScript 5]
- Framework(s): [e.g. FastAPI + React/Next.js]
- Database: [e.g. PostgreSQL + Redis]
- Testing: [e.g. pytest + Jest]
- Package manager: [e.g. pip/poetry + npm/pnpm]

## Architecture
- See `docs/ARCHITECTURE.md` (create if needed)
- Key directories: `src/`, `tests/`, `docs/`, `scripts/`

## Commands
<!-- Customize these per project -->
- Start dev:    `[command]`
- Run tests:    `[command]`
- Lint:         `[command]`
- Build:        `[command]`
- Deploy:       `[command]`

## Environment
- Copy `.env.example` → `.env` before starting
- Required env vars: [list them]

---

# Standing Instructions

## Code Style
@.claude/rules/code-quality.md

## Python Rules
@.claude/rules/python.md

## TypeScript Rules
@.claude/rules/typescript.md

## Security Rules
@.claude/rules/security.md

## Testing Rules
@.claude/rules/testing.md

## Git Workflow
@.claude/rules/git-workflow.md

## Performance Rules
@.claude/rules/performance.md

## API Design
@.claude/rules/api-design.md

---

# Team

You have access to a full professional team. Use agents proactively — don't wait to be asked. Address any agent with `@agent-name`.

## Core Engineering Agents

| Agent | When to invoke |
|---|---|
| `@master` | Default entry point — orchestrates all other agents |
| `@architect` | Any structural or design decision |
| `@senior-developer` | Implementation, code review, refactoring |
| `@qa-engineer` | Test plans, coverage gaps, edge cases |
| `@security-auditor` | Anything touching secrets, auth, or data |
| `@performance-engineer` | Profiling, throughput, rendering speed |
| `@debugger` | Diagnose failures, trace unexpected behaviour |
| `@risk-officer` | Final check before any major release or deploy |
| `@workspace-updater` | Keep CLAUDE.md and README.md in sync |

## Content and Publishing Agents

| Agent | When to invoke |
|---|---|
| `@topic-researcher` | Find fresh, source-backed topics for any content workflow |
| `@content-planner` | Build structured multi-edition editorial plans |
| `@content-writer` | Write polished content for any publication format (uses `opus`) |
| `@editorial-reviewer` | Final quality gate before any content is published |
| `@source-verifier` | Verify all claims are backed by strong, current sources |
| `@tone-calibrator` | Ensure voice and complexity match the target audience |
| `@feedback-synthesizer` | Turn audience replies into backlog topics and planning input |
| `@backlog-curator` | Score, prioritise, and prune the content or feature backlog |

## Delivery and Operations Agents

| Agent | When to invoke |
|---|---|
| `@delivery-orchestrator` | Render, gate-check, and deliver content via any configured channel |
| `@delivery-monitor` | Review delivery reports and flag errors or anomalies |
| `@privacy-reviewer` | Mandatory scan before any public release or repository push |
| `@changelog-writer` | Generate versioned changelog entries after releases or publications |
| `@ab-tester` | Design and analyse A/B tests for headlines, subject lines, CTAs |

## Advisory Agents

| Agent | When to invoke |
|---|---|
| `@business-analyst` | Business implications, requirements, ROI |
| `@customer-advocate` | End-user or reader experience, UX empathy |
| `@product-owner` | Scope decisions, backlog prioritisation |
| `@project-manager` | Scheduling, coordination, deadline tracking |
| `@researcher` | Deep-dive research beyond topic-researcher scope |
| `@devils-advocate` | Challenge assumptions before committing to a direction |
| `@judge` | Tiebreaker for contested decisions |
| `@tech-writer` | Docs, README, architecture diagrams |

## Automatic Delegation Rules

- Any secret / credentials / auth touched → `@security-auditor` reviews it first
- Any new feature or script → `@qa-engineer` writes the test plan
- Any architectural decision → `@architect` weighs in
- Any performance-sensitive path → `@performance-engineer` reviews it
- Any content ready to publish → `@editorial-reviewer` must pass it first
- Before any public release or push → `@privacy-reviewer` runs the mandatory scan
- Before any major release → `@risk-officer` does a final sign-off
- After any significant task → `@workspace-updater` keeps CLAUDE.md and README.md current

---

# Important Notes
<!-- Add project-specific gotchas here as you discover them -->
- [Add project-specific notes as you find them]
- `README.md` and `CLAUDE.md` must stay in sync — update them together when workflow, commands, or agents change
