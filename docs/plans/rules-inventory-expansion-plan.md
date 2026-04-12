# Rules Inventory Expansion Plan

## Idea Summary

Expand the rules inventory of `claude-team-kit` in a way that improves self-maintenance and downstream repo quality without turning the rules layer into generic prompt bloat.

## Artifact Decision

- Type: `docs/plans/`
- Status: Proposed
- Approval: Approved by user on 2026-04-11
- Backlog Link: `BL-032`
- Intended Assignee: `Unassigned`

## Goal

Add a small set of focused rule files that strengthen documentation governance, artifact decisions, and repo hygiene as reusable standing instructions.

## Current State

The repo already has:
- `code-quality.md`
- `python.md`
- `typescript.md`
- `security.md`
- `testing.md`
- `git-workflow.md`
- `performance.md`
- `api-design.md`
- `ml-workflow.md`

What is still missing is a clearer rules-layer treatment for:
- documentation governance
- artifact governance
- context-efficiency behavior
- tracked-vs-local repo hygiene

## Recommended New Rules

### `documentation-governance.md`

Should cover:
- when `README.md`, `CLAUDE.md`, and `AGENTS.md` must be aligned
- what belongs in always-loaded briefings vs linked docs
- when to summarize instead of expanding
- when to remove stale content

### `artifact-governance.md`

Should cover:
- when to use `BACKLOG.md`
- when to use `docs/BACKLOG.md`
- when to use `docs/plans/`
- when to use `docs/adr/`
- when to use `.claude/local-context/`

### `context-efficiency.md`

Should turn the current documentation guidance into reusable standing rules:
- read narrow first
- triage large inputs first
- prefer durable artifacts over repeated recap
- prefer lean briefing files
- avoid unnecessary tool overhead

### Optional Later: `repo-hygiene.md`

Should cover:
- tracked vs local-only file boundaries
- local context and secret handling
- optional `.agents/` cleanup direction
- generated/noisy file expectations

## Files To Update When Implemented

- `.claude/rules/`
- `CLAUDE.md`
- `AGENTS.md`
- maybe `README.md`
- `scripts/doctor.sh`
- `tests/test_prompt_contracts.py`

## Implementation Phases

### Phase 1: Add The Minimal New Rules

1. create `documentation-governance.md`
2. create `artifact-governance.md`
3. create `context-efficiency.md`

### Phase 2: Wire Them Into The Briefings

1. reference them from `CLAUDE.md`
2. reference them from `AGENTS.md`
3. keep wording compact and non-duplicative

### Phase 3: Validate The Contract

1. extend `doctor.sh`
2. extend prompt-contract tests
3. check count alignment in README if needed

## Risks

- duplicating what already exists in docs or prompts
- making briefings longer without improving actionability
- adding vague rules that nobody can follow consistently

## Success Criteria

- the rule set becomes more useful without becoming noisy
- artifact and documentation governance become explicit
- `@master` and downstream repos benefit from clearer standing instructions

## Recommended Next Step

Start with `documentation-governance.md` and `artifact-governance.md` first.

Those give the biggest benefit with the least conceptual sprawl.
