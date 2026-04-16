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
- See `docs/VISION.example.md` for the tracked vision template and `docs/VISION.md` for the optional local repo-specific version
- See `docs/ROADMAP.example.md` for the tracked roadmap template and `docs/ROADMAP.md` for the optional local repo-specific version
- See `docs/BOOTSTRAP.md` for the new-repo bootstrap flow
- See `docs/CONTEXT_EFFICIENCY.md` for context-efficiency, request-shaping, and large-input triage rules
- See `docs/DOCUMENTATION_GOVERNANCE.md` for anti-bloat documentation policy
- See `docs/LOCAL_CONTEXT.md` for the private local context layer
- See `docs/SYSTEM_REFERENCE.md` for the full feature inventory and connection map
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
- Review vision template: `sed -n '1,240p' docs/VISION.example.md`
- Review roadmap template: `sed -n '1,240p' docs/ROADMAP.example.md`
- Review local vision if present: `sed -n '1,240p' docs/VISION.md 2>/dev/null`
- Review local roadmap if present: `sed -n '1,240p' docs/ROADMAP.md 2>/dev/null`
- Review context-efficiency guide: `sed -n '1,240p' docs/CONTEXT_EFFICIENCY.md`
- Review private local context guide: `sed -n '1,240p' docs/LOCAL_CONTEXT.md`
- Inspect local context files: `find .claude/local-context -maxdepth 1 -type f 2>/dev/null | sort`
- Review changes: `git diff --stat`
- Inspect agents: `find .claude/agents -maxdepth 1 -type f | sort`
- Inspect teams: `find .claude/teams -maxdepth 1 -type f | sort`
- Inspect skills: `find .claude/skills -maxdepth 1 -mindepth 1 -type d | sort`
- Inspect command layer: `find .claude/commands -maxdepth 1 -type f | sort`

## Environment
- Copy `.env.example` → `.env` for optional local configuration
- Primary local config: `.claude/settings.local.json`
- Common env vars: `GITHUB_TOKEN`

---

# Standing Instructions

## Code Style
@.claude/rules/code-quality.md

## Documentation Governance
@.claude/rules/documentation-governance.md

## Repo Cleanup
@.claude/rules/repo-cleanup.md

## Artifact Governance
@.claude/rules/artifact-governance.md

## Context Efficiency
@.claude/rules/context-efficiency.md

## GitHub Quality Gate
@.claude/rules/github-quality-gate.md

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
- use guided initialization when the repo is especially underdefined
- ask in small rounds instead of a giant setup questionnaire
- offer candidate answers or categories when the user is still figuring the project out
- do not interrupt already-customized repos unnecessarily

The private local context layer exists for sensitive company, customer, or strategy notes that should stay out of tracked docs by default.

When local context is relevant:
- `@master` may consult `.claude/local-context/`
- it must not assume that folder exists
- it must not copy local-context details into tracked docs automatically
- it should ask before promoting private notes into `CLAUDE.md`, `AGENTS.md`, or `README.md`

Teams are reusable orchestration bundles that `@master` can activate for recurring multi-agent workflows.
They are not a runtime feature, they do not replace agents, and `@master` must still report the actual agents used whenever a team is activated.

## Available Teams

| Team | Lead | Typical Use |
|---|---|---|
| `Engineering Team` | `@senior-developer` or `@architect` | features, debugging, architecture, engineering review |
| `AI/ML Team` | `@data-scientist` or `@ml-engineer` | model framing, training, evaluation, rollout readiness |
| `Supabase Team` | `@architect` or `@senior-developer` | auth, schema, migrations, RLS, storage, edge functions, rollout safety |
| `Content & Publishing Team` | `@content-planner` or `@content-writer` | planning, drafting, source-backed editorial workflows |
| `Delivery & Ops Team` | `@delivery-orchestrator` or safety lead | release, delivery, monitoring, privacy, backlog persistence |
| `Git / GitHub Team` | `@github-safety-guard` or `@risk-officer` | commit, push, PR, release readiness, branch hygiene, repo-safety review |
| `Advisory Review Team` | `@product-owner`, `@business-analyst`, or `@idea-executor` | planning, prioritization, business, UX, risk, contested decisions |

## Key Agent Surfaces

For the full 41-agent roster and cross-layer map, use `docs/SYSTEM_REFERENCE.md`.

The hot-path agents to keep in mind here are:
- `@master` — mandatory entry point and orchestrator
- `@workspace-updater` — mandatory final documentation-alignment step
- `@github-safety-guard`, `@code-reviewer`, `@production-readiness-reviewer` — GitHub quality gates
- `@backlog-updater` and `@idea-executor` — deferred work and plan persistence
- `@data-scientist`, `@ml-engineer`, `@model-evaluator` — AI/ML lead/gate pattern

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
- Before substantial work in a collaborative git repo → `@master` should ask whether a quick sync check or pull is needed if the branch may be stale
- Before any code-affecting commit, push, or PR → `@github-safety-guard`, `@code-reviewer`, and `@qa-engineer` review the change
- Before merge-critical or release-heavy GitHub work → `@production-readiness-reviewer` is a required gate
- Before any PR packaging flow → `@pr-operator` improves reviewer context and PR quality
- Before any commit or push → `@github-safety-guard` reviews the outgoing changes and `@master` presents the findings to the user
- Before any public release or push → `@privacy-reviewer` runs the mandatory scan
- Before any major release → `@risk-officer` does a final sign-off
- After any significant task → `@workspace-updater` runs last and reviews CLAUDE.md, AGENTS.md, and README.md automatically

## Default Reporting Rules

- `@master` must announce the selected agents before or as work begins
- `@master` must identify the primary team, team lead, and activation reason when team routing is used
- `@master` must still return a lightweight visible report even when no delegation was needed
- `@master` must summarize what each selected agent did
- if `@master` handled the task alone, it must say so explicitly and explain why delegation was unnecessary
- `@master` must return a synthesized execution report for significant work by default
- for supported slash-style workflow commands, `@master` must identify the command and map it to the underlying workflow owner
- Before any commit or push, `@master` must surface the `@github-safety-guard` report so the user can decide whether to proceed
- Before saving planning artifacts into `docs/plans/` or `docs/adr/`, `@master` must ask for explicit user approval
- If backlog preference is unknown, `@master` must ask whether backlog capture should use private local `BACKLOG.md` or tracked public `docs/BACKLOG.md`
- If a durable decision is made, `@master` should treat it as ADR-candidate work by default rather than waiting for the user to ask
- Future backlog items, plans, and major additions should be shaped against local `docs/VISION.md` when it exists, using `docs/VISION.example.md` as the fallback model for what the doc should capture
- When local `docs/ROADMAP.md` exists, use it to align sequencing and `Target Phase / When`; otherwise use `docs/ROADMAP.example.md` as the structure reference

---

# Important Notes
- This repo is a workspace kit, not a runtime orchestration engine
- The canonical implementation lives in `.claude/`; repo docs must describe that implementation accurately
- `docs/VISION.example.md` and `docs/ROADMAP.example.md` are tracked starters for local strategy docs
- local `docs/VISION.md` and `docs/ROADMAP.md` are optional private strategy surfaces and should stay out of git when they contain real operating direction
- The rules layer now includes dedicated governance for docs, artifacts, and context quality in addition to language or domain rules
- `docs/DOCUMENTATION_GOVERNANCE.md` defines the anti-bloat documentation model; follow it before expanding the hot-path briefings
- GitHub-bound code should follow the visible quality gate defined in `.claude/rules/github-quality-gate.md`
- `docs/SYSTEM_REFERENCE.md` is the full feature and connection report; prefer linking to it over expanding `CLAUDE.md` or `AGENTS.md` inline
- Team manifests live in `.claude/teams/`; they are a `@master` routing abstraction, not a Claude-native platform feature
- Command definitions live in `.claude/commands/`; they are thin workflow entrypoints interpreted by `@master`, not a second orchestration system
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
- Approved public-safe execution plans belong in `docs/plans/`; private strategy or roadmap plans belong in `.claude/local-context/plans/`; approved architecture or policy decisions belong in `docs/adr/`
- For substantial deferred ideas, prefer a backlog entry plus a linked plan rather than a backlog row alone, choosing `docs/plans/` versus `.claude/local-context/plans/` based on privacy
- `@tech-writer` is the primary ADR author once `@master` receives explicit approval to save the record
- `README.md`, `CLAUDE.md`, and `AGENTS.md` must stay in sync when workflow, commands, or structure change
