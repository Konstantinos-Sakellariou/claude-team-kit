# claude-team-kit

A production-ready workspace kit for Claude-style coding tools. It gives any repo a professional AI team through agent prompts, skills, rules, hooks, and persistent memory.

This repo is a team-definition layer, not a standalone orchestration runtime. It focuses on reusable workspace structure and operating conventions rather than tmux workers, background daemons, or execution HUDs.

## What's Inside

```text
.claude/
├── agents/          30 specialized agents across engineering, content, delivery, and advisory
├── skills/          17 reusable skills (code-review, fix-bug, business-case, create-pr...)
├── rules/           Modular rule files — Python, TypeScript, security, testing, git, performance, API design
├── hooks/           Shell automations (auto-format, secret detection, file protection...)
└── agent-memory/    Persistent per-agent memory (grows over time)
CLAUDE.md            Master project briefing — customize per project
AGENTS.md            Compatibility briefing for tools that read AGENTS.md
.mcp.json            MCP server config (GitHub pre-configured)
docs/                Workflow and architecture documentation
scripts/             Setup and validation helpers
.env.example         Optional local environment template
```

## Quick Start

1. Use this repo as a template or copy it into your project root
2. Run `./scripts/setup.sh`
3. Fill in `.claude/settings.local.json` and/or `.env` with your `GITHUB_TOKEN`
4. Edit `CLAUDE.md` for the target project you want the kit to describe
5. Run `./scripts/doctor.sh`
6. Start a Claude session and address `@master`

## What This Repo Is

- A reusable workspace kit for agent-based development
- A curated team of 30 agents with explicit collaboration patterns
- A prompt and guardrail layer that can be dropped into another project

## What This Repo Is Not

- A standalone orchestration daemon
- A CLI worker runtime
- A token analytics platform
- A replacement for execution engines such as OMC

---

## How Orchestration Works

**Every request goes through `@master`. Always.**

You never call specialist agents directly. You talk to `@master`, and it decides who runs, in what order, and whether things happen in parallel or sequentially — then synthesises everything back into one coherent response.

Even if a user does not explicitly mention `@master`, or names a specialist directly, `@master` remains the first and only orchestrator in the main thread.

By default, `@master` also reports which agents were selected, what each one did, and the outcome of the orchestration run. Users should not need to ask explicitly for that visibility.

```mermaid
flowchart TD
    USER(["👤 Your request"])
    USER --> MASTER

    MASTER["@master\n1. Receives every request\n2. Maps the full scope\n3. Announces the plan\n4. Dispatches agents\n5. Synthesises reports\n6. Resolves conflicts\n7. Signs off on completion\n8. Always ends with @workspace-updater"]

    MASTER --> ENG["⚙️ Engineering\n@architect\n@senior-developer\n@qa-engineer\n@security-auditor\n@debugger\n@performance-engineer\n@researcher"]

    MASTER --> CONT["📝 Content & Publishing\n@topic-researcher\n@content-planner\n@content-writer\n@editorial-reviewer\n@source-verifier\n@tone-calibrator\n@backlog-curator\n@feedback-synthesizer"]

    MASTER --> DELIV["🚀 Delivery & Ops\n@delivery-orchestrator\n@delivery-monitor\n@privacy-reviewer\n@changelog-writer\n@ab-tester"]

    MASTER --> ADV["🧠 Advisory\n@business-analyst\n@product-owner\n@project-manager\n@customer-advocate\n@devils-advocate\n@risk-officer\n@judge\n@tech-writer"]

    ENG --> SYNTH(["@master synthesises all reports"])
    CONT --> SYNTH
    DELIV --> SYNTH
    ADV --> SYNTH

    SYNTH --> WU["@workspace-updater\nreviews CLAUDE.md + AGENTS.md + README.md\nfinal step, always"]
    WU --> DONE(["✓ Done"])
```

**The orchestration loop — what `@master` does on every request:**

```
RECEIVE → ANALYSE scope → PLAN pipeline → ANNOUNCE plan to user
  → DISPATCH agents (parallel where independent, sequential where dependent)
  → COLLECT all reports → SYNTHESISE findings → RESOLVE conflicts
  → DECIDE: more work needed? → loop | user decision needed? → surface it | done? → sign off
  → TRIGGER @workspace-updater → COMPLETE
```

`@workspace-updater` runs automatically as the last step after significant work. It reviews the core docs (`CLAUDE.md`, `AGENTS.md`, and `README.md`) even when no edits are ultimately required.

**Parallel vs sequential — `@master` decides:**

> *"Add authentication to the API"*
> → **Parallel:** `@architect` + `@researcher` (no dependency between them)
> → **Then sequential:** `@senior-developer` (needs both outputs)
> → **Then parallel:** `@qa-engineer` + `@security-auditor` (both review independently)
> → **Then sequential:** `@risk-officer` → `@workspace-updater`

> *"Plan and publish next week's newsletter"*
> → **Sequential:** `@backlog-curator` → `@topic-researcher`
> → **Then parallel:** `@content-planner` + `@source-verifier`
> → **Human approval gate** → `@content-writer`
> → **Then parallel:** `@editorial-reviewer` + `@tone-calibrator` + `@source-verifier`
> → **Then sequential:** `@privacy-reviewer` → `@delivery-orchestrator` → `@workspace-updater`

**See full workflow diagrams** with all collaboration patterns (parallel stages, gated reviews, feedback loops, dual-track launches) in [`docs/AGENT_WORKFLOWS.md`](docs/AGENT_WORKFLOWS.md).

---

## The Full Team (30 Agents)

### Core Engineering

| Agent | Role |
|---|---|
| `@master` | **Superagent & orchestrator** — default entry point for every session |
| `@senior-developer` | Clean, production-ready implementation |
| `@architect` | System design and technical decisions |
| `@debugger` | Deep debugging and root-cause analysis |
| `@researcher` | Technology research and best practices |
| `@qa-engineer` | Test plans, coverage, edge cases |
| `@security-auditor` | Vulnerability scanning and hardening |
| `@performance-engineer` | Profiling and optimisation |
| `@workspace-updater` | Reviews and updates `CLAUDE.md`, `AGENTS.md`, and `README.md` after every significant task |

### Content and Publishing

| Agent | Role | Model |
|---|---|---|
| `@topic-researcher` | Finds fresh, source-backed topics for any content workflow | sonnet |
| `@content-planner` | Builds structured multi-edition editorial plans | sonnet |
| `@content-writer` | Writes polished content for any publication format | **opus** |
| `@editorial-reviewer` | Final quality gate before any content is published | sonnet |
| `@source-verifier` | Verifies all claims are backed by strong, current sources | sonnet |
| `@tone-calibrator` | Ensures voice and complexity match the target audience | sonnet |
| `@feedback-synthesizer` | Turns audience responses into backlog topics and planning input | sonnet |
| `@backlog-curator` | Scores, prioritises, and prunes content or feature backlog | sonnet |

### Delivery and Operations

| Agent | Role | Model |
|---|---|---|
| `@delivery-orchestrator` | Renders, gate-checks, and delivers content via any configured channel | sonnet |
| `@delivery-monitor` | Reviews delivery reports and flags errors or anomalies | sonnet |
| `@privacy-reviewer` | Mandatory scan before any public release or repository push | sonnet |
| `@changelog-writer` | Generates versioned changelog entries after releases or publications | sonnet |
| `@ab-tester` | Designs and analyses A/B tests for headlines, CTAs, subject lines | sonnet |

### Advisory

| Agent | Role |
|---|---|
| `@product-owner` | User stories, acceptance criteria, scope decisions |
| `@project-manager` | Timelines, blockers, sprint planning |
| `@business-analyst` | Requirements, ROI, business cases |
| `@customer-advocate` | End-user and reader experience, UX empathy |
| `@devils-advocate` | Challenges assumptions before committing to a direction |
| `@risk-officer` | Risk, compliance, "what could go wrong" |
| `@judge` | Final evaluation — business and technical verdict |
| `@tech-writer` | Docs, README, architecture diagrams |

---

## Automatic Delegation Rules

These fire automatically — you don't need to ask:

- Secrets / auth / credentials touched → `@security-auditor` reviews first
- New feature or script → `@qa-engineer` writes the test plan
- Architectural decision → `@architect` weighs in
- Content ready to publish → `@editorial-reviewer` must pass it first
- Before any public release or push → `@privacy-reviewer` runs mandatory scan
- Before major release → `@risk-officer` final sign-off
- After any significant task → `@workspace-updater` runs last and reviews the core docs automatically

## Default Reporting

For significant work, `@master` should report:

- which agents were selected
- what each agent owned
- what happened during execution
- the synthesized outcome, conflicts, and blockers

This reporting is part of the default orchestration behavior, not an optional extra.

---

## Key Skills (Slash Commands)

`/code-review` `/fix-bug` `/implement-feature` `/write-tests` `/refactor`
`/security-audit` `/optimize-performance` `/write-docs` `/explain-code`
`/git-commit` `/create-pr` `/business-case` `/sprint-planning` `/research`
`/daily-standup` `/retrospective`

---

## Agent Groups at a Glance

The 30 agents split into four groups designed to cover any project type:

**Engineering** (9 agents) — builds and maintains software: architecture, implementation, testing, security, performance, debugging.

**Content & Publishing** (8 agents) — runs any periodic publication workflow: research → planning → writing → review → tone → sourcing → feedback → backlog.

**Delivery & Ops** (5 agents) — operates the release and distribution pipeline: delivery, monitoring, privacy, changelog, experimentation.

**Advisory** (8 agents) — provides strategic and decision-making support: product, project, business, UX, devil's advocate, risk, judgement, docs.

---

## Setup and Validation

- `./scripts/setup.sh` makes hook scripts executable and creates local config files from examples when needed
- `./scripts/doctor.sh` checks repo structure, JSON validity, hook permissions, and key documentation references
- `python3 -m unittest discover -s tests -v` runs the lightweight validation test suite for hooks and doctor behavior
- `docs/ARCHITECTURE.md` explains the product boundary and canonical sources
- `docs/PROJECT_CUSTOMIZATION.md` shows how to turn the generic kit into a real project briefing

## Customizing for Real Projects

When you copy this kit into a live repo, keep the shared `.claude/` layer mostly intact and make the repo-specific details explicit in `CLAUDE.md` and `AGENTS.md`.

Good project briefings usually add:

- real stack, commands, deployment flow, and environment rules
- route or page inventories for app repos
- domain-specific gotchas that prevent agent mistakes
- automatic delegation rules that reflect the actual codebase
- documentation sync targets for route catalogs, brief docs, or other registries

## Customisation

- Edit `CLAUDE.md` to configure the project name, stack, commands, and notes
- Use `docs/PROJECT_CUSTOMIZATION.md` when adapting the kit to a specific repository
- Add project-specific rules with `@.claude/rules/your-rule.md` in `CLAUDE.md`
- Create new agents in `.claude/agents/` — copy any existing file and update the frontmatter and instructions
- Add skills in `.claude/skills/your-skill/SKILL.md`
- Hook scripts auto-run — configure which fire in `settings.json`
- Agent memory grows automatically in `.claude/agent-memory/<agent-name>/MEMORY.md`

## Documentation

| File | What it covers |
|---|---|
| `CLAUDE.md` | Project or repo briefing for Claude-compatible tools |
| `AGENTS.md` | Compatibility briefing for tools that consume AGENTS.md |
| `README.md` | Kit overview, agent roster, orchestration model |
| `docs/ARCHITECTURE.md` | Product boundary, canonical sources, maintenance priorities |
| `docs/PROJECT_CUSTOMIZATION.md` | How to adapt the generic kit to a concrete repo |
| `docs/AGENT_WORKFLOWS.md` | Detailed workflow diagrams with parallel/sequential/gated patterns |

`README.md`, `CLAUDE.md`, and `AGENTS.md` must stay in sync. Update them together whenever the agent roster, workflow, commands, or project structure changes. `@workspace-updater` handles this automatically after major tasks — or call it explicitly after manual changes.
