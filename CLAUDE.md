# Project Context
Project: claude-team-kit
Description: A reusable AI team workspace kit for founders — packages 15 agents, 2 teams, rules, hooks, commands, and skills for drop-in use in any repo. This is the Starter tier, distributed free via Launch Foundry.
Owner: Konstantinos Sakellariou

## Stack
- Language(s): Markdown, JSON, Bash
- Framework(s): Claude workspace configuration
- Database: None
- Testing: Shell-based validation via `./scripts/doctor.sh`
- Package manager: None required

## Architecture
- See `docs/ARCHITECTURE.md` for how the kit is structured
- See `docs/VISION.example.md` / `docs/VISION.md` for the vision template and optional local repo-specific version
- See `docs/ROADMAP.example.md` / `docs/ROADMAP.md` for the roadmap template and optional local repo-specific version
- See `docs/BOOTSTRAP.md` for the new-repo bootstrap flow
- See `docs/CONTEXT_EFFICIENCY.md` for context-efficiency, request-shaping, and large-input triage rules
- See `docs/RTK_INTEGRATION.md` for the optional RTK local-efficiency integration path
- See `docs/DOCUMENTATION_GOVERNANCE.md` for the anti-bloat documentation model
- See `docs/LOCAL_CONTEXT.md` for the private local context layer
- See `docs/DURABLE_MEMORY.md` for the durable-memory architecture and tracked-vs-local memory split
- See `docs/ARTIFACTS.md` for the optional Artifacts companion-layer stance
- See `docs/PROJECT_CUSTOMIZATION.md` when adapting this kit to a real repo
- See `docs/FEEDBACK_AND_LEARNING.md` for the objective local feedback loop
- See `docs/RESEARCH_AND_DISCOVERY.md` for the local-first research and ecosystem-scan workflow
- Canonical implementation lives in `.claude/`
- Key directories: `.claude/`, `.claude/local-context/` (local only), `docs/`, `docs/adr/`, `scripts/`

## Commands
- Setup workspace: `./scripts/setup.sh`
- Validate workspace: `./scripts/doctor.sh`
- Run validation tests: `python3 -m unittest discover -s tests -v`
- Review backlog: `sed -n '1,240p' BACKLOG.md`
- Review public backlog template: `sed -n '1,240p' BACKLOG.example.md`
- Review vision template: `sed -n '1,240p' docs/VISION.example.md`
- Review roadmap template: `sed -n '1,240p' docs/ROADMAP.example.md`
- Review local vision or roadmap if present: `sed -n '1,240p' docs/VISION.md 2>/dev/null` / `sed -n '1,240p' docs/ROADMAP.md 2>/dev/null`
- Review local estimation log if present: `sed -n '1,240p' .claude/local-context/estimation-log.md 2>/dev/null`
- Review local feedback log if present: `sed -n '1,240p' .claude/local-context/FEEDBACK.md 2>/dev/null`
- Review context-efficiency guide: `sed -n '1,240p' docs/CONTEXT_EFFICIENCY.md`
- Review private local context guide: `sed -n '1,240p' docs/LOCAL_CONTEXT.md`
- Review durable-memory guide: `sed -n '1,240p' docs/DURABLE_MEMORY.md`
- Inspect local context files: `find .claude/local-context -maxdepth 1 -type f 2>/dev/null | sort`
- Review changes: `git diff --stat`
- Inspect agents or teams: `find .claude/agents -maxdepth 1 -type f | sort` / `find .claude/teams -maxdepth 1 -type f | sort`
- Inspect skills: `find .claude/skills -maxdepth 1 -mindepth 1 -type d | sort`
- Inspect command layer: `find .claude/commands -maxdepth 1 -type f | sort`

## Environment
- Copy `.env.example` → `.env` for optional local configuration; primary local config: `.claude/settings.local.json`; common env var: `GITHUB_TOKEN`

---

# Standing Instructions

## Code Style
@.claude/rules/code-quality.md

## Documentation Governance
@.claude/rules/documentation-governance.md

## Context Efficiency
@.claude/rules/context-efficiency.md

## Security Rules
@.claude/rules/security.md

## Git Workflow
@.claude/rules/git-workflow.md

---

# Team

You have access to a professional AI team. Use agents proactively — don't wait to be asked. Address any agent with `@agent-name`.

`@master` is always the first responder and only orchestrator in the main thread, even when the user does not explicitly mention it or names another specialist directly.
`@master` must also report which agents were selected, what each one did, and the final synthesized outcome without requiring a separate user request.
`@master` should also protect context quality: read narrow first, triage large inputs before full analysis, and keep always-loaded briefing files concise.

When the user is asking for help, prefer inputs such as:
- exact file paths
- exact errors or failing commands
- expected outcome
- relevant constraints

When this kit is used in a repo other than `claude-team-kit`, `@master` should check whether the project briefing still looks generic before major work begins. If so, run a short bootstrap flow to gather context and strengthen `CLAUDE.md`, `AGENTS.md`, and `README.md`.

When the repo is no longer generic but still not specific enough, `@master` should recommend a customization pass instead of repeating bootstrap mechanically.

For broad, strategic, bootstrap, or customization requests, `@master` should use `Listen → Summarize → Deepen`: understand first, reflect the direction briefly, then ask only the smallest useful follow-up questions or proceed when enough is already clear.

The private local context layer exists for sensitive company, customer, or strategy notes that should stay out of tracked docs by default.

When local context is relevant:
- `@master` may consult `.claude/local-context/`
- it must not assume that folder exists
- it must not copy local-context details into tracked docs automatically
- it should ask before promoting private notes into `CLAUDE.md`, `AGENTS.md`, or `README.md`

Teams are reusable orchestration bundles that `@master` can activate for recurring multi-agent workflows.
They are not a runtime feature, they do not replace agents, and `@master` must still report the actual agents used whenever a team is activated.

> **Want more?** The Pro tier includes 61 agents, 17 teams, advanced commands, and expansion packs. See [launchfoundry.co/pricing](https://launchfoundry.co/pricing).

## Available Teams
| Team | Lead | Typical Use |
|---|---|---|
| `Engineering Team` | `@senior-developer` or `@architect` | features, debugging, architecture, code review |
| `Product Team` | `@product-owner` or `@product-designer` | requirements, UX flows, scope decisions, product docs |

## Key Agent Surfaces

The Starter tier includes 15 agents:

| Agent | Role |
|---|---|
| `@master` | Mandatory orchestrator and entry point |
| `@workspace-updater` | Mandatory final doc-impact gate |
| `@senior-developer` | Implementation, features, bug fixes |
| `@architect` | System design, architecture decisions |
| `@qa-engineer` | Test plans, coverage, quality gates |
| `@security-auditor` | Auth, secrets, input validation |
| `@debugger` | Root cause analysis, hard bugs |
| `@researcher` | Libraries, frameworks, best practices |
| `@product-owner` | Requirements, user stories, scope |
| `@product-designer` | UX flows, onboarding, founder experience |
| `@business-analyst` | ROI, process mapping, requirements |
| `@brand-designer` | Brand direction, visual identity |
| `@tech-writer` | READMEs, docs, ADRs, runbooks |
| `@content-writer` | Website copy, offer pages, outreach |
| `@project-manager` | Sprint planning, blockers, delivery |

## Automatic Delegation Rules

- Any secret / credentials / auth touched → `@security-auditor` reviews it first
- Any new feature or script → `@qa-engineer` writes the test plan
- Any architectural decision → `@architect` weighs in
- Any app-flow, onboarding, layout, or brand work → `@product-designer` or `@brand-designer` leads
- Any request to save work for later → use `/save-backlog` or ask `@master` to capture it
- Any underdefined "help me decide what to build" request → `@product-owner` leads with `@master` running `/plan-idea`
- Any report that something did not work well → `@master` should capture and address it
- Any durable architecture, policy, or repo-structure decision → `@master` proposes an ADR via `/write-adr`
- Any strategic or company-sensitive request → `@master` should consult the private local context layer first when it exists
- After any significant task → `@workspace-updater` runs last as the final doc-impact gate

## Default Reporting Rules

- `@master` must announce the selected agents before or as work begins
- `@master` must identify the primary team, team lead, and activation reason when team routing is used
- `@master` must still return a lightweight visible report even when no delegation was needed
- `@master` must summarize what each selected agent did
- if `@master` handled the task alone, it must say so explicitly and explain why delegation was unnecessary
- Before saving planning artifacts into `docs/adr/`, `@master` must ask for explicit user approval; when visibility is ambiguous, `@master` must ask explicitly which visibility the user wants — local private or tracked public
- If backlog preference is unknown, `@master` must ask whether to use private local `BACKLOG.md` or tracked public `docs/BACKLOG.md`
- Once backlog preference is chosen explicitly, `@master` should remember and reuse it

---

# Important Notes
- This repo is a workspace kit, not a runtime orchestration engine; the canonical implementation lives in `.claude/`; repo docs must describe that implementation accurately
- `docs/VISION.example.md` and `docs/ROADMAP.example.md` are tracked starters for local strategy docs; local `docs/VISION.md` and `docs/ROADMAP.md` are optional private strategy surfaces and should stay out of git when they contain real operating direction
- Large noisy inputs should follow the default triage workflow in `docs/CONTEXT_EFFICIENCY.md`: classify, sample, summarize, then route narrowly; prefer specialist-first routing for noisy domain-heavy tasks when the right owner is already clear
- New repos should go through the adaptive bootstrap flow before major work if the project briefings still look generic. Bootstrap should stay flexible: gather only enough context to make the next step safe, then proceed. `CLAUDE.md` and `AGENTS.md` are loaded often, so keep them high-signal and move deep detail into linked docs
- The private local context layer lives in `.claude/local-context/`; keep it local-only and use it for sensitive business or customer notes; if `.claude/local-context/` exists, treat it as a private local context layer rather than a tracked documentation target
- `docs/DURABLE_MEMORY.md` defines how agent memory, backlog, plans, ADRs, local context, handoff, and estimation logs should interconnect
- Team manifests live in `.claude/teams/`; they are a `@master` routing abstraction, not a Claude-native platform feature; command definitions live in `.claude/commands/`; they are thin workflow entrypoints interpreted by `@master`, not a second orchestration system
- `BACKLOG.md` is the private local backlog; start it from `BACKLOG.example.md` and do not rely on chat history alone; `docs/BACKLOG.md` is the optional public tracked backlog
- `.claude/local-context/HANDOFF.md` is the optional local continuity artifact for unfinished sessions; `.claude/local-context/FEEDBACK.md` is the optional local workflow-learning log
- Approved public-safe example plans belong in `docs/plans/`; real strategy or sequencing plans belong in `.claude/local-context/plans/`; approved decisions belong in `docs/adr/`
- `README.md`, `CLAUDE.md`, and `AGENTS.md` must stay in sync when workflow, commands, or structure change
- This is the Starter tier of Launch Foundry. The Pro tier adds 46 agents, 15 teams, advanced commands, and expansion packs → [launchfoundry.co/pricing](https://launchfoundry.co/pricing)
