# GitHub And CI/CD Foundation

## Purpose

This solution pack defines a strong starting foundation for repos that want GitHub and CI/CD to be part of the operating system from the beginning, not an afterthought.

It helps a repo start with:
- cleaner branch and PR hygiene
- clearer validation expectations
- safer release posture
- repeatable CI/CD conventions
- stronger reviewer-facing packaging

## Best Fit

This pack is a strong fit for:
- startup repos
- product repos that expect collaborative GitHub review
- consulting or client repos that need safer release discipline
- internal tools that still need trustworthy branch, PR, and deployment flow

## What This Pack Covers

- branch and PR hygiene expectations
- validation and release-governance expectations
- CI/CD workflow baseline
- reviewer-facing packaging expectations
- release-readiness and rollback posture
- customization rules for the copied repo

## What This Pack Does Not Cover

- one mandatory branching model for every team
- one universal GitHub Actions layout
- cloud-provider-specific deployment logic
- secrets or private tokens
- organization-specific compliance detail

Those still belong in the copied repo's own briefings and local operating context.

## Expected Repo Surface

A strong repo using this pack will usually have:

- clear test and validation commands
- a visible GitHub quality gate
- CI workflows under `.github/workflows/`
- PR and release expectations documented in repo briefings
- a changelog or release-note path when public change history matters

The pack should help a repo converge toward this shape, not assume every file already exists.

## Setup Checklist

When applying this pack to a real repo:

1. define the repo's main validation commands
2. clarify commit, push, and PR expectations
3. decide what CI workflows should exist first
4. define release-readiness and rollback expectations
5. clarify where changelog or release-note updates belong
6. wire the copied repo briefings to the real GitHub and CI/CD surface

## Branch And PR Guidance

This pack should help the copied repo clarify:
- what branch flow is expected
- when PRs are required
- how reviewer context should be prepared
- what makes a change "ready" versus "not ready"

It should encourage:
- explicit reviewer-facing context
- no silent push-to-main habits in repos that need review
- visible go/no-go posture for risk-heavy work

## CI/CD Guidance

This pack should encourage a copied repo to define:
- the minimum validation workflow
- what runs on PR versus merge versus release
- what counts as blocking
- how failures are surfaced and triaged

It should stay general enough to support different stacks while still pushing teams toward a real baseline instead of hand-wavy "we'll add CI later."

## Release And Deployment Guidance

This pack should reinforce:
- release-governance checks for risky paths
- changelog or release-note hygiene when appropriate
- explicit readiness language
- rollback awareness for operationally risky changes

This pack should not assume the deployment platform.
That is why Vercel or Cloudflare belong in separate deployment packs later.

## Workflow And Ownership

The primary owner for this pack is the `Git / GitHub Team`.

Expected flow:
1. `@master` recognizes repo, PR, release, or CI/CD-heavy work
2. `Git / GitHub Team` leads
3. validation, review, privacy, and release checks are applied as needed
4. the copied repo docs are updated with real repo-specific process details

## Quality Gates

Required by default:
- `@github-safety-guard`
- `@code-reviewer` for code-affecting changes
- `@qa-engineer` for behavior-changing changes

Required when risk is higher:
- `@privacy-reviewer`
- `@production-readiness-reviewer`
- `@risk-officer`

## MCP And Credentials Guidance

This pack should not assume MCP by default.

Prefer:
1. local git and CLI workflow first
2. GitHub-native configuration and repo files
3. MCP only when it clearly improves visibility or automation

Keep tokens, secrets, and org-specific automation details out of tracked public docs.

## What The Copied Repo Must Customize

At minimum, the copied repo should make these concrete in `CLAUDE.md`, `AGENTS.md`, or local context:
- real test and validation commands
- real CI workflow names and triggers
- actual PR and branch expectations
- real release and rollback rules
- what reviewer context is expected
- where changelog or release notes live

## Related Docs

- `docs/SOLUTION_PACKS.md`
- `docs/RELEASE_GOVERNANCE.md`
- `docs/PROJECT_CUSTOMIZATION.md`
- `docs/TEAMS.md`
