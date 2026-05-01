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
- `docs/SELF_UPGRADE.md` for the maintainer playbook on evolving the kit safely
- `docs/STARTER_PACKS.md` for optional project-shape overlays
- `docs/SOLUTION_PACKS.md` for the optional startup-stack and product-foundation pack contract
- `docs/DESIGN_PACKS.md` for the optional design-pack and `DESIGN.md` workflow contract
- `docs/APP_SURFACE_AND_MCP.md` for the future product-surface boundary and MCP-connected systems model
- `docs/ARTIFACTS.md` for the optional Artifacts companion-layer stance
- `docs/AGENT_SDK_USER_INPUT.md` for the optional future Agent SDK user-input compatibility layer
- `docs/CROSS_TOOL_PORTABILITY.md` for the optional cross-tool portability and adapter-boundary model
- `docs/PORTABILITY_AND_INTELLIGENCE_OVERVIEW.md` for the high-level explanation of how the recent canonical-surface, portability, and graph-boundary changes fit together
- `docs/CODE_INTELLIGENCE_INTEGRATION.md` for the optional code-intelligence integration boundary and decision table
- `docs/CODE_REVIEW_GRAPH_ADAPTER_EXAMPLE.md` for the first concrete optional code-intelligence adapter example
- `docs/OPTIONAL_DEPENDENCIES_AND_ADAPTERS.md` for the external dependency and adapter classification policy
- `docs/EXTERNAL_SKILL_REPOS.md` for the external skill-repo contract
- `docs/PROJECT_DNA_AND_STATE.md` for the optional project-DNA and persistent-state boundary
- `docs/WORKTREE_PARALLEL_EXECUTION.md` for the optional worktree-based parallel execution guidance
- `docs/PLAYBOOKS_AND_BATCH_WORKFLOWS.md` for the repeatable playbook and batch-workflow contract
- `docs/ANNOTATION_AWARE_CONTEXT_PROTOCOL.md` for the bounded annotation-aware protocol evaluation
- `docs/ONE_PAGER.md` for the high-signal nutshell explanation of the repo
- `docs/IDEA_TO_PRODUCTION.md` for the visible lifecycle path from idea to shipped app or website

## Operating Layers

| Layer | What It Does | Canonical Location | How To Use | Connected To |
|---|---|---|---|---|
| Orchestrator | Top-level intake, routing, synthesis, approvals, sign-off | `.claude/agents/master.md` | Talk to `@master` first for every request | teams, agents, backlog, plans, ADRs, local context |
| Teams | Reusable multi-agent collaboration bundles | `.claude/teams/` | Let `@master` activate them for recurring workflows | agents, workflows, quality gates |
| Commands | Thin workflow entrypoints for repeated flows | `.claude/commands/` | Let users trigger known workflows explicitly while `@master` still orchestrates | teams, skills, agents, artifacts |
| Agents | Specialist roles that do the work | `.claude/agents/` | Trigger through `@master` | teams, rules, memory |
| Skills | Repeatable procedures for stable workflows | `.claude/skills/` | Use directly when the workflow is clearly procedural | agents, hooks, docs |
| Rules | Standing behavioral and governance constraints | `.claude/rules/` | Referenced by core briefings and prompts | agents, docs, doctor |
| Hooks | Lightweight automation and hygiene reinforcement | `.claude/hooks/` | Fire through workspace settings | rules, doctor, tests |
| Memory | Persistent per-agent memory | `.claude/agent-memory/` | Read and update through the agent lifecycle | agents, local context |
| Local Context | Private local-only company or strategy context | `.claude/local-context/` | Use for sensitive notes that should not be tracked | master, backlog, planning |
| Durable Memory Model | Cross-layer continuity architecture | `docs/DURABLE_MEMORY.md` | Use to understand how agent memory, backlog, plans, ADRs, and local context fit together | agent memory, backlog, ADRs, local context, handoff |
| Graph / Repo Intelligence | Optional relationship layer across repo artifacts | `docs/GRAPH_INTELLIGENCE.md` | Use to understand the optional graph/repo-intelligence boundary, when it is worth using, and how it stays distinct from broader code-intelligence work | durable memory, workflows, context-audit, future product surfaces, code-intelligence boundary |
| Code-Intelligence Integration | Optional implementation-aware search and retrieval boundary | `docs/CODE_INTELLIGENCE_INTEGRATION.md` | Use to understand when code-aware search, symbols, dependencies, and retrieval may justify an optional integration path without changing the shared core | graph intelligence, context efficiency, future app surfaces, external tooling |
| Code-Review-Graph Adapter Example | Concrete example of a removable external code-intelligence adapter | `docs/CODE_REVIEW_GRAPH_ADAPTER_EXAMPLE.md` | Use to understand how one real tool can fit the code-intelligence boundary without becoming a required dependency | code intelligence, portability, context efficiency, advanced repos |
| Optional Dependencies And Adapters | Policy for classifying external repos and integrations | `docs/OPTIONAL_DEPENDENCIES_AND_ADAPTERS.md` | Use to decide whether an external repo should be a required dependency, optional adapter, packaging inspiration, or inspiration only | code intelligence, portability, skill distribution, future integrations |
| External Skill Repos | Contract for reusable external skill packs | `docs/EXTERNAL_SKILL_REPOS.md` | Use to decide when specialization belongs in an external skill repo rather than the shared core | skills, customization, portability, starter packs |
| Project DNA And State | Optional durable repo-identity and assumption artifact | `docs/PROJECT_DNA_AND_STATE.md` | Use to understand when a customized repo may need a compact identity-and-state artifact, and how it should differ from briefings, local context, backlog, roadmap, and handoff | durable memory, local context, customization, playbooks, handoff |
| Worktree Parallel Execution | Optional coordination guidance for safe parallel branch work | `docs/WORKTREE_PARALLEL_EXECUTION.md` | Use to understand when worktrees are worth recommending and how they fit the existing Git / GitHub quality gate | Git/GitHub team, command/workflow guidance, larger implementation arcs |
| Playbooks And Batch Workflows | Optional contract for durable repeatable workflow patterns | `docs/PLAYBOOKS_AND_BATCH_WORKFLOWS.md` | Use to understand how repeatable sequences should sit alongside commands, plans, backlog, and handoff without becoming a runtime layer | commands, handoff, workflow guidance, larger maintenance flows |
| Annotation-Aware Context Protocol | Bounded evaluation of lightweight codebase annotation conventions | `docs/ANNOTATION_AWARE_CONTEXT_PROTOCOL.md` | Use to understand whether mature repos should ever adopt a narrow annotation-aware coordination protocol, and what should block it | project DNA, code intelligence, durable memory, mature repos |
| App Surface And MCP Systems | Future product-surface and connector boundary | `docs/APP_SURFACE_AND_MCP.md` | Use to understand what should stay repo-native, what could become app-native later, and where MCP-connected systems fit safely | durable memory, graph intelligence, local context, future productization |
| Artifacts Companion Layer | Optional presentation and onboarding layer | `docs/ARTIFACTS.md` | Use to understand how Artifacts can help explain, demo, or package proof-friendly views of the kit without replacing tracked docs | onboarding, app surface, starter packs, system reference |
| Agent SDK User Input | Future structured-question and approval compatibility layer | `docs/AGENT_SDK_USER_INPUT.md` | Use to understand how future host-side user-input handling could improve bootstrap and approval flows without changing the current core boundary | app surface, bootstrap, approvals, future SDK hosts |
| Cross-Tool Portability | Optional host-adaptation and adapter-boundary model | `docs/CROSS_TOOL_PORTABILITY.md` | Use to understand how the shared core should adapt across different coding hosts without splitting the canonical source of truth | customization, commands, briefings, future adapters |
| Solution Packs | Optional stack-foundation layer for common product setups | `docs/SOLUTION_PACKS.md` | Use to understand how startup-stack and product-foundation packs should stay modular and composable | starter packs, customization, teams, future integration adapters |
| Solution Pack Library | Concrete reusable pack examples | `docs/solution-packs/` | Use when a repo wants a stronger operational foundation than a starter pack alone provides | solution packs, customization, domain teams |
| Design Packs | Optional visual and brand-foundation layer | `docs/DESIGN_PACKS.md` | Use to understand how reusable visual-system starting points and optional `DESIGN.md` artifacts should fit the kit | Design Team, customization, future design-pack library |
| Design Pack Library | Concrete reusable visual and brand starting points | `docs/design-packs/` | Use when a repo wants a stronger design baseline than a blank page or ad hoc direction provides | design packs, Design Team, customization |
| Backlog | Durable deferred-work registry | `BACKLOG.md` or `docs/BACKLOG.md` | Save ideas for later through `@backlog-updater` | plans, vision, local context |
| Roadmap | Optional local phased sequencing and milestone view, with a tracked template | `docs/ROADMAP.md` and `docs/ROADMAP.example.md` | Use for phase planning and roadmap-level priorities | vision, backlog, plans |
| Plans | Rich execution artifacts for approved work | `docs/plans/` and `.claude/local-context/plans/` | Save only with approval, defaulting to local for real next-step plans and using tracked plans only for public-safe examples or shareable references | backlog, idea-executor, local context |
| ADRs | Durable architecture and policy decisions | `docs/adr/` | Save only with approval | master, architect, tech-writer |
| Core Briefings | High-frequency summary docs | `README.md`, `CLAUDE.md`, `AGENTS.md` | Keep concise and link outward | everything |
| One-Pager | High-signal nutshell explanation for humans | `docs/ONE_PAGER.md` | Use when someone needs the repo explained in one quick pass | architecture, README, workspace updater |
| Idea To Production Guide | High-level lifecycle path from product idea to shipped surface | `docs/IDEA_TO_PRODUCTION.md` | Use when a repo needs a visible answer for how `@master` should guide app/website work from discovery to launch | teams, workflows, customization, launch planning |

## Canonical Boundary

The active implementation model is `.claude/`-first.

If a local `.agents/` folder exists in a checkout, treat it as legacy local compatibility or archival material rather than as a supported primary surface.

## Team Map

| Team | Lead | Typical Use | Main Supporting Roles | More Detail |
|---|---|---|---|---|
| Engineering Team | `@senior-developer` or `@architect` | features, debugging, architecture | qa, security, performance, debugger | `docs/TEAMS.md` |
| AI/ML Team | `@data-scientist` or `@ml-engineer` | model framing, training, evaluation, rollout | evaluator, mlops, research | `docs/TEAMS.md` |
| Data Team | `@data-engineer` or `@analytics-engineer` | pipelines, warehouse modeling, analytics, experimentation, governance | data analyst, experiment analyst, governance, QA, security | `docs/TEAMS.md` |
| Supabase Team | `@architect` or `@senior-developer` | auth, schema, migrations, RLS, storage, edge functions | security, QA, code review, production readiness | `docs/TEAMS.md` |
| Design Team | `@product-designer` or `@brand-designer` | product UX, UI layout, design systems, brand-sensitive presentation | UI designer, design-systems architect, customer advocate, product owner | `docs/TEAMS.md` |
| Executive Team | `@product-owner`, `@business-analyst`, or `@vision-partner` | executive/org-model architecture, company-operating structure, portfolio shaping, public/private operating boundaries | strategy review, project manager, risk, session-budget estimation, tech writer | `docs/TEAMS.md` |
| Content & Publishing Team | `@content-planner` or `@content-writer` | planning, drafting, editorial workflows | source, tone, review, feedback | `docs/TEAMS.md` |
| Delivery & Ops Team | `@delivery-orchestrator` or safety lead | release, delivery, monitoring, backlog persistence | privacy, changelog, experimentation | `docs/TEAMS.md` |
| Git / GitHub Team | `@github-safety-guard` or `@risk-officer` | commit, push, PR, release readiness | code review, PR packaging, production readiness | `docs/TEAMS.md` |
| Advisory Review Team | `@product-owner`, `@business-analyst`, `@idea-executor`, or `@vision-partner` | planning, prioritization, strategic validation, collaborative direction-shaping | customer, strategy review, judge, devil's advocate, session-budget estimation, tech writer | `docs/TEAMS.md` |
| Product Discovery Team | `@product-owner` or `@vision-partner` | early app/website/product shaping, MVP reduction, backlog/roadmap framing | business analyst, product designer, customer advocate, idea executor, strategy review | `docs/TEAMS.md` |
| Product Launch Team | `@product-owner` or `@delivery-orchestrator` | cross-functional app/website launch coordination from build through ship | product designer, senior developer, architect, QA, privacy, analytics, delivery monitor | `docs/TEAMS.md` |

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
| `@workspace-updater` | Final doc-impact gate and targeted documentation alignment step |

### AI/ML

| Agent | Role |
|---|---|
| `@data-scientist` | Problem framing, analysis, feature and baseline strategy |
| `@ml-engineer` | Training pipelines, packaging, reproducible implementation |
| `@model-evaluator` | Metrics, fairness, robustness, deployment-readiness gate |
| `@mlops-engineer` | Rollout, monitoring, lifecycle, incident and rollback planning |
| `@research-scientist` | Literature, benchmarks, frontier-method evaluation |

### Data

| Agent | Role |
|---|---|
| `@data-engineer` | Ingestion, pipelines, orchestration reliability, warehouse delivery |
| `@analytics-engineer` | Marts, semantic layer, metrics definitions, analytics-ready modeling |
| `@data-analyst` | KPI, trend, cohort, and exploratory decision support |
| `@experiment-analyst` | A/B testing, lift interpretation, experiment design quality |
| `@data-governance-reviewer` | Data trust, lineage, quality, access, and governance review |

### Design

| Agent | Role |
|---|---|
| `@product-designer` | UX flows, information architecture, onboarding, and product-surface direction |
| `@ui-designer` | Layout, hierarchy, spacing, and interface polish |
| `@brand-designer` | Brand language, heroes, marketing surfaces, and visual credibility |
| `@design-systems-architect` | Reusable UI patterns, tokens, and shared visual consistency |

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
| `@strategy-reviewer` | Vision fit, roadmap fit, leverage, timing, and strategic pushback |
| `@vision-partner` | Collaborative next-move generation and vision/roadmap/backlog connection |
| `@devils-advocate` | Challenge assumptions |
| `@session-budget-estimator` | Session-sized effort, model-mix, and reset-pressure estimation |
| `@risk-officer` | Release and operational risk review |
| `@judge` | Decision tiebreaking |
| `@tech-writer` | Documentation and narrative structure |
| `@idea-executor` | Idea-to-plan execution design |

## Model Defaults

The shared model stance is:
- `Haiku` for cheap summarization, classification, and low-risk condensation
- `Sonnet` for most implementation, maintenance, docs, and planning
- `Opus` for architecture, contested decisions, deep debugging, and high-stakes gates

Notable cheaper-by-default agents:
- `@backlog-curator`
- `@changelog-writer`
- `@feedback-synthesizer`
- `@delivery-monitor`

## Skills

Current skills live in `.claude/skills/`.

High-value examples:
- `context-audit`: audit briefing quality, drift, and artifact placement
- `triage-input`: compress noisy logs, diffs, dumps, or evidence and recommend the best narrow handoff
- `repo-cleanup`: classify copied-kit leftovers into keep/customize/delete once the repo is truly project-specific
- `code-review`, `fix-bug`, `write-tests`, `write-docs`, `research`, `create-pr`

Use a skill when:
- the task matches a stable repeatable workflow
- the output shape is predictable
- a procedural workflow is stronger than free-form reasoning alone

## Commands

Current command definitions live in `.claude/commands/`.

They are best for:
- onboarding-heavy flows
- approval-gated flows
- artifact-producing workflows
- repeated maintenance or safety workflows

Current command set:
- `/bootstrap-repo`
- `/customize-repo`
- `/save-backlog`
- `/plan-idea`
- `/write-adr`
- `/release-check`
- `/sync-docs`
- `/triage-input`
- `/context-audit`

Bootstrap can also expand into a company-building workflow when the repo is founder-shaped and the problem is not only technical setup but product and operating-model definition.

## Rules

Rules live in `.claude/rules/`.

Important governance rules:
- `documentation-governance.md`
- `repo-cleanup.md`
- `artifact-governance.md`
- `context-efficiency.md`
- `github-quality-gate.md`
- `release-governance.md`

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
- tracked-artifact warning

Hooks should reinforce hygiene, not replace judgment.

## Artifact Map

| Artifact | Use |
|---|---|
| `BACKLOG.md` | private local backlog |
| `docs/BACKLOG.md` | optional public tracked backlog |
| `docs/VISION.example.md` | tracked starter for a local vision brief |
| `docs/ROADMAP.example.md` | tracked starter for a local roadmap |
| `docs/ROADMAP.md` | optional local phased roadmap |
| `docs/plans/` | approved public-safe example plans and shareable implementation references |
| `.claude/local-context/plans/` | local private strategy and roadmap plans |
| `.claude/local-context/estimation-log.md` | local private estimate-versus-actual history and mode preference |
| `.claude/local-context/HANDOFF.md` | local private continuity artifact for unfinished sessions and tool/model handoff |
| `.claude/local-context/ACTIVITY.md` | optional local private activity trace for significant orchestration sessions |
| `.claude/local-context/proof-of-concept/` | local private POC or core-product incubation material that can inform `@master` without becoming tracked kit truth |
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
- maintainer upgrade path: `docs/SELF_UPGRADE.md`
- optional project-shape overlays: `docs/STARTER_PACKS.md`
- optional startup-stack foundations: `docs/SOLUTION_PACKS.md`
- optional visual and brand foundations: `docs/DESIGN_PACKS.md`
- future reusable design-pack library: `docs/design-packs/README.md`
- concrete reusable pack examples: `docs/solution-packs/README.md`
- optional RTK efficiency layer: `docs/RTK_INTEGRATION.md`
- bootstrap and initialization: `docs/BOOTSTRAP.md`
- company-building workflow model: `docs/BOOTSTRAP.md` and `docs/AGENT_WORKFLOWS.md`
- context efficiency: `docs/CONTEXT_EFFICIENCY.md`
- durable memory architecture: `docs/DURABLE_MEMORY.md`
- graph and repo intelligence: `docs/GRAPH_INTELLIGENCE.md`
- private local context: `docs/LOCAL_CONTEXT.md`
- team model: `docs/TEAMS.md`
- Supabase domain-pack reference: `docs/SUPABASE_REFERENCE.md`
- Supabase foundation pack: `docs/solution-packs/supabase-foundation.md`
- GitHub and CI/CD foundation pack: `docs/solution-packs/github-cicd-foundation.md`
- Vercel deployment foundation pack: `docs/solution-packs/vercel-foundation.md`
- design-domain reference: `docs/DESIGN_REFERENCE.md`
- design-pack contract: `docs/DESIGN_PACKS.md`
- workflow examples: `docs/AGENT_WORKFLOWS.md`
- repo adaptation: `docs/PROJECT_CUSTOMIZATION.md`

## Usage Pattern

The intended usage flow is:

1. Start with `@master`
2. Let `@master` pick agents or teams
3. Save durable work in the right artifact location
4. Use local context for private operating detail
5. Keep private POC or core-product incubation in local context unless the user explicitly promotes a safe summary
6. Let `@workspace-updater` keep the hot-path docs aligned through adaptive doc-impact checks, not automatic full rewrites
7. Keep the hot path lean and push detail into linked docs like this one
