# Artifacts Companion Layer

## Purpose

This document defines how Claude Artifacts can fit `claude-team-kit` as an optional companion layer.

Artifacts can make the kit easier to understand, demo, and onboard into.
They should not replace the tracked repo as the source of truth.

## Core Position

Treat Artifacts as:
- optional
- companion-only
- presentation-first

Keep the repo:
- markdown-first
- tracked
- diffable
- public/private-boundary aware

## What Artifacts Are Good For Here

Artifacts are a strong fit for:
- interactive explainers
- visual maps
- guided selectors
- demo prototypes
- presentation-grade proof views
- onboarding-friendly views of complex repo structure

That makes them useful for:
- showing how the team system works
- helping users choose a starter pack or solution pack
- explaining the bootstrap flow visually
- packaging screenshots, flows, and before/after evidence into a cleaner explainer surface
- presenting the operating layers more clearly than static markdown alone

## What Artifacts Should Not Replace

Artifacts should not become the canonical home for:
- repo configuration
- tracked policy
- durable architecture records
- private strategy
- backlog truth
- roadmap truth
- local-only operating context

If an Artifact helps explain something durable, the durable source should still live in repo files.

## Best First Use Cases

The safest first uses are:

1. Interactive team map
- show teams, leads, supporting agents, and routing examples

2. Starter-pack or solution-pack chooser
- help users find the closest fit
- point them back to the right tracked docs

3. Bootstrap visual explainer
- show the guided initialization and company-building flow

4. System-reference visualizer
- present repo layers and connections more interactively than a long markdown page

5. Demo and proof companion
- present reusable screenshots, flow snapshots, and before/after evidence in a cleaner view
- keep the durable source material in repo files, then use Artifacts as the presentation layer

## Relationship To The App Surface

Artifacts and a future app surface are related, but not identical.

The intended progression is:
- tracked docs define the operating truth
- Artifacts help people explore or understand that truth
- a future app surface could later build on the same model more deeply

That means Artifacts are a good low-risk companion layer before any heavier product surface.

## Public Vs Local Boundary

Artifacts must follow the same boundary as the rest of the repo:

Tracked/public-safe:
- reusable explanations
- safe visualizations
- onboarding-friendly selectors
- generic demos

Local/private:
- current company strategy
- sensitive product plans
- private customer context
- unreleased operating detail

Do not use Artifacts as a side door for private material that should stay in `.claude/local-context/`.

## What To Avoid

Do not:
- treat an Artifact as the canonical documentation source
- duplicate tracked docs without a maintenance plan
- let an Artifact silently drift away from repo truth
- build core repo logic that depends on Artifact support to work
- move private local context into an Artifact just because it feels more presentable

## Recommended First Rollout

The best first rollout is intentionally small:

1. document the stance clearly
2. keep tracked docs canonical
3. choose one low-risk prototype direction later

Best prototype candidates:
- interactive team map
- starter-pack / solution-pack chooser

## Related Docs

- `docs/SYSTEM_REFERENCE.md`
- `docs/STARTER_PACKS.md`
- `docs/SOLUTION_PACKS.md`
- `docs/APP_SURFACE_AND_MCP.md`
- `docs/LOCAL_CONTEXT.md`
