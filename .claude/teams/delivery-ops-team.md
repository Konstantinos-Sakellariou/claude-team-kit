# Delivery & Ops Team

## Purpose

Default team for release, delivery, monitoring, privacy review, experimentation, and backlog persistence workflows.

## Lead

- `@delivery-orchestrator` for release and delivery work
- `@privacy-reviewer` or `@github-safety-guard` for high-risk public-output checks

## Supporting Agents

- `@delivery-monitor`
- `@privacy-reviewer`
- `@changelog-writer`
- `@ab-tester`
- `@backlog-updater`
- `@github-safety-guard`

## Typical Triggers

- release packaging
- repository push readiness
- public distribution
- monitoring and follow-up
- experiment rollout
- deferred-work capture

## Default Flow

- gate-check public or delivery-sensitive work
- deliver or release
- monitor outcomes
- write changelog or persist follow-up work

## Required Gates

- `@privacy-reviewer` before public release paths
- `@github-safety-guard` before commit/push/PR flows
