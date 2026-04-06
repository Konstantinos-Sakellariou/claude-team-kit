# Engineering Team

## Purpose

Default team for software implementation, debugging, architecture, review, and release-safety work.

## Lead

- `@senior-developer` for implementation-heavy work
- `@architect` for design-heavy work

## Supporting Agents

- `@qa-engineer`
- `@security-auditor`
- `@performance-engineer`
- `@debugger`
- `@researcher`
- `@risk-officer`
- `@github-safety-guard`

## Typical Triggers

- feature implementation
- debugging and remediation
- architecture changes
- code hardening or performance work
- pre-release engineering review

## Default Flow

- design/research in parallel when helpful
- implementation or remediation
- review and quality gates
- risk/release checks when needed

## Required Gates

- `@qa-engineer` for new features or scripts
- `@security-auditor` when auth, secrets, or exposed inputs are touched
- `@github-safety-guard` before commit/push/PR flows
