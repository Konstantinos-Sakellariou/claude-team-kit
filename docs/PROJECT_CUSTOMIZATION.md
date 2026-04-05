# Project Customization Guide

Use `claude-team-kit` in two layers:

1. The shared kit in `.claude/`
2. The project-specific briefing in `CLAUDE.md` and `AGENTS.md`

The kit should stay generic. The project briefing should be concrete.

## What To Customize First

When you drop this kit into a real repo, update `CLAUDE.md` and `AGENTS.md` with:

- real project name and owners
- actual stack, runtime, and package manager
- important directories and architecture constraints
- real commands for dev, tests, lint, build, and deploy
- environment variables and secret-handling expectations
- repo-specific gotchas that would cause bad agent decisions if omitted

## What Good Project Briefings Usually Include

High-signal project briefings often add:

- route or page inventories for app repos
- deployment notes and environment boundaries
- framework limitations, such as static export or serverless constraints
- translation or content rules
- visual-system or design-token rules
- internal-only pages, hidden tools, or noindex sections
- data-pipeline entry points and mock-mode guidance

The goal is simple: include the facts an agent would need to avoid obvious mistakes.

## Automatic Delegation Should Be Domain-Specific

The default kit rules are intentionally broad. Real projects should tighten them.

Examples:

- New UI page or component: route to `@senior-developer` and `@customer-advocate`
- Auth, payments, or external input: always include `@security-auditor`
- Performance-sensitive frontend work: always include `@performance-engineer`
- Architecture or system-boundary changes: always include `@architect`
- Public release or high-risk deploy: always include `@risk-officer`

## Project-Specific Sync Targets

Some repos contain files that must stay synchronized whenever work lands.

Common examples:

- route registries or internal catalogs
- briefing docs for founders, investors, or other LLMs
- sitemap-like tables in `CLAUDE.md`
- feature matrices, integration inventories, or architecture overviews

## Artifact Storage Policy

Good teams define where planning artifacts live before ideas start multiplying.

Recommended default policy:

- keep early exploration in chat
- save deferred ideas in `BACKLOG.md`
- save approved execution plans in `docs/plans/`
- save approved architecture or policy decisions in `docs/adr/`

Important:

- require explicit user approval before saving into `docs/plans/` or `docs/adr/`
- let `@master` present the proposed artifact path and reason first
- if approval is not given, keep the output in chat or move it to `BACKLOG.md`

If your repo has these, document them explicitly in `CLAUDE.md` or `AGENTS.md` under a section such as:

## Documentation Sync
- `@master` owns these files after big changes
- list the files that must stay aligned
- define what counts as a "big change"

## Extending `@master`

If a project needs extra post-task behavior, add a focused project-specific section to `.claude/agents/master.md`.

Good examples:

- after creating a new route, sync a route catalog
- after shipping a major feature, update a founder or investor brief
- after changing architecture, update a system overview doc

Keep these rules:

- tie the behavior to a concrete trigger
- name the exact files to inspect or update
- describe the diff/check the agent should perform
- keep project-specific logic out of the shared generic sections

## Extending `@workspace-updater`

Mirror important `@master` extensions in `.claude/agents/workspace-updater.md`.

If `@master` says a new route, registry item, or briefing doc must be synchronized, `@workspace-updater` should:

- inspect the target file
- confirm whether an update is needed
- make only the minimum required change
- report what changed and what was reviewed

## A Good Mental Model

Use the kit for reusable behavior.

Use project briefings for facts.

Use project-specific orchestrator extensions only when a repo has a repeated synchronization need that agents would otherwise forget.
