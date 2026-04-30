# Cross-Tool Portability

`claude-team-kit` is meant to be reusable across projects and adaptable across host tools.

That does **not** mean every tool should get a first-class converter.

The goal is:
- keep one canonical shared kit
- support high-value host surfaces intentionally
- separate repo customization from tool-specific adaptation
- avoid turning portability into maintenance debt

## Core Position

The active source of truth remains:
- `.claude/` for the shared kit
- `README.md`, `CLAUDE.md`, and `AGENTS.md` for repo-facing briefings

Portability should preserve that structure rather than fork it into many competing versions.

The clean model is:
1. shared kit core
2. repo-specific overlay
3. optional tool-specific adapter

That same discipline should hold for external repos too:
- use `docs/OPTIONAL_DEPENDENCIES_AND_ADAPTERS.md` to classify whether something is a dependency, an adapter, or just inspiration
- use `docs/EXTERNAL_SKILL_REPOS.md` when the question is really about skill packaging and distribution

## Portability Tiers

### Tier 1 — Native Fit

These hosts already fit the kit well enough that adaptation is mostly about repo customization:
- Claude Code
- Codex-style tools that read `AGENTS.md`

Expected work:
- bootstrap or customize the repo
- keep `CLAUDE.md` and `AGENTS.md` project-specific
- preserve `.claude/` as the canonical implementation layer

### Tier 2 — Briefing-Compatible Hosts

These hosts can benefit from the kit, but usually through adapted briefings and selected overlays rather than a one-shot export:
- Cursor
- GitHub Copilot workspaces
- Gemini CLI / repo assistants
- Aider and similar CLI copilots

Expected work:
- map the repo briefings into the host's preferred surface
- keep the shared rules, docs, and commands understandable even if the host ignores some of them
- prefer docs and checklist guidance before automation

### Tier 3 — Low-Value Or Unstable Targets

Do not add support just because a tool exists.

Low-value targets usually have one or more of these traits:
- unstable repo conventions
- weak support for persistent repo briefings
- weak demand
- high conversion cost
- poor alignment with the `@master`-first orchestration model

Those should stay unsupported unless demand becomes real.

## What Maps Cleanly

These surfaces are intentionally portable:
- `README.md`
- `CLAUDE.md`
- `AGENTS.md`
- `docs/`
- `docs/plans/`
- `docs/adr/`
- `BACKLOG.example.md`
- `.claude/rules/`
- `.claude/skills/`
- `.claude/commands/`

These may need host-aware interpretation rather than direct export:
- `.claude/agents/`
- `.claude/teams/`
- `.claude/hooks/`
- `.claude/settings.json`

That difference matters:
- some surfaces are universal repo artifacts
- some are host-flavored behavior layers

## Repo Customization Versus Tool Adaptation

Do not confuse these two jobs.

Repo customization answers:
- what project is this?
- what stack does it use?
- what workflows matter here?

Tool adaptation answers:
- what host is the team using?
- which repo artifacts does that host actually read?
- what has to stay manual versus mapped?

Use `/bootstrap-repo` and `/customize-repo` first.

Only consider a tool adapter after the repo itself is already specific enough.

## Recommended Adaptation Flow

1. Start from the canonical kit in `.claude/`.
2. Bootstrap or customize the copied repo.
3. Identify the actual host tool surface in use.
4. Reuse the repo briefings and docs directly where possible.
5. Add a thin adapter note only for the host-specific gaps that matter.
6. Automate only the repetitive stable parts.

## When A Helper Script Is Justified

A portability helper is justified only when all of the following are true:
- the target host has real demand
- the mapping is stable enough to maintain
- the conversion removes repeated manual work
- the output remains understandable and auditable
- the helper does not split the source of truth into parallel systems

If those conditions are not met, prefer docs and checklists instead.

## Best First Public Output

For now, the strongest public stance is:
- a portability contract
- a supported-hosts mental model
- clear rules for when adapter tooling is worth building

That is enough to help real repos adapt the kit across tools without pretending the project already maintains a multi-host export platform.
