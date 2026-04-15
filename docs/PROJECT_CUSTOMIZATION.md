# Project Customization Guide

Use `claude-team-kit` in two layers:

1. The shared kit in `.claude/`
2. The project-specific briefing in `CLAUDE.md` and `AGENTS.md`

The kit should stay generic. The project briefing should be concrete.

## Keep Core Briefings Lean

`CLAUDE.md` and `AGENTS.md` are high-frequency briefing files.

That means they should contain:
- the core project facts an agent needs to avoid obvious mistakes
- key commands
- architecture constraints
- deployment notes and gotchas that materially affect work

They should not become giant knowledge dumps.

Move deeper material into linked docs when possible:
- route inventories
- long architecture deep-dives
- detailed workflows
- extensive business context
- reusable planning artifacts

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

## Cleanup After Customization

Once the repo has real project-facing docs, do a cleanup pass.

The purpose is to review whether copied-kit artifacts are still helpful or whether they should now be:
- kept as reusable infrastructure
- customized to the repo
- deleted as template leftovers

Use the `repo-cleanup` skill for that review instead of silently carrying generic files forever.

## Private Local Context

Not every important project fact belongs in tracked docs.

Use `.claude/local-context/` for local-only material such as:
- private startup or company strategy
- customer or stakeholder notes
- pricing, fundraising, or GTM context
- unreleased roadmap details
- internal constraints that should influence decisions without being committed

Keep the boundary clean:
- tracked docs describe safe operational truth
- local context stores private working truth
- if a tracked doc would benefit from private material, `@master` should ask before moving it there

## Bootstrap For New Repos

When this kit is copied into a repo that still has generic template docs, `@master` should run a lightweight bootstrap flow before major work starts.

That bootstrap should:
- detect when the repo still looks like an uncustomized template
- ask a short structured set of questions
- accept partial answers
- make clearly labeled temporary assumptions where the user is unsure
- shift into guided initialization when the repo is still too vague for a one-pass bootstrap
- ask in small rounds and help the user with candidate answers when needed
- update `CLAUDE.md`, `AGENTS.md`, and `README.md` toward a real project briefing
- ask whether the repo also wants the private local context layer for sensitive business or customer notes

The goal is not perfect upfront certainty. The goal is enough real context that future agent work stops making obvious mistakes.

## Automatic Delegation Should Be Domain-Specific

The default kit rules are intentionally broad. Real projects should tighten them.

Examples:

- New UI page or component: route to `@senior-developer` and `@customer-advocate`
- Auth, payments, or external input: always include `@security-auditor`
- Performance-sensitive frontend work: always include `@performance-engineer`
- Architecture or system-boundary changes: always include `@architect`
- Public release or high-risk deploy: always include `@risk-officer`
- AI/ML projects: route exploratory work to `@data-scientist`, enforce `@model-evaluator` as the release gate, and keep infrastructure specifics in the project briefing

## Teams In Real Projects

The shared kit now includes reusable teams that `@master` can activate for recurring multi-agent workflows.

Use that abstraction to your advantage:

- keep shared team manifests generic
- add project-specific triggers in `CLAUDE.md` or `AGENTS.md`
- prefer a team when the same multi-agent shape keeps repeating
- avoid creating a new team when a single specialist or one-off rule is enough

Good reasons to add or extend a project-specific team:

- a domain has a stable lead plus recurring supporting reviewers
- the workflow has a recognizable sequence or required gates
- the same collaboration pattern appears across multiple requests

Bad reasons:

- renaming one specialist to sound more impressive
- encoding project facts that belong in the repo briefing instead
- creating overlapping teams with no clear lead or trigger boundary

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
- save deferred ideas in either:
  - private local `BACKLOG.md` created from `BACKLOG.example.md`
  - or tracked public `docs/BACKLOG.md` created from `docs/BACKLOG.example.md`
- for important deferred work, prefer both a backlog entry and a linked plan in `docs/plans/`
- save approved execution plans in `docs/plans/`
- save approved architecture or policy decisions in `docs/adr/`

Important:

- require explicit user approval before saving into `docs/plans/` or `docs/adr/`
- if backlog preference is unknown, let `@master` ask whether the repo wants private or public backlog storage
- let `@master` present the proposed artifact path and reason first
- let `@master` propose ADRs by default when a decision changes architecture, policy, workflow, or repo structure
- let `@tech-writer` own final ADR authorship after `@architect`, `@devils-advocate`, and `@judge` shape the decision record
- if approval is not given, keep the output in chat or move it to the chosen backlog

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

Use cleanup passes to prune template leftovers once the repo has enough project identity to do that safely.
