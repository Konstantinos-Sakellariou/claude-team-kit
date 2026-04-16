# Git / GitHub Team

## Purpose

Default team for version-control hygiene, repository safety review, pull-request readiness, release preparation, and public-disclosure checks around Git and GitHub workflows.

## Lead

- `@github-safety-guard` for commit, push, PR, and repository-safety work
- `@risk-officer` for higher-risk release or go/no-go decisions

## Supporting Agents

- `@privacy-reviewer`
- `@code-reviewer`
- `@pr-operator`
- `@production-readiness-reviewer`
- `@changelog-writer`
- `@workspace-updater`
- `@tech-writer`
- `@project-manager`

## Typical Triggers

- commit readiness
- push readiness
- pull request preparation or creation
- release candidate review
- release-governance check
- git hygiene or branch sync prompts
- public/private disclosure review for outgoing repo changes

## Default Flow

- inspect the outgoing changes and workflow context
- run safety and privacy review before irreversible Git actions
- run code review before code-affecting Git actions are treated as ready
- run PR packaging when a pull request is being prepared
- run production-readiness review for release-heavy or operationally risky changes
- prepare changelog, PR narrative, or release notes when relevant
- produce a visible ready / not-ready release-governance summary when the path is release-heavy
- surface advisory or go/no-go guidance to the user
- update core docs when workflow or release conventions changed

## Required Gates

- `@github-safety-guard` before commit, push, or PR flows
- `@code-reviewer` before code-affecting commit, push, or PR flows
- `@privacy-reviewer` before public or disclosure-sensitive repo actions
- `@production-readiness-reviewer` before merge-critical or release-heavy paths
- `@risk-officer` before high-risk release paths
