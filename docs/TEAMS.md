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
- **Safer expansion:** future domain packs, such as a data team, can plug into the same structure instead of adding one-off routing rows forever.
- **Backward compatibility:** single-agent routing still works; teams are only used when they genuinely help.

## Team Model

This kit currently defines seven reusable teams:

| Team | Lead | Typical Scope |
|---|---|---|
| `Engineering Team` | `@senior-developer` or `@architect` | implementation, debugging, architecture, engineering review |
| `AI/ML Team` | `@data-scientist` or `@ml-engineer` | model framing, training, evaluation, rollout readiness |
| `Supabase Team` | `@architect` or `@senior-developer` | auth, schema, migrations, RLS, storage, edge functions, rollout safety |
| `Content & Publishing Team` | `@content-planner` or `@content-writer` | content planning, drafting, editorial validation |
| `Delivery & Ops Team` | `@delivery-orchestrator` or safety lead | release, delivery, monitoring, privacy, backlog persistence |
| `Git / GitHub Team` | `@github-safety-guard` or `@risk-officer` | commit, push, PR, release readiness, branch hygiene, repo-safety review |
| `Advisory Review Team` | `@product-owner`, `@business-analyst`, or `@idea-executor` | planning, product, business, risk, strategic-fit review, and decision support |

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

The `Advisory Review Team` is where idea quality, strategy fit, and sequencing quality come together.

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

## Customization Guidance

When adapting this kit to a real project:

- keep the shared team definitions generic when possible
- add project-specific team triggers in `CLAUDE.md` or `AGENTS.md`
- only introduce new teams when the collaboration pattern clearly repeats
- avoid creating teams that are really just a single specialist with a new label
