# Self-Upgrade Guide

## Purpose

This guide explains how `claude-team-kit` should evolve itself safely.

Use it when you are:
- adding or changing agents, teams, skills, commands, rules, or hooks
- changing artifact policy, reporting, bootstrap, or governance behavior
- extending the kit for a new domain pack such as Supabase
- deciding whether a new idea belongs in the tracked core, a focused doc, or a local-only planning surface

The goal is not just to "add the feature."
The goal is to keep the repo:
- aligned
- discoverable
- public/private-safe
- resistant to drift
- resistant to hot-path bloat

## Core Model

The repo should upgrade through a consistent loop:

1. Confirm the change fits the repo direction
2. Choose the right surface for the change
3. Update the canonical implementation in `.claude/`
4. Update the smallest set of docs that should expose the change
5. Add or update validation
6. Run the checks
7. Confirm public vs local boundaries are still correct

This repo is a workspace kit, not a runtime engine.
Self-upgrades should strengthen that model, not blur it.

## First Check: Should This Be In The Core?

Before adding anything, ask:

1. Does this fit the current vision model in `docs/VISION.example.md` or local `docs/VISION.md`?
2. Does it fit the roadmap direction in `docs/ROADMAP.example.md` or local `docs/ROADMAP.md`?
3. Is this a reusable workspace capability, or only a private/local planning idea?
4. Is this generic enough for the tracked kit, or should it stay in `.claude/local-context/`?
5. Does it improve the operating model, or does it just add surface area?

If the answer is unclear, prefer:
- a backlog item
- a plan
- or a focused doc

before expanding the core implementation.

## Surface Selection

Choose the upgrade surface intentionally:

| If You Are Changing... | Primary Surface | Usually Also Update |
|---|---|---|
| orchestration behavior | `.claude/agents/master.md` | `README.md`, `CLAUDE.md`, `AGENTS.md`, tests |
| final alignment behavior | `.claude/agents/workspace-updater.md` | docs, tests |
| repeatable multi-agent routing | `.claude/teams/` | `docs/TEAMS.md`, `docs/AGENT_WORKFLOWS.md`, tests |
| repeatable user-facing workflow entrypoint | `.claude/commands/` | `README.md`, `CLAUDE.md`, `AGENTS.md`, `docs/SYSTEM_REFERENCE.md`, tests |
| repeatable procedure | `.claude/skills/` | `README.md`, focused docs, tests when visibility matters |
| standing policy or quality bar | `.claude/rules/` | `CLAUDE.md`, `AGENTS.md`, focused docs, doctor/tests |
| lightweight automation or hygiene reinforcement | `.claude/hooks/` and `.claude/settings.json` | docs, tests, doctor |
| public-safe implementation detail | `docs/` or `docs/plans/` | hot-path pointers when appropriate |
| private strategy, company context, or roadmap detail | `.claude/local-context/` | local-only references, not tracked docs |
| durable architecture or policy decision | `docs/adr/` | core docs only if behavior changed |

## Documentation Upgrade Rule

Follow the hub-and-spoke model every time:

- `README.md`, `CLAUDE.md`, and `AGENTS.md` are summary hubs
- focused docs in `docs/` are the detailed spokes

When a feature grows, do not keep stuffing detail into the hot path.
Instead:

1. create or update the focused doc
2. add a short summary plus a link from the hubs
3. update `docs/SYSTEM_REFERENCE.md` if the repo surface changed materially

Use `docs/DOCUMENTATION_GOVERNANCE.md` as the anti-bloat rulebook.

## Public vs Local Boundary

This repo deliberately separates public-safe kit structure from local strategy.

Tracked by default:
- `.claude/`
- `README.md`
- `CLAUDE.md`
- `AGENTS.md`
- public-safe focused docs in `docs/`
- public-safe execution plans in `docs/plans/`
- approved ADRs in `docs/adr/`

Local-only by default:
- `BACKLOG.md`
- `.claude/local-context/`
- `.claude/local-context/plans/`
- real `docs/VISION.md` and `docs/ROADMAP.md` when they contain private direction

Before committing, ask:
- does this belong in the shared kit?
- does this reveal private product, customer, or company strategy?
- should this stay in local context instead?

## Upgrade Checklist By Change Type

### Agents

When adding or materially changing an agent:
- update the agent prompt in `.claude/agents/`
- add or update memory if the role needs it
- update `README.md`, `CLAUDE.md`, and `AGENTS.md` if the hot-path roster or routing changed
- update `docs/SYSTEM_REFERENCE.md`
- update team docs if the agent changes a team workflow
- update tests and doctor if the new surface is expected to be visible or required

### Teams

When adding or materially changing a team:
- update `.claude/teams/`
- update `@master` routing rules
- update `docs/TEAMS.md`
- update `docs/AGENT_WORKFLOWS.md`
- update the main README graph if the top-level team map changed
- update counts or visible summaries if needed
- update tests and doctor

### Commands

When adding a command:
- create the command file under `.claude/commands/`
- make sure `@master` can interpret it cleanly
- expose it in `README.md`, `CLAUDE.md`, and `AGENTS.md`
- reflect it in `docs/SYSTEM_REFERENCE.md`
- update doctor and prompt-contract tests

### Skills

When adding a skill:
- add the skill under `.claude/skills/`
- expose it only where it improves discovery
- avoid turning the core docs into a skill catalog dump
- update counts and references when the visible inventory changes

### Rules And Hooks

When adding a rule or hook:
- decide whether it is policy, automation, or both
- keep hooks lightweight and low-annoyance
- register new hooks in `.claude/settings.json` when required
- surface only the rules that matter in hot-path docs
- make sure the doctor/tests enforce the contract if the rule is now part of the repo standard

## Validation Standard

Every meaningful self-upgrade should end with:

- `./scripts/doctor.sh`
- `python3 -m unittest discover -s tests -v`

If the repo surface changed materially, also review:
- `git diff --stat`
- `README.md`
- `CLAUDE.md`
- `AGENTS.md`
- `docs/SYSTEM_REFERENCE.md`

Treat failing alignment checks as product issues, not optional cleanup.

## ADR And Planning Rule

If the upgrade changes durable architecture, policy, workflow, or structure:
- consider an ADR

If the work is substantial but not yet approved:
- use backlog plus plan flow first

Use:
- `docs/plans/` for approved public-safe implementation plans
- `.claude/local-context/plans/` for private strategy or roadmap plans
- `docs/adr/` for approved durable decisions

## What Good Self-Upgrade Looks Like

A good self-upgrade should:
- make the repo stronger without making it noisier
- improve the operating model, not just add inventory
- stay aligned with the vision and roadmap
- preserve public/private boundaries
- keep the hot path lean
- remain easy to discover from the main docs

That is the standard to keep from now on.
