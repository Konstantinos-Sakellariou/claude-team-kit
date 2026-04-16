# Release Governance

## Purpose

This doc explains how `claude-team-kit` treats release-heavy or merge-critical work.

The release-governance layer exists to make high-risk repo actions more repeatable and less dependent on memory.

Use it when a change is:
- going out publicly
- part of a release candidate
- operationally risky
- migration-heavy
- sensitive enough that a normal commit/push review is not sufficient

## How It Fits

The release-governance pack is not a separate orchestrator.

It strengthens the existing:
- `Git / GitHub Team`
- GitHub quality gate
- privacy and risk review flow
- changelog and release-note flow

## Default Release Path

The normal release-governance flow is:

1. `@github-safety-guard`
2. `@privacy-reviewer`
3. `@code-reviewer` when code changed
4. `@qa-engineer` when behavior changed
5. `@production-readiness-reviewer`
6. `@changelog-writer`
7. `@risk-officer`
8. `@workspace-updater` when release behavior or docs changed

## What The Pack Protects Against

This layer is meant to catch:
- accidental secrets or sensitive disclosures
- under-tested changes
- migration or rollback hazards
- missing release notes or changelog coverage
- release decisions made without a visible go / no-go summary

## Ready / Not Ready Language

The expected release summary should end in one of:
- `READY`
- `READY WITH NOTED RISK`
- `NOT READY`

That keeps the final release signal easy to scan.

## What Still Needs User Approval

Even with the governance pack:
- `@master` must still surface findings clearly
- the user still decides whether to proceed when a choice remains
- no release action should be treated as automatic

## Where To Look

- rule: `.claude/rules/release-governance.md`
- command: `.claude/commands/release-check.md`
- coordination layer: `.claude/teams/git-github-team.md`
- workflow example: `docs/AGENT_WORKFLOWS.md`
