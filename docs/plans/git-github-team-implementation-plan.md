# Git And GitHub Team Implementation Plan

## Idea Summary

Create a strong Git and GitHub team so `@master` can route version-control, branch hygiene, pull request workflows, sync checks, release prep, and repository safety through one reusable collaboration unit instead of scattered one-off rules.

## Artifact Decision

- Type: `docs/plans/`
- Status: Proposed
- Approval: Approved by user on 2026-04-14
- Backlog Link: `BL-017`
- Intended Assignee: `Unassigned`

## Goal

Define a first-class Git/GitHub team that helps the kit behave more predictably around:
- branch and sync discipline
- commit and PR preparation
- repository safety and privacy review
- release hygiene
- change-summary and changelog generation

## Why This Team Matters

Git and GitHub work is currently spread across:
- `@github-safety-guard`
- `@privacy-reviewer`
- `@risk-officer`
- `@changelog-writer`
- `@workspace-updater`
- generic `@master` routing

That works, but it is still more like a set of rules than a reusable workflow unit.

The team should make Git/GitHub operations:
- easier to trigger consistently
- easier to explain to users
- safer by default
- more extensible later if we add specialist roles

## Recommended First Version

Start with a team built mostly from existing agents.

### Proposed Team Name

`Git / GitHub Team`

### Recommended Lead

Primary lead:
- `@github-safety-guard`

Why:
- it already sits at the highest-risk point in the workflow
- it naturally owns the go/no-go decision surface before commit or push

Secondary operational support:
- `@privacy-reviewer`
- `@risk-officer`
- `@changelog-writer`
- `@workspace-updater`

### Optional Existing Support

- `@project-manager` for release sequencing or coordination-heavy PR batches
- `@tech-writer` when PR descriptions or release notes need stronger narrative quality

## What Belongs In This Team

The team should own workflows such as:
- pre-commit safety review
- pre-push review
- pull-request readiness
- release readiness
- changelog generation
- repository sync / branch hygiene prompts
- public/private disclosure checks around repo changes

It should not own:
- general code implementation
- architecture decisions
- normal debugging
- repo-specific deployment flows unless those are explicitly part of release governance

## Default Flow Shapes

### 1. Commit / Push Safety Flow

Lead:
- `@github-safety-guard`

Support:
- `@privacy-reviewer`

Optional:
- `@risk-officer` for high-risk pushes or releases

### 2. PR Preparation Flow

Lead:
- `@github-safety-guard`

Support:
- `@changelog-writer`
- `@tech-writer` when stronger PR narrative is needed

### 3. Release Flow

Lead:
- `@risk-officer`

Support:
- `@github-safety-guard`
- `@privacy-reviewer`
- `@changelog-writer`
- `@workspace-updater`

## Candidate Future Specialists

Do not add these immediately, but keep them in scope if the team proves valuable:

- `@git-operator`
  - branch hygiene, fetch/pull/rebase strategy, merge conflict preparation, diff review framing

- `@pr-operator`
  - PR body quality, issue linkage, reviewer checklist, release-note shaping

- `@release-coordinator`
  - sequencing, rollback readiness, release checklist ownership

First version should prove the team with the current roster before introducing these.

## `@master` Routing Rules

The team should activate when the user asks for or the workflow implies:
- commit
- push
- pull request
- release
- branch sync
- git hygiene
- repo disclosure / public safety review

Suggested routing language:
- pre-commit or pre-push work → `Git / GitHub Team`
- PR creation or PR readiness → `Git / GitHub Team`
- release candidate review → `Git / GitHub Team` plus `Delivery & Ops Team` if the workflow includes public release operations

## Reporting Contract

When the team is used, `@master` should report:
- selected team
- lead agent
- supporting agents
- whether the result is advisory or go/no-go
- any approval gates still required from the user

## Files To Update When Implemented

- `.claude/teams/`
- `.claude/agents/master.md`
- `README.md`
- `CLAUDE.md`
- `AGENTS.md`
- `docs/TEAMS.md`
- `docs/AGENT_WORKFLOWS.md`
- `scripts/doctor.sh`
- `tests/test_prompt_contracts.py`

## Implementation Phases

### Phase 1: Define The Team

1. create the team manifest
2. define lead, support, triggers, and required gates
3. document the team in core docs

### Phase 2: Wire `@master`

1. add request-type routing rules
2. add standard reporting shape
3. keep backward compatibility with direct safety routing

### Phase 3: Add Workflow Examples

1. commit/push safety
2. PR preparation
3. release readiness

### Phase 4: Reassess Specialist Gaps

Only after real usage:
- decide whether `@git-operator`, `@pr-operator`, or `@release-coordinator` are genuinely needed

## Risks

- making the team overlap too much with Delivery & Ops
- adding specialists too early
- turning normal git work into a heavy ceremony
- confusing advisory checks with blocking actions

## Success Criteria

- git and GitHub work routes more consistently
- users see a clearer safety/release workflow
- `@master` explains repo-safety operations more predictably
- the current safety stack stays intact while becoming easier to extend

## Recommended Next Step

Implement the team first with the current agent roster.

Only add new Git/GitHub specialists if repeated usage exposes a clear gap.
