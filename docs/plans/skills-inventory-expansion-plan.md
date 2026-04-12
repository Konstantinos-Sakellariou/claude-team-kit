# Skills Inventory Expansion Plan

## Idea Summary

Expand the skills inventory only where the workflow is repeatable, bounded, and worth encoding as a reusable procedure.

## Artifact Decision

- Type: `docs/plans/`
- Status: Proposed
- Approval: Approved by user on 2026-04-11
- Backlog Link: `BL-033`
- Intended Assignee: `Unassigned`

## Goal

Add a small number of new skills that improve repeatability for workspace-maintenance and triage tasks without duplicating the role of agents or teams.

## Current State

The repo already has strong coding and review skills such as:
- code review
- fix bug
- implement feature
- write tests
- write docs
- security audit
- research
- sprint planning

The most obvious gaps are repo-maintenance and input-triage workflows that are currently spread across docs and prompt guidance.

## Recommended New Skills

### `context-audit`

Purpose:
- inspect `README.md`, `CLAUDE.md`, `AGENTS.md`, and linked docs
- detect drift, bloat, missing context, and weak project briefings
- recommend focused improvements

Best fit:
- onboarding
- repo maintenance
- adapting the kit to a new project

### `triage-input`

Purpose:
- preprocess large logs, diffs, dumps, CSVs, JSON, or noisy evidence
- produce a smaller, high-signal summary for the next agent or team

Best fit:
- debugging
- review
- incident triage
- large-input analysis

### Optional Later: `workspace-governance`

Purpose:
- inspect artifact usage, public/private boundaries, and doc alignment
- review whether the workspace is following its own operating model

### Optional Later: `create-team-pack`

Purpose:
- scaffold a new domain team consistently
- define manifests, routing, docs updates, and validation work

## Files To Update When Implemented

- `.claude/skills/<skill>/SKILL.md`
- `README.md`
- maybe `CLAUDE.md` and `AGENTS.md`
- `scripts/doctor.sh`
- tests if we validate skill presence or references

## Implementation Phases

### Phase 1: Add `context-audit`

1. define its workflow
2. specify inputs and outputs
3. make sure it complements `@master` rather than replacing it

### Phase 2: Add `triage-input`

1. encode log/diff/data triage patterns
2. keep it narrow and output-focused
3. document where it hands off to specialists

### Phase 3: Evaluate Further Skills

1. only add `workspace-governance` or `create-team-pack` if repeated usage proves the need

## Risks

- turning skills into duplicate agent prompts
- adding too many low-value skills
- encoding workflows that are still too unstable

## Success Criteria

- the new skills are obviously reusable
- they save time and improve consistency
- they reduce prompt ambiguity for stable maintenance workflows

## Recommended Next Step

Start with `context-audit` and `triage-input` only.

Those are the clearest workflow gaps in the current skill inventory.
