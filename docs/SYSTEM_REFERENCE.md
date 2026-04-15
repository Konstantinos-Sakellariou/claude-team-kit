# System Reference

## Purpose

This document is the full feature and connection map for `claude-team-kit`.

Use it when you want the deeper picture of:
- what the repo contains
- how the parts connect
- where to go for more detail
- how to use each major layer without bloating the always-loaded briefings

Pair it with:
- `docs/VISION.example.md` for the tracked vision model
- `docs/ROADMAP.example.md` for the tracked roadmap model
- `docs/DOCUMENTATION_GOVERNANCE.md` for the rule that keeps this depth out of the hot path

## Operating Layers

| Layer | What It Does | Canonical Location | How To Use | Connected To |
|---|---|---|---|---|
| Orchestrator | Top-level intake, routing, synthesis, approvals, sign-off | `.claude/agents/master.md` | Talk to `@master` first for every request | teams, agents, backlog, plans, ADRs, local context |
| Teams | Reusable multi-agent collaboration bundles | `.claude/teams/` | Let `@master` activate them for recurring workflows | agents, workflows, quality gates |
| Agents | Specialist roles that do the work | `.claude/agents/` | Trigger through `@master` | teams, rules, memory |
| Skills | Repeatable procedures for stable workflows | `.claude/skills/` | Use directly when the workflow is clearly procedural | agents, hooks, docs |
| Rules | Standing behavioral and governance constraints | `.claude/rules/` | Referenced by core briefings and prompts | agents, docs, doctor |
| Hooks | Lightweight automation and hygiene reinforcement | `.claude/hooks/` | Fire through workspace settings | rules, doctor, tests |
| Memory | Persistent per-agent memory | `.claude/agent-memory/` | Read and update through the agent lifecycle | agents, local context |
| Local Context | Private local-only company or strategy context | `.claude/local-context/` | Use for sensitive notes that should not be tracked | master, backlog, planning |
| Backlog | Durable deferred-work registry | `BACKLOG.md` or `docs/BACKLOG.md` | Save ideas for later through `@backlog-updater` | plans, vision, local context |
| Roadmap | Optional local phased sequencing and milestone view, with a tracked template | `docs/ROADMAP.md` and `docs/ROADMAP.example.md` | Use for phase planning and roadmap-level priorities | vision, backlog, plans |
| Plans | Rich execution artifacts for approved work | `docs/plans/` and `.claude/local-context/plans/` | Save only with approval, choosing tracked vs local by privacy | backlog, idea-executor, local context |
| ADRs | Durable architecture and policy decisions | `docs/adr/` | Save only with approval | master, architect, tech-writer |
| Core Briefings | High-frequency summary docs | `README.md`, `CLAUDE.md`, `AGENTS.md` | Keep concise and link outward | everything |

## Team Map

| Team | Lead | Typical Use | Main Supporting Roles | More Detail |
|---|---|---|---|---|
| Engineering Team | `@senior-developer` or `@architect` | features, debugging, architecture | qa, security, performance, debugger | `docs/TEAMS.md` |
| AI/ML Team | `@data-scientist` or `@ml-engineer` | model framing, training, evaluation, rollout | evaluator, mlops, research | `docs/TEAMS.md` |
| Content & Publishing Team | `@content-planner` or `@content-writer` | planning, drafting, editorial workflows | source, tone, review, feedback | `docs/TEAMS.md` |
| Delivery & Ops Team | `@delivery-orchestrator` or safety lead | release, delivery, monitoring, backlog persistence | privacy, changelog, experimentation | `docs/TEAMS.md` |
| Git / GitHub Team | `@github-safety-guard` or `@risk-officer` | commit, push, PR, release readiness | code review, PR packaging, production readiness | `docs/TEAMS.md` |
| Advisory Review Team | `@product-owner`, `@business-analyst`, or `@idea-executor` | planning, prioritization, strategic validation | customer, judge, devil's advocate, tech writer | `docs/TEAMS.md` |

## Agent Inventory

### Core Engineering

| Agent | Role |
|---|---|
| `@master` | Top-level orchestrator and mandatory entry point |
| `@senior-developer` | Clean, production-ready implementation |
| `@architect` | System design and structural decisions |
| `@debugger` | Root-cause analysis and failure tracing |
| `@researcher` | Technology and implementation research |
| `@qa-engineer` | Test planning, coverage, and edge cases |
| `@security-auditor` | Security review and hardening |
| `@github-safety-guard` | Pre-commit/pre-push disclosure and safety gate |
| `@code-reviewer` | Production-grade code review and standards gate |
| `@pr-operator` | Pull-request readiness and reviewer-facing packaging |
| `@production-readiness-reviewer` | Merge/release-readiness for config, rollout, and operational safety |
| `@performance-engineer` | Profiling and performance optimization |
| `@workspace-updater` | Final documentation alignment step |

### AI/ML

| Agent | Role |
|---|---|
| `@data-scientist` | Problem framing, analysis, feature and baseline strategy |
| `@ml-engineer` | Training pipelines, packaging, reproducible implementation |
| `@model-evaluator` | Metrics, fairness, robustness, deployment-readiness gate |
| `@mlops-engineer` | Rollout, monitoring, lifecycle, incident and rollback planning |
| `@research-scientist` | Literature, benchmarks, frontier-method evaluation |

### Content & Publishing

| Agent | Role |
|---|---|
| `@topic-researcher` | Fresh, source-backed topic discovery |
| `@content-planner` | Editorial planning and structure |
| `@content-writer` | Final written content |
| `@editorial-reviewer` | Publishing-quality editorial gate |
| `@source-verifier` | Source and claim verification |
| `@tone-calibrator` | Voice and audience-fit review |
| `@feedback-synthesizer` | Convert feedback into future planning input |
| `@backlog-curator` | Score and prune content/product backlog ideas |

### Delivery & Operations

| Agent | Role |
|---|---|
| `@delivery-orchestrator` | Delivery execution and gate checks |
| `@delivery-monitor` | Monitor outcomes and anomalies |
| `@privacy-reviewer` | Public-release privacy scan |
| `@changelog-writer` | Versioned changelog updates |
| `@ab-tester` | Experiment design and analysis |
| `@backlog-updater` | Persistent backlog management and linked plan updates |

### Advisory

| Agent | Role |
|---|---|
| `@product-owner` | Scope, prioritization, acceptance shape |
| `@project-manager` | Coordination, timing, execution tracking |
| `@business-analyst` | Requirements, ROI, business framing |
| `@customer-advocate` | User and reader experience |
| `@devils-advocate` | Challenge assumptions |
| `@risk-officer` | Release and operational risk review |
| `@judge` | Decision tiebreaking |
| `@tech-writer` | Documentation and narrative structure |
| `@idea-executor` | Idea-to-plan execution design |

## Skills

Current skills live in `.claude/skills/`.

High-value examples:
- `context-audit`: audit briefing quality, drift, and artifact placement
- `triage-input`: compress noisy logs, diffs, dumps, or evidence
- `repo-cleanup`: classify copied-kit leftovers into keep/customize/delete once the repo is truly project-specific
- `code-review`, `fix-bug`, `write-tests`, `write-docs`, `research`, `create-pr`

Use a skill when:
- the task matches a stable repeatable workflow
- the output shape is predictable
- a procedural workflow is stronger than free-form reasoning alone

## Rules

Rules live in `.claude/rules/`.

Important governance rules:
- `documentation-governance.md`
- `repo-cleanup.md`
- `artifact-governance.md`
- `context-efficiency.md`
- `github-quality-gate.md`

Other rules cover:
- code quality
- Python
- TypeScript
- security
- testing
- git workflow
- performance
- API design
- AI/ML workflow

## Hooks

Hooks live in `.claude/hooks/`.

Important hooks include:
- formatting support
- secret blocking
- protected-file checks
- SQL safety checks
- doc-drift warning

Hooks should reinforce hygiene, not replace judgment.

## Artifact Map

| Artifact | Use |
|---|---|
| `BACKLOG.md` | private local backlog |
| `docs/BACKLOG.md` | optional public tracked backlog |
| `docs/VISION.example.md` | tracked starter for a local vision brief |
| `docs/ROADMAP.example.md` | tracked starter for a local roadmap |
| `docs/ROADMAP.md` | optional local phased roadmap |
| `docs/plans/` | approved public-safe execution plans |
| `.claude/local-context/plans/` | local private strategy and roadmap plans |
| `docs/adr/` | approved architecture/policy decisions |
| `.claude/local-context/` | private local context |
| `README.md` | public-facing summary |
| `CLAUDE.md` | Claude-compatible operational briefing |
| `AGENTS.md` | compatibility operational briefing |

## How To Navigate The Docs

Start here depending on the need:

- product direction model: `docs/VISION.example.md`
- phased sequencing model: `docs/ROADMAP.example.md`
- repo boundary and structure: `docs/ARCHITECTURE.md`
- documentation policy: `docs/DOCUMENTATION_GOVERNANCE.md`
- bootstrap and initialization: `docs/BOOTSTRAP.md`
- context efficiency: `docs/CONTEXT_EFFICIENCY.md`
- private local context: `docs/LOCAL_CONTEXT.md`
- team model: `docs/TEAMS.md`
- workflow examples: `docs/AGENT_WORKFLOWS.md`
- repo adaptation: `docs/PROJECT_CUSTOMIZATION.md`

## Usage Pattern

The intended usage flow is:

1. Start with `@master`
2. Let `@master` pick agents or teams
3. Save durable work in the right artifact location
4. Use local context for private operating detail
5. Let `@workspace-updater` keep the hot-path docs aligned
6. Keep the hot path lean and push detail into linked docs like this one
