# Briefing Trim Plan

## Goal

Keep the always-loaded briefing surface lean without losing important guidance.

The main targets are:
- `CLAUDE.md`
- `AGENTS.md`
- the top-level overview sections of `README.md`

This plan exists because those files are loaded or consulted often, and the kit is now rich enough that drift, repetition, and visual mismatch can quietly increase token cost and reduce clarity.

## Why This Matters

Lean briefings help in three ways:
- they reduce context cost in tools that load them frequently
- they make the repo easier for humans to scan and trust
- they push deep detail into the right place instead of letting the hot-path docs become a wall of policy text

## Immediate Scope

The first trim pass should do four things:

1. Reduce repeated wording across `CLAUDE.md` and `AGENTS.md`.
2. Keep only high-signal summaries in always-loaded files and move deeper detail into linked docs.
3. Make the main README Mermaid graph match the real top-level team model, including the `Git / GitHub Team`.
4. Preserve all important behavior by linking outward instead of silently deleting guidance.

## Lean Briefing Rules

Use these rules for every future edit to always-loaded briefings:

### 1. Keep summaries in the hot path

Always-loaded files should answer:
- what this repo is
- how to use it
- what the top-level workflows are
- where the canonical deeper docs live

They should not try to hold every workflow detail inline.

### 2. Move depth into linked docs

If a section needs more than a short summary plus one or two critical rules, move the rest into:
- `docs/ARCHITECTURE.md`
- `docs/BOOTSTRAP.md`
- `docs/TEAMS.md`
- `docs/AGENT_WORKFLOWS.md`
- `docs/LOCAL_CONTEXT.md`
- `docs/PROJECT_CUSTOMIZATION.md`
- other focused docs as needed

### 3. Avoid repeating the same policy in multiple files

When the same rule appears in `README.md`, `CLAUDE.md`, and `AGENTS.md`, keep:
- one canonical longer version
- one short summary elsewhere
- a link back to the canonical source

### 4. Keep tables dense and descriptive

Prefer compact tables over repeated prose when summarizing:
- teams
- top-level agent groups
- artifact destinations
- top-level routing expectations

### 5. Keep visuals honest

When a top-level team is added or removed:
- update the main README Mermaid graph
- update the team counts
- update the available-teams table
- update any linked team docs

The graph should stay a true overview, not a detailed dump of every specialist.

## Concrete First Pass

### `CLAUDE.md`

- Compress repeated explanation around teams, local context, backlog, and reporting.
- Keep the core operating contract and rule references.
- Replace repeated long explanations with short summaries plus links to docs.

### `AGENTS.md`

- Keep compatibility-focused guidance.
- Mirror `CLAUDE.md` behaviorally, but avoid duplicating every long rationale paragraph.
- Trim repeated explanatory prose where the same idea already appears in `CLAUDE.md`.

### `README.md`

- Keep the public-facing narrative and trust signals.
- Update the main Mermaid graph so it includes the `Git / GitHub Team`.
- Keep the graph at the same overview level as the other top-level teams.
- Avoid turning the README into the deepest source of operational detail.

## Recommended Structure

For always-loaded files, prefer this pattern:

1. Short summary
2. Core rule or expectation
3. Link to the deeper doc

That keeps the hot path useful without making it heavy.

## Validation

The trim pass should be considered complete when:
- `doctor.sh` no longer warns that `CLAUDE.md` and `AGENTS.md` are getting too large, or the warnings are materially reduced
- prompt-contract tests still pass
- the main README graph includes the current top-level teams
- no important behavior was lost, only compressed or relocated

## Future Maintenance Checklist

Whenever a major capability is added:

1. Ask whether the change belongs in an always-loaded file or a linked doc.
2. Update counts, team tables, and top-level overview graphics together.
3. Trim repeated language before adding new prose.
4. Prefer a short summary plus a link over a second long explanation.
5. Run `./scripts/doctor.sh` and treat size warnings as real signal, not background noise.

## Suggested Owners

- `@master` for routing and top-level behavior summaries
- `@tech-writer` for concise restructuring
- `@workspace-updater` for final alignment
- `@customer-advocate` for scanability and readability checks

## Recommendation

Do a short focused trim immediately after the current Git / GitHub quality-gate round, before adding more top-level capability.

That timing gives the repo a chance to absorb the new team cleanly instead of letting every new feature make the hot-path docs heavier.
