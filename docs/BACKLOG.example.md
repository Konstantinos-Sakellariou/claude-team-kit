# Public Backlog Template

Use this file as the starter for a tracked public backlog at `docs/BACKLOG.md`.

Keep this version safe for git history:
- no local machine paths
- no secrets or private tokens
- no confidential company notes
- no personal-only scratch context

If you need private planning detail instead, use the local ignored `BACKLOG.md` created from the root `BACKLOG.example.md`.

Use [`VISION.example.md`](VISION.example.md) as the public model for what a vision doc should capture.
If local `docs/VISION.md` exists, use that as the real shaping filter.
A good backlog row should explain not only what the idea is, but why it deserves to move the tracked project forward.
When local `docs/ROADMAP.md` exists, align `Target Phase / When` with it.
Otherwise use [`ROADMAP.example.md`](ROADMAP.example.md) as the structure reference.
When session limits or reset pressure matter, use `@session-budget-estimator` to decide whether an item should stay whole, be split, or be sequenced later.

## Status Guide

- `Proposed`: captured but not yet shaped
- `Planned`: understood well enough to execute later
- `In Progress`: actively being worked on
- `Blocked`: waiting on a dependency or decision
- `Done`: implemented
- `Dropped`: intentionally not pursuing

## Priority Guide

- `P0`: urgent or blocking
- `P1`: high-value next work
- `P2`: useful but not immediate
- `P3`: speculative or low-priority

## Entries

| ID | Idea | Description | Where To Use | How To Use / Create | Trigger / Source | Priority | Status | Assigned | Artifact / Plan | Target Phase / When | Owner / Agents | Dependencies | Validation | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| BL-001 | Example public backlog item | Replace this row in `docs/BACKLOG.md` with a real public-safe backlog item and explain why it supports the tracked project direction. | Example workflow | Describe how it would be implemented or adopted. | Template starter | P3 | Proposed | Unassigned | — | Match local `docs/ROADMAP.md` or use `TBD` | `@backlog-updater` | None | Define success checks here. | Keep entries safe for tracked history and use Notes to capture vision and roadmap alignment when helpful. |
