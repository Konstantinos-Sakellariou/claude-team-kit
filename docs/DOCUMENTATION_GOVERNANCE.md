# Documentation Governance

## Goal

Keep the repo fully documented without letting the always-loaded briefings become bloated again.

The rule is not "write less documentation."
The rule is:

> write complete documentation, but distribute it intentionally and keep the hot path lean.

## Core Model

Use a hub-and-spoke structure:

- `README.md`, `CLAUDE.md`, and `AGENTS.md` are the hubs
- focused docs in `docs/` are the spokes

The most important linked spokes are:
- `docs/VISION.example.md` for the tracked vision model
- `docs/ROADMAP.example.md` for the tracked roadmap model
- `docs/SYSTEM_REFERENCE.md` for the full feature and connection map
- repo cleanup via the `repo-cleanup` skill once a copied repo becomes specific enough to prune template leftovers safely

The hubs should:
- summarize
- orient
- link
- state critical rules

The spokes should:
- explain in depth
- hold detailed inventories
- absorb growth safely

## Hot-Path Rules

`README.md`, `CLAUDE.md`, and `AGENTS.md` should contain:
- what this repo is
- how to use it
- the critical operating model
- where the deeper docs live

They should not try to hold every:
- agent detail
- workflow nuance
- feature explanation
- governance explanation
- extension idea

## Where Detail Belongs

- full feature and connection map → `docs/SYSTEM_REFERENCE.md`
- documentation policy → `docs/DOCUMENTATION_GOVERNANCE.md`
- public vision template → `docs/VISION.example.md`
- public roadmap template → `docs/ROADMAP.example.md`
- reusable team logic → `docs/TEAMS.md`
- workflow patterns and diagrams → `docs/AGENT_WORKFLOWS.md`
- repo boundary and structure → `docs/ARCHITECTURE.md`
- bootstrap and guided initialization → `docs/BOOTSTRAP.md`
- context quality and token discipline → `docs/CONTEXT_EFFICIENCY.md`
- private local context model → `docs/LOCAL_CONTEXT.md`
- adaptation to real repos → `docs/PROJECT_CUSTOMIZATION.md`

## Anti-Bloat Rules

Before adding new text to `README.md`, `CLAUDE.md`, or `AGENTS.md`, ask:

1. Is this truly hot-path information?
2. Can this be said in one to three lines plus a link?
3. Does a focused doc already exist for this?
4. Am I repeating something already documented elsewhere?

If the answer points away from the hub, put the detail in a focused doc instead.

## Linkback Rule

Every focused doc should be easy to find again from the hubs.

That means:
- when a new focused doc matters to normal repo use, link it from the core briefings
- when a core briefing trims a section, replace the depth with a short summary and a pointer
- avoid orphan docs that are technically present but practically undiscoverable
- make sure the strongest explanatory docs point back to one another when they are part of the same navigation path

## Update Checklist

When adding a major capability:

1. Decide whether it belongs in the hub or a focused doc
2. Add or update the focused doc when needed
3. Add a short pointer from the hubs
4. Keep counts, team summaries, and graphs aligned
5. Run `./scripts/doctor.sh`

## Enforcement

This repo reinforces documentation governance through:
- `.claude/rules/documentation-governance.md`
- `@workspace-updater`
- `warn-doc-drift.sh`
- `doctor.sh`
- prompt-contract tests

## Practical Standard

The repo should feel:
- fully documented
- easy to navigate
- resistant to drift
- resistant to hot-path bloat

That is the standard we want to keep from now on.
