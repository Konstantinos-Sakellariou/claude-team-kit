# Teams

Teams are reusable orchestration bundles that `@master` can activate when a request matches a recurring collaboration pattern.

They are not a Claude-native feature and they do not replace individual agents. They are a modeling layer inside this kit that helps `@master` route work more consistently.

## What Teams Do

A team definition gives `@master`:

- a clear purpose
- a default lead agent
- a known supporting cast
- a typical execution flow
- any required gates before work is considered complete

That means `@master` can think in terms of a reusable unit such as "Engineering Team" or "AI/ML Team" instead of rebuilding the same multi-agent flow from scratch each time.

## Why Teams Help

Teams improve the workflow in a few practical ways:

- **More consistent orchestration:** the same class of request gets routed the same way more often.
- **Clearer ownership:** every team has a lead agent, so it is easier to understand who is driving the work.
- **Less prompt sprawl:** repeated collaboration patterns live in one place instead of being re-described ad hoc.
- **Better user visibility:** `@master` can report the selected team, lead, supporting agents, and flow in a more readable way.
- **Safer expansion:** new domain packs can plug into the same structure instead of adding one-off routing rows forever.
- **Backward compatibility:** single-agent routing still works; teams are only used when they genuinely help.

## Team Model

This kit currently defines twelve reusable teams:

| Team | Lead | Typical Scope |
|---|---|---|
| `Engineering Team` | `@senior-developer` or `@architect` | implementation, debugging, architecture, engineering review |
| `AI/ML Team` | `@data-scientist` or `@ml-engineer` | model framing, training, evaluation, rollout readiness |
| `Data Team` | `@data-engineer` or `@analytics-engineer` | pipelines, warehouse modeling, analytics, experimentation, data governance |
| `Supabase Team` | `@architect` or `@senior-developer` | auth, schema, migrations, RLS, storage, edge functions, rollout safety |
| `Design Team` | `@product-designer` or `@brand-designer` | product UX, UI layout, design systems, and brand-sensitive presentation work |
| `Executive Team` | `@product-owner`, `@business-analyst`, or `@vision-partner` | executive/org-model architecture, company-operating structure, portfolio-shaping, and public/private operating-boundary decisions |
| `Content & Publishing Team` | `@content-planner` or `@content-writer` | content planning, drafting, editorial validation |
| `Delivery & Ops Team` | `@delivery-orchestrator` or safety lead | release, delivery, monitoring, privacy, backlog persistence |
| `Git / GitHub Team` | `@github-safety-guard` or `@risk-officer` | commit, push, PR, release readiness, branch hygiene, repo-safety review |
| `Advisory Review Team` | `@product-owner`, `@business-analyst`, or `@idea-executor` | planning, product, business, risk, strategic-fit review, and decision support |
| `Product Discovery Team` | `@product-owner` or `@vision-partner` | app/website idea shaping, MVP reduction, backlog/roadmap framing, and deciding what should not be built yet |
| `Product Launch Team` | `@product-owner` or `@delivery-orchestrator` | cross-functional app/website launch work spanning UX, implementation, quality, deployment, and follow-up |

The canonical team manifests live in `.claude/teams/`.

## Operating Rules

- `@master` decides whether a request is best handled by a team, a single agent, or a combination of teams.
- Teams are visible in the report, but the actual agents used must still be named.
- Teams can be combined when needed, for example `Engineering Team` plus `Advisory Review Team`, or `Git / GitHub Team` plus `Delivery & Ops Team` for release-heavy workflows.
- Final synthesis always stays with `@master`.

## Supabase Team Notes

The `Supabase Team` exists because Supabase work is rarely just "database work."

It usually combines:
- schema and migrations
- auth and session behavior
- row-level security
- storage access
- edge functions or backend integration
- rollout and release risk

Default expectation for meaningful Supabase flows:
- `@architect` or `@senior-developer`
- `@security-auditor`
- `@qa-engineer`
- `@code-reviewer`

Add when needed:
- `@production-readiness-reviewer`
- `@risk-officer`
- `@debugger`
- `@performance-engineer`

## Data Team Notes

The `Data Team` exists because data work is often neither generic engineering nor generic AI/ML.

It usually combines:
- ingestion and pipeline reliability
- warehouse or mart modeling
- metrics and semantic definitions
- KPI or cohort analysis
- experiment interpretation
- quality, lineage, access, and governance review

Default expectation for meaningful data-team flows:
- `@data-engineer` or `@analytics-engineer`
- `@data-governance-reviewer`

Add when needed:
- `@data-analyst`
- `@experiment-analyst`
- `@qa-engineer`
- `@security-auditor`

## Design Team Notes

The `Design Team` exists because design-heavy work is not just product strategy and not yet implementation.

It usually combines:
- user flow and information architecture
- app or dashboard layout direction
- visual hierarchy and interface polish
- reusable component or token consistency
- brand-sensitive presentation surfaces such as heroes, marketing sections, and README visuals

Default expectation for meaningful design-team flows:
- `@product-designer` or `@brand-designer`
- `@ui-designer`

Add when needed:
- `@design-systems-architect`
- `@customer-advocate`
- `@product-owner`
- `@tech-writer`

## Executive Team Notes

The `Executive Team` exists because some questions are bigger than product scope but still smaller than "invent a whole company in chat."

It usually combines:
- executive or function-team boundaries
- company-operating structure
- public reusable kit architecture versus private product incubation
- sequencing and leverage trade-offs across horizons
- ownership and escalation clarity before more workflow layers are added

Default expectation for meaningful executive-team flows:
- `@product-owner`, `@business-analyst`, or `@vision-partner`
- `@strategy-reviewer`

Add when needed:
- `@project-manager`
- `@risk-officer`
- `@session-budget-estimator`
- `@idea-executor`
- `@tech-writer`

## Git / GitHub Team Notes

The `Git / GitHub Team` is intentionally stricter than most teams.

Its goal is not just routing convenience. It is a visible quality gate for code that is about to become part of repo history or a reviewer-facing PR.

Default expectation for code-affecting GitHub flows:
- `@github-safety-guard`
- `@code-reviewer`
- `@qa-engineer`

Add when needed:
- `@security-auditor`
- `@production-readiness-reviewer`
- `@pr-operator`
- `@risk-officer`

## Advisory Review Team Notes

The `Advisory Review Team` is where idea quality, strategy fit, sequencing quality, and collaborative next-move generation come together.

Add `@vision-partner` when the question is:
- what we should do next
- which directions are strongest before critique starts
- how backlog, roadmap, and vision should connect more coherently
- where current repo capabilities suggest a stronger adjacent move

Use it for:
- backlog shaping
- roadmap trade-offs
- prioritization and scope pushback
- idea-to-plan work that still needs pressure-testing

Add `@strategy-reviewer` when the question is:
- whether something fits the vision or roadmap strongly enough
- whether a new addition adds more scope than leverage
- whether the repo should push back instead of saying yes too quickly

Add `@session-budget-estimator` when the question is not only "is this valuable?" but also:
- what fits in one realistic Claude/Codex session
- whether reset limits make the item too large right now
- whether the work should be split before execution starts

## Product Discovery Team Notes

The `Product Discovery Team` exists because "I have an idea for an app or website" is not yet an engineering request.

It usually combines:
- product framing
- audience and problem clarification
- MVP reduction
- scope pushback
- backlog and roadmap shaping
- deciding what is necessary now versus later

Default expectation for meaningful discovery-team flows:
- `@product-owner` or `@vision-partner`
- `@business-analyst`
- `@product-designer`

Add when needed:
- `@customer-advocate`
- `@idea-executor`
- `@strategy-reviewer`
- `@session-budget-estimator`

## Product Launch Team Notes

The `Product Launch Team` exists because shipping an app or website cleanly is often broader than either pure engineering or pure delivery.

It usually combines:
- product-surface scope control
- cross-functional implementation coordination
- UX and design boundary checks
- launch-readiness gates
- deployment follow-up
- analytics or monitoring awareness

Default expectation for meaningful product-launch flows:
- `@product-owner` or `@delivery-orchestrator`
- `@product-designer`
- `@senior-developer`

Add when needed:
- `@architect`
- `@qa-engineer`
- `@privacy-reviewer`
- `@github-safety-guard`
- `@analytics-engineer`
- `@delivery-monitor`

## What We Still Do Not Need

To keep the shared kit reusable, we should resist adding every startup function as a first-class team.

Not needed as core shared teams right now:
- separate growth-only team
- separate marketing-only team
- separate investor-only team
- separate sales-only team
- separate frontend-only team

Those are better handled through:
- combinations of existing teams
- downstream product-specific overlays
- future domain packs only when the pattern becomes clearly reusable

## Customization Guidance

When adapting this kit to a real project:

- keep the shared team definitions generic when possible
- add project-specific team triggers in `CLAUDE.md` or `AGENTS.md`
- only introduce new teams when the collaboration pattern clearly repeats
- avoid creating teams that are really just a single specialist with a new label
