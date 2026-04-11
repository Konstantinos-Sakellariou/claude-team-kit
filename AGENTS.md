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
- See `docs/BOOTSTRAP.md` for the new-repo bootstrap flow
- See `docs/CONTEXT_EFFICIENCY.md` for context-efficiency, request-shaping, and large-input triage rules
- See `docs/LOCAL_CONTEXT.md` for the private local context layer
- See `docs/PROJECT_CUSTOMIZATION.md` when adapting this kit to a real repo
- Canonical implementation lives in `.claude/`
- Key directories: `.claude/`, `.claude/local-context/` (local only), `docs/`, `docs/plans/`, `docs/adr/`, `scripts/`

## Commands
- Setup workspace: `./scripts/setup.sh`
- Validate workspace: `./scripts/doctor.sh`
- Run validation tests: `python3 -m unittest discover -s tests -v`
- Review backlog: `sed -n '1,240p' BACKLOG.md`
- Review public backlog template: `sed -n '1,240p' BACKLOG.example.md`
- Review example plan: `sed -n '1,240p' docs/plans/example-execution-plan.md`
- Review context-efficiency guide: `sed -n '1,240p' docs/CONTEXT_EFFICIENCY.md`
- Review private local context guide: `sed -n '1,240p' docs/LOCAL_CONTEXT.md`
- Inspect local context files: `find .claude/local-context -maxdepth 1 -type f 2>/dev/null | sort`
- Review changes: `git diff --stat`
- Inspect agents: `find .claude/agents -maxdepth 1 -type f | sort`
- Inspect teams: `find .claude/teams -maxdepth 1 -type f | sort`
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

## AI/ML Workflow Rules
@.claude/rules/ml-workflow.md

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
`@master` should also protect context quality: read narrow first, triage large inputs before full analysis, and keep always-loaded briefing files concise.

When the user is asking for help, prefer inputs such as:
- exact file paths
- exact errors or failing commands
- expected outcome
- relevant constraints

When this kit is used in a repo other than `claude-team-kit`, `@master` should also check whether the project briefing still looks generic before major work begins. If so, it should run a short bootstrap flow to gather context and strengthen `CLAUDE.md`, `AGENTS.md`, and `README.md`.

Bootstrap should stay flexible:
- ask a short structured set of questions
- accept partial answers
- allow temporary assumptions when the user is unsure
- do not interrupt already-customized repos unnecessarily

The private local context layer exists for sensitive company, customer, or strategy notes that should stay out of tracked docs by default.

When local context is relevant:
- `@master` may consult `.claude/local-context/`
- it must not assume that folder exists
- it must not copy local-context details into tracked docs automatically
- it should ask before promoting private notes into `CLAUDE.md`, `AGENTS.md`, or `README.md`

Teams are reusable orchestration bundles that `@master` can activate for recurring multi-agent workflows. They are not a runtime feature and they do not replace agents.

Teams help by:
- making routing more consistent for repeated request types
- giving each recurring workflow a clear lead and supporting cast
- making orchestration easier to explain back to the user
- letting the kit scale to new domains without endless one-off routing rows

`@master` must still report the actual agents used whenever a team is activated.

## Available Teams

| Team | Lead | Typical Use |
|---|---|---|
| `Engineering Team` | `@senior-developer` or `@architect` | features, debugging, architecture, engineering review |
| `AI/ML Team` | `@data-scientist` or `@ml-engineer` | model framing, training, evaluation, rollout readiness |
| `Content & Publishing Team` | `@content-planner` or `@content-writer` | planning, drafting, source-backed editorial workflows |
| `Delivery & Ops Team` | `@delivery-orchestrator` or safety lead | release, delivery, monitoring, privacy, backlog persistence |
| `Advisory Review Team` | `@product-owner`, `@business-analyst`, or `@idea-executor` | planning, prioritization, business, UX, risk, contested decisions |

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

## AI/ML Specialist Agents

| Agent | When to invoke |
|---|---|
| `@data-scientist` | Problem framing, exploratory analysis, feature design, baseline definition, experiment strategy |
| `@ml-engineer` | Training pipelines, reproducibility, model packaging, inference-oriented implementation |
| `@model-evaluator` | Independent metrics, fairness, robustness, explainability, deployment readiness — mandatory quality gate |
| `@mlops-engineer` | Rollout strategy, monitoring, model lifecycle operations, incident and rollback planning |
| `@research-scientist` | Literature review, benchmark critique, frontier-method assessment, novelty-vs-complexity judgement |

## Delivery and Operations Agents

| Agent | When to invoke |
|---|---|
| `@delivery-orchestrator` | Render, gate-check, and deliver content via any configured channel |
| `@delivery-monitor` | Review delivery reports and flag errors or anomalies |
| `@privacy-reviewer` | Mandatory scan before any public release or repository push |
| `@changelog-writer` | Generate versioned changelog entries after releases or publications |
| `@ab-tester` | Design and analyse A/B tests for headlines, subject lines, CTAs |
| `@backlog-updater` | Maintain the chosen backlog when ideas or follow-ups should be saved for later, with optional linked plan artifacts |

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
- Any AI/ML exploratory or feature work → `@data-scientist` leads
- Any AI/ML model training or pipeline implementation → `@ml-engineer` leads
- Any AI/ML evaluation or release-readiness decision → `@model-evaluator` is the mandatory quality gate
- Any AI/ML deployment or monitoring work → `@mlops-engineer` leads after evaluator sign-off
- Any novel AI/ML method or benchmark question → `@research-scientist` advises
- Any request to "backlog" or save work for later → `@backlog-updater` updates the chosen backlog and can link an approved plan
- Any substantial idea exploration that should become a plan → `@idea-executor` leads the execution-plan shaping with supporting reviewers
- Any durable architecture, policy, workflow, or repo-structure decision → `@master` proposes an ADR by default and coordinates `@architect`, `@devils-advocate`, `@judge`, and `@tech-writer`
- Any strategic, startup, customer, or company-sensitive request → `@master` should consult the private local context layer first when it exists
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
- If backlog preference is unknown, `@master` must ask whether backlog capture should use private local `BACKLOG.md` or tracked public `docs/BACKLOG.md`
- If a durable decision is made, `@master` should treat it as ADR-candidate work by default rather than waiting for the user to ask

---

# Important Notes
- This repo is a workspace kit, not a runtime orchestration engine
- The canonical implementation lives in `.claude/`; repo docs must describe that implementation accurately
- Team manifests live in `.claude/teams/`; they are a `@master` routing abstraction, not a Claude-native platform feature
- New repos should go through the adaptive bootstrap flow before major work if the project briefings still look generic
- `CLAUDE.md` and `AGENTS.md` are loaded often; keep them high-signal and move deep detail into linked docs when possible
- The private local context layer lives in `.claude/local-context/`; keep it local-only and use it for sensitive business or customer notes
- The kit includes a generic AI/ML specialist layer; keep platform-specific ML guidance in project briefings, not in the shared core
- Real projects should move concrete architecture, routes, deployment notes, and gotchas into `CLAUDE.md` and `AGENTS.md`
- Project-specific sync workflows belong in narrow extensions to `@master` and `@workspace-updater`, not in the generic core loop
- `@master` must remain the only top-level orchestrator, and `@workspace-updater` must remain the mandatory final step for the core docs
- `@master` must make orchestration visible in the chat by default: selected agents, actions taken, and final report
- `BACKLOG.md` is the private local backlog; start it from `BACKLOG.example.md` and do not rely on chat history alone
- `docs/BACKLOG.md` is the optional public tracked backlog; start it from `docs/BACKLOG.example.md` when a repo wants visible backlog history
- If `.claude/local-context/` exists, treat it as a private local context layer rather than a tracked documentation target
- Approved execution plans belong in `docs/plans/`; approved architecture or policy decisions belong in `docs/adr/`
- For substantial deferred ideas, prefer a backlog entry plus a linked plan in `docs/plans/` rather than a backlog row alone
- `@tech-writer` is the primary ADR author once `@master` receives explicit approval to save the record
- `README.md`, `CLAUDE.md`, and `AGENTS.md` must stay in sync when workflow, commands, or structure change
