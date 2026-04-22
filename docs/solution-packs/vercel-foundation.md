# Vercel Deployment Foundation

## Purpose

This solution pack defines a strong starting foundation for repos that want Vercel as the main deployment surface for:
- product apps
- landing pages
- SaaS frontends
- founder-built web products
- fast iteration with preview and production environments

It helps a repo reach a safer, clearer deploy path without treating Vercel as a full app template.

## Best Fit

This pack is a strong fit for:
- Next.js and similar web-product repos
- SaaS products with preview and production flow
- landing pages or product sites that still need disciplined release behavior
- startup repos that want a reliable deploy baseline early

## What This Pack Covers

- deployment and environment expectations
- preview versus production workflow
- domain handoff expectations
- release-safety and rollback posture
- integration boundaries with GitHub and app foundations
- customization rules for the copied repo

## What This Pack Does Not Cover

- one required framework for every repo
- cloud-agnostic deployment abstractions
- business-specific domain configuration
- real environment secrets
- provider billing or account setup details

Those still belong in the copied repo's own briefings and local context.

## Expected Repo Surface

A strong repo using this pack will usually have:
- clear build and validation commands
- explicit environment boundaries
- preview and production expectations
- domain or DNS handoff notes when relevant
- release-readiness expectations for risky deployment changes

The pack should help the repo converge toward this shape, not assume every file already exists already.

## Setup Checklist

When applying this pack to a real repo:

1. confirm the repo actually wants Vercel as the main deploy surface
2. define the real build and validation commands
3. define preview versus production expectations
4. clarify the environment-variable contract
5. define release and rollback expectations
6. note domain handoff or DNS responsibilities where relevant
7. wire the copied repo briefings to the real deployment surface

## Environment Guidance

The copied repo should document:
- which environments exist
- which variables are required where
- what differs between preview and production
- what is safe to describe publicly versus what stays local-only

Rules:
- never commit real secrets
- keep deployment credentials and account-specific data out of tracked public docs
- document only the safe shape of the environment contract publicly

## Preview And Production Workflow

This pack should make the repo clarify:
- when preview deployments are expected
- what should be validated before production
- what makes a deploy “safe enough” to proceed
- who owns the final go/no-go call for risky changes

It should encourage:
- explicit preview flow
- visible production-readiness posture
- no silent deploy assumptions for meaningful product changes

## Domain And DNS Guidance

If the repo has a custom domain or handoff-sensitive surface, the copied repo should clarify:
- who owns domain and DNS coordination
- what environment is attached to which domain
- whether domain changes are part of deployment work or a separate operational step

This pack should treat domain handoff as an operational concern, not only a configuration footnote.

## Release And Rollback Guidance

This pack should reinforce:
- release-governance checks for risky deploys
- production-readiness review when rollout risk matters
- rollback awareness for env, routing, or deploy-surface changes

It should stay focused on deployment posture rather than turning into a general product-release guide.

## Workflow And Ownership

The primary owners for this pack are `@architect` and the `Git / GitHub Team` plus `@production-readiness-reviewer` when deployment risk matters.

Expected flow:
1. `@master` recognizes deployment-heavy or Vercel-heavy work
2. the right engineering or Git/GitHub owners lead
3. validation, review, and release-governance checks are applied as needed
4. the copied repo docs are updated with real deployment-specific detail

## Quality Gates

Required by default:
- `@github-safety-guard` for outgoing repo-safety review
- `@code-reviewer` for code-affecting paths
- `@qa-engineer` for behavior-changing work

Required when risk is higher:
- `@production-readiness-reviewer`
- `@risk-officer`

## MCP And Credentials Guidance

This pack should not assume MCP by default.

Prefer:
1. repo files, build commands, and env documentation first
2. CLI or platform-native configuration where practical
3. MCP only when it materially improves workflow visibility

## What The Copied Repo Must Customize

At minimum, the copied repo should make these concrete in `CLAUDE.md`, `AGENTS.md`, or local context:
- real build and deploy commands
- framework and runtime constraints
- preview versus production rules
- actual environment boundaries
- domain or DNS ownership expectations
- release and rollback posture

## Related Docs

- `docs/SOLUTION_PACKS.md`
- `docs/RELEASE_GOVERNANCE.md`
- `docs/PROJECT_CUSTOMIZATION.md`
- `docs/TEAMS.md`
