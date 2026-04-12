# Hooks Inventory Expansion Plan

## Idea Summary

Expand the hook inventory carefully so the repo gains useful safety or drift-reduction automation without becoming noisy, brittle, or frustrating.

## Artifact Decision

- Type: `docs/plans/`
- Status: Proposed
- Approval: Approved by user on 2026-04-11
- Backlog Link: `BL-034`
- Intended Assignee: `Unassigned`

## Goal

Add at most one or two hooks that provide real value for this workspace kit while keeping hook behavior lightweight and trustworthy.

## Current State

The repo already has:
- `auto-format.sh`
- `block-secrets.sh`
- `notify-on-complete.sh`
- `protect-files.sh`
- `validate-sql-query.sh`

That is a solid baseline.

The next hooks should therefore focus on repo-native pain points, not generic automation for its own sake.

## Best Candidate Hooks

### `warn-doc-drift.sh`

Purpose:
- detect suspicious cases where `README.md`, `CLAUDE.md`, or `AGENTS.md` changed in ways that may leave them out of sync

Preferred behavior:
- warn rather than block
- surface likely drift, not minor benign edits

### `warn-sensitive-surface.sh`

Purpose:
- warn if staged or edited paths touch sensitive or local-only surfaces unexpectedly
- examples:
  - `.claude/local-context/`
  - `.env`
  - `.mcp.local.json`
  - maybe future local/private paths

Preferred behavior:
- warn clearly
- avoid duplicating existing secret-blocking behavior too aggressively

## Hooks To Avoid For Now

- nagging reminder hooks
- broad token-usage hooks with brittle heuristics
- hooks that block normal documentation work
- hooks that depend on exact repo state in ways likely to break on real projects

## Files To Update When Implemented

- `.claude/hooks/`
- `.claude/settings.json` if hook registration changes
- `README.md`
- maybe `CLAUDE.md` and `AGENTS.md`
- `scripts/doctor.sh`
- `tests/test_hooks.py`

## Implementation Phases

### Phase 1: Design One Warning Hook

Choose the single most valuable hook:
- doc drift warning
or
- sensitive surface warning

### Phase 2: Implement And Test

1. add the hook
2. keep it warning-oriented
3. add tests for low false-positive behavior
4. update doctor if needed

### Phase 3: Reassess

Only add a second hook if the first one proves genuinely useful and low-friction.

## Risks

- false positives that train users to ignore the hook
- blocking behavior where warning behavior would be better
- growing the hook layer faster than the repo’s real needs

## Success Criteria

- any new hook catches a real repeated problem
- the hook is trustworthy and low-noise
- tests make the behavior stable

## Recommended Next Step

If this track is selected, start with a warning-only doc-drift hook.

That is the most repo-native and potentially valuable next hook for this workspace kit.
