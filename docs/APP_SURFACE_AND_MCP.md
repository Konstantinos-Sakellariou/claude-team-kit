# App Surface And MCP-Connected Systems

## Purpose

This document defines the boundary for a future product surface on top of `claude-team-kit`.

The goal is not to turn the repo into a runtime today.
The goal is to make the future product direction concrete enough that near-term repo decisions stay aligned with it.

## Why This Matters

The kit now has:
- a reusable orchestration layer
- durable memory architecture
- graph/repo-intelligence framing
- solution packs and design packs
- company-building and executive-architecture guidance

That means a future app surface is no longer vague.
It can now be described as an interactive layer on top of a stronger repo-native operating system.

## Core Rule

The repo stays canonical.

Any future app surface should be:
- interactive
- operator-friendly
- built on top of repo artifacts
- additive rather than replacement-oriented

The app should help people use the kit more easily.
It should not become an excuse to abandon the durable file-first model.

## Repo-Native Vs App-Native Boundary

### Repo-native

These should remain canonical in the repo:
- agent prompts
- team manifests
- rules, hooks, and skills
- ADRs
- public-safe architecture docs
- starter packs, solution packs, and design packs
- tracked memory surfaces
- local private context

### App-native

These are strong future candidates for an app layer:
- interactive intake through `@master`
- guided bootstrap and company-building flows
- backlog, roadmap, and handoff review surfaces
- artifact navigation across memory, plans, ADRs, and packs
- operator dashboards for current state and next actions

### Shared Rule

If the app surfaces or edits something durable, the durable source of truth should still resolve back to repo artifacts or local private files.

## First Candidate App Flows

The strongest first app flows are:

1. Ask `@master`
- start a task
- understand the recommended team
- get visible orchestration without reading prompt files

2. Review current operating state
- backlog
- roadmap
- vision or strategy direction when present
- handoff
- recent decisions
- current next move

That review surface should likely feel more like:
- a calm dashboard home
- timeline and current-state visibility
- easier movement between “what matters now” and “what connects to it”

3. Navigate related artifacts
- see which docs, packs, plans, or ADRs connect to a workflow
- move from one artifact to the next without manual hunting

4. Guided workflow entry
- bootstrap a repo
- run a guided intake or onboarding flow
- shape an idea into a plan
- run release-readiness checks
- inspect doc-impact or handoff state

Those are also the strongest future candidates for structured SDK-backed user-input handling if a host app exists later.

## First Candidate MCP-Connected Systems

These are the strongest early MCP-connected systems to explore:

1. GitHub
- issues, pull requests, review status, release context

2. Backend or database layer
- where a product repo needs operational visibility for schemas, environments, or project structure

3. Docs and knowledge sources
- project docs, playbooks, research references, or company knowledge bases

4. Analytics or product signals
- product metrics, release-health indicators, or lightweight business dashboards

Later candidates may include:
- CRM or pipeline tools
- content systems
- support systems
- deployment or observability platforms

## MCP Boundary Rules

MCP should stay optional.

Preferred order:
1. repo files and local CLI first
2. MCP where it materially improves workflow visibility or speed
3. no connector sprawl just because an integration exists

A future app should not assume:
- every system has an MCP
- every repo wants the same connected stack
- every workflow benefits from live connected data

## Privacy And Promotion Boundary

This is the most important safety rule:

- local private context remains local by default
- the app may surface private context, but must not silently promote it into tracked docs
- MCP-connected systems should respect the same tracked-vs-local boundary as the repo itself
- public kit truth and private operating truth must remain visibly distinct

That means:
- tracked docs explain reusable architecture
- local context carries sensitive company, customer, POC, or strategy reality
- the app should help users navigate that split, not erase it

## What This Should Not Become

This future direction should not become:
- a mandatory runtime dependency
- a second orchestration system competing with `@master`
- a hidden database replacing the repo's durable artifacts
- a license to move private context into public surfaces casually
- a giant all-in-one company operating platform before the core workflows are truly ready

## Practical Product Boundary

The clean mental model is:

- repo = canonical operating system and durable artifact layer
- app = interactive operating surface
- MCP = optional connected system layer

If the app grows into a richer operator surface, the best first home screen is likely:
- backlog, roadmap, vision, and handoff visibility
- current recommended next step
- guided entry into the right workflow
- optional usage or system-status visibility when a hosted runtime exists

That keeps the repo useful on its own, while still leaving room for a future product that feels easier, richer, and more operator-friendly.

## Related Docs

- `docs/ARCHITECTURE.md`
- `docs/DURABLE_MEMORY.md`
- `docs/GRAPH_INTELLIGENCE.md`
- `docs/LOCAL_CONTEXT.md`
- `docs/SYSTEM_REFERENCE.md`
