# Project Context
Project: claude-team-kit
Description: A reusable workspace kit for Claude-style coding tools that packages agents, skills, rules, hooks, and memory for drop-in use across projects.
Owner: Konstantinos Sakellariou

## Stack
- Language(s): Markdown, JSON, Bash
- Framework(s): Claude workspace configuration
- Database: None
- Testing: Shell-based validation via `./scripts/doctor.sh`
- Package manager: None required

## Architecture
- See `docs/ARCHITECTURE.md`
- See `docs/PROJECT_CUSTOMIZATION.md` when adapting this kit to a real repo
- Canonical implementation lives in `.claude/`
- Key directories: `.claude/`, `docs/`, `docs/plans/`, `docs/adr/`, `scripts/`

## Commands
- Setup workspace: `./scripts/setup.sh`
- Validate workspace: `./scripts/doctor.sh`
- Run validation tests: `python3 -m unittest discover -s tests -v`
- Review backlog: `sed -n '1,240p' BACKLOG.md`
- Review example plan: `sed -n '1,240p' docs/plans/example-execution-plan.md`
- Review changes: `git diff --stat`
- Inspect agents: `find .claude/agents -maxdepth 1 -type f | sort`
- Inspect skills: `find .claude/skills -maxdepth 1 -mindepth 1 -type d | sort`

## Environment
- Copy `.env.example` → `.env` for optional local configuration
- Primary local config: `.claude/settings.local.json`
- Common env vars: `GITHUB_TOKEN`

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

`@master` is always the first responder and only orchestrator in the main thread, even when the user does not explicitly mention it or names another specialist directly.
`@master` must also report which agents were selected, what each one did, and the final synthesized outcome without requiring a separate user request.

## Core Engineering Agents

| Agent | When to invoke |
|---|---|
| `@master` | Default and mandatory entry point — orchestrates all other agents |
| `@architect` | Any structural or design decision |
| `@senior-developer` | Implementation, code review, refactoring |
| `@qa-engineer` | Test plans, coverage gaps, edge cases |
| `@security-auditor` | Anything touching secrets, auth, or data |
| `@github-safety-guard` | Final pre-commit/pre-push review for secrets, sensitive information, and public-disclosure risks |
| `@performance-engineer` | Profiling, throughput, rendering speed |
| `@debugger` | Diagnose failures, trace unexpected behaviour |
| `@risk-officer` | Final check before any major release or deploy |
| `@workspace-updater` | Final step — review and update CLAUDE.md, AGENTS.md, and README.md |

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
| `@backlog-updater` | Maintain `BACKLOG.md` when ideas or follow-ups should be saved for later |

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
| `@idea-executor` | Take ideas from discussion to validated execution plan, flow graph, and step-by-step guidance |

## Automatic Delegation Rules

- Any secret / credentials / auth touched → `@security-auditor` reviews it first
- Any new feature or script → `@qa-engineer` writes the test plan
- Any architectural decision → `@architect` weighs in
- Any performance-sensitive path → `@performance-engineer` reviews it
- Any request to "backlog" or save work for later → `@backlog-updater` updates `BACKLOG.md`
- Any substantial idea exploration that should become a plan → `@idea-executor` leads the execution-plan shaping with supporting reviewers
- Any content ready to publish → `@editorial-reviewer` must pass it first
- Before any commit or push → `@github-safety-guard` reviews the outgoing changes and `@master` presents the findings to the user
- Before any public release or push → `@privacy-reviewer` runs the mandatory scan
- Before any major release → `@risk-officer` does a final sign-off
- After any significant task → `@workspace-updater` runs last and reviews CLAUDE.md, AGENTS.md, and README.md automatically

## Default Reporting Rules

- `@master` must announce the selected agents before or as work begins
- `@master` must summarize what each selected agent did
- `@master` must return a synthesized execution report for significant work by default
- Before any commit or push, `@master` must surface the `@github-safety-guard` report so the user can decide whether to proceed
- Before saving planning artifacts into `docs/plans/` or `docs/adr/`, `@master` must ask for explicit user approval

---

# Important Notes
- This repo is a workspace kit, not a runtime orchestration engine
- The canonical implementation lives in `.claude/`; repo docs must describe that implementation accurately
- Real projects should move concrete architecture, routes, deployment notes, and gotchas into `CLAUDE.md` and `AGENTS.md`
- Project-specific sync workflows belong in narrow extensions to `@master` and `@workspace-updater`, not in the generic core loop
- `@master` must remain the only top-level orchestrator, and `@workspace-updater` must remain the mandatory final step for the core docs
- `@master` must make orchestration visible in the chat by default: selected agents, actions taken, and final report
- `BACKLOG.md` is the durable place for deferred ideas and future work; do not rely on chat history alone
- Approved execution plans belong in `docs/plans/`; approved architecture or policy decisions belong in `docs/adr/`
- `README.md`, `CLAUDE.md`, and `AGENTS.md` must stay in sync when workflow, commands, or structure change
