# Graph And Repo Intelligence

## Purpose

This kit may eventually benefit from a structural relationship layer across files, docs, plans, backlog items, ADRs, and workflows.

The goal is not to make graph tooling part of the core by default.

The goal is to define when an optional graph/repo-intelligence layer is worth using, what it should help with, and what should stay outside the current markdown-first core.

## What This Means

In this repo, graph/repo intelligence means an optional way to understand relationships such as:
- which docs, plans, and ADRs connect to a workflow
- which teams and agents relate to a capability
- which artifacts are likely affected by a change
- which files or decisions should be read together first

This is a relationship layer, not a replacement for grep, docs, or `@master`.

## Why It Might Add Value

An optional graph/repo-intelligence layer could help with:
- large-repo onboarding
- impact analysis
- context compression
- bootstrap and context-audit support
- future app-backed exploration surfaces

It becomes more useful as the kit gains:
- more teams and workflows
- more durable artifacts
- more local-versus-tracked boundaries
- more productization layers

## Why It Must Stay Optional

It should stay optional because:
- many repos will not need it
- the markdown-first core is still the right default
- graph tooling can add setup cost, indexing complexity, and failure modes
- the repo should not depend on a heavy intelligence substrate before the value is proven

## First-Principles Scope

Good first-scope questions:
- what artifacts connect to this capability?
- what should `@master` read first for this class of task?
- what docs or decisions are likely stale if this area changes?
- which backlog items, plans, or ADRs relate to the same operating surface?

Out of scope for the core:
- mandatory graph databases
- a required indexing daemon
- replacing existing docs with opaque generated graphs
- pretending this layer is necessary for small repos

## Connection To The Current Kit

This layer would sit on top of what already exists:
- `docs/DURABLE_MEMORY.md` for memory surfaces
- `docs/SYSTEM_REFERENCE.md` for the explicit feature map
- `docs/AGENT_WORKFLOWS.md` for collaboration patterns
- `docs/LOCAL_CONTEXT.md` for private context boundaries

Potential future connection points:
- `@master` for repo-understanding help
- `context-audit` for structural drift checks
- bootstrap for faster repo discovery
- future product/app surfaces for interactive exploration

## Suggested Rollout

### Phase 1: Relationship Model

Define the relationship questions the kit actually wants answered better than today.

Examples:
- doc-to-workflow relationships
- backlog-to-plan-to-ADR relationships
- team-to-capability relationships
- local-versus-tracked artifact boundaries

### Phase 2: Optional Integration Shape

Decide whether the best fit is:
- docs-only guidance
- a local optional helper
- a future product/app capability

### Phase 3: Small Experiment

Only then consider a small optional experiment, such as:
- a relationship index
- a graph export
- a local query helper
- an app-backed exploration surface

## Practical Recommendation

Use the current markdown-first artifact model by default.

Reach for graph/repo intelligence only when it clearly improves:
- repo understanding
- context efficiency
- impact analysis
- future productization

If those gains are not clear, keep it out of the core.
