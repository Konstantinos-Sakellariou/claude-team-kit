# Private Local Context

Some projects need sensitive operating context that helps agents work well but should not live in tracked repo docs.

Use `.claude/local-context/` for that layer.

This folder is local-only and should stay gitignored.

## What Belongs There

Good candidates:
- private startup or company context
- customer or stakeholder notes
- private proof-of-concept or core-product incubation notes
- pricing, fundraising, GTM, or investor framing
- unreleased roadmap details
- private phase plans or company-operating plans
- commercial, legal, or organizational constraints
- sensitive success metrics or internal operating assumptions

Keep tracked docs for safe operational truth.
Keep local context for private working truth.
Use [`docs/DURABLE_MEMORY.md`](docs/DURABLE_MEMORY.md) when you need the full cross-layer memory model.

## Suggested Files

The setup script can scaffold these starter files:
- `.claude/local-context/README.md`
- `.claude/local-context/project-private.md`
- `.claude/local-context/project-dna.md`
- `.claude/local-context/customers.md`
- `.claude/local-context/constraints.md`
- `.claude/local-context/HANDOFF.md`
- `.claude/local-context/ACTIVITY.md`

When a plan should stay private, keep it under:
- `.claude/local-context/plans/`

Examples:
- private roadmap execution notes
- company-building phase plans
- strategy-bearing horizon plans
- proof-of-concept offer shaping or product incubation work

Use only the files you actually need.

`project-dna.md` is the best fit when:
- the repo has durable identity or operating assumptions that are more stable than a handoff
- those assumptions are too sensitive or too fluid for tracked docs
- the repo would benefit from one compact identity/state artifact instead of rediscovering the same context repeatedly

See [`docs/PROJECT_DNA_AND_STATE.md`](docs/PROJECT_DNA_AND_STATE.md) for the optional project-DNA contract and how it differs from briefings, backlog, roadmap, and handoff.

`HANDOFF.md` is the best fit when:
- a substantial session is ending mid-stream
- another model or tool will likely pick up the work next
- the repo needs a compact local “where we left off” bridge without rewriting stable docs

Keep the handoff short, operational, and local-only.

`ACTIVITY.md` is the best fit when:
- the repo wants a compact local audit trail of significant orchestration sessions
- teams or agents changed durable artifacts and the user may later ask what happened
- the work is worth indexing, but not worth a full handoff or new tracked doc

Keep activity entries short:
- date and short session title
- request
- primary team and agents
- artifacts touched
- validation run
- decisions made
- next action

Do not use `ACTIVITY.md` as a transcript, metrics store, private customer notebook, or replacement for backlog, plans, ADRs, or `HANDOFF.md`.

## How `@master` Should Use It

`@master` should consult local context when work is:
- strategic or product-facing
- planning-heavy
- startup or business-sensitive
- customer-sensitive
- content or positioning work that needs private context

`@master` should not assume local context exists, and should continue normally if the folder is absent.

## Privacy Boundary

The local-context layer is not a shadow README.

Rules:
- do not copy local-context material into tracked files automatically
- do not commit `.claude/local-context/`
- if tracked docs would benefit from a private fact, ask the user before moving or summarizing it there
- if the repo is public, prefer keeping private context local unless the user explicitly approves disclosure

## Git Safety

`@github-safety-guard` should treat `.claude/local-context/` as sensitive by default.

If files from that folder are staged, or if tracked docs appear to repeat private local-context material, the safety review should flag that before any commit or push proceeds.

## Relationship To Bootstrap

During new-repo bootstrap, `@master` should ask whether the repo wants a private local context layer in addition to the core project briefing.

That lets a team establish two different context surfaces early:
- tracked repo context in `CLAUDE.md`, `AGENTS.md`, and `README.md`
- local-only sensitive context in `.claude/local-context/`

That same split is how `@master` should handle a public reusable kit alongside a private core-product direction:
- tracked docs describe reusable kit truth
- local context carries private product, POC, or company-operating detail unless the user explicitly approves promotion

The same rule applies to plans:
- public-safe example plans or intentionally shareable implementation references can live in `docs/plans/`
- private strategy or roadmap plans should stay in `.claude/local-context/plans/`
- when a plan reflects the repo's real likely-next work, prefer the local plan path unless the user explicitly wants it tracked
- substantial deferred work should usually stay compact in the backlog and put execution detail in a linked plan after approval

The same boundary must hold for any future app surface:
- the app may help surface or organize private local context
- it must not silently promote that context into tracked repo artifacts
- MCP-connected systems should inherit the same local-versus-tracked discipline rather than bypassing it
