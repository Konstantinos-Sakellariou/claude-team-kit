# Architecture

`claude-team-kit` is a workspace kit, not an orchestration runtime.

The repo packages a reusable team definition for Claude-style coding workflows:
- agent prompts
- optional domain-specialist teams such as AI/ML
- reusable skills
- standing rules
- safety and automation hooks
- starter project briefs and settings

## Product Boundary

This repository does not provide:
- a background orchestration daemon
- tmux worker management
- real-time execution HUDs
- token or cost analytics
- a standalone CLI runtime

Instead, it provides the configuration and prompting layer that can be dropped into another project or used as a template repository.

## Canonical Sources

The canonical implementation lives under `.claude/`.

- `.claude/agents/`: agent definitions and orchestration prompts
- `.claude/teams/`: reusable team manifests that `@master` can activate
- `.claude/skills/`: reusable task skills
- `.claude/rules/`: standing engineering rules
- `.claude/hooks/`: safety and formatting shell hooks
- `.claude/agent-memory/`: persistent per-agent memory
- `.claude/local-context/`: optional local-only business, customer, and strategy context
- `.claude/settings.json`: default Claude workspace settings
- `BACKLOG.example.md`: tracked starter for the private local backlog file
- `docs/BACKLOG.example.md`: tracked starter for an optional public backlog
- `docs/plans/`: approved execution-plan artifacts
- `docs/adr/`: approved architecture and policy decisions

The shared kit can include reusable domain-specialist packs when they stay generic. The built-in AI/ML layer is one example: it adds specialist prompts and rules without forcing any project-specific platform or lifecycle.

Repo-level docs explain and package that implementation:

- `README.md`: human-facing overview and setup
- `CLAUDE.md`: repo briefing for Claude-compatible tools
- `AGENTS.md`: repo briefing for Codex-style tools that read AGENTS files
- `docs/BOOTSTRAP.md`: how new repos should be initialized when the kit is copied elsewhere
- `docs/LOCAL_CONTEXT.md`: how the private local-context layer works and where the privacy boundary sits
- `docs/TEAMS.md`: the reusable team abstraction and team operating rules
- `docs/AGENT_WORKFLOWS.md`: collaboration and orchestration examples
- `docs/PROJECT_CUSTOMIZATION.md`: how to adapt the kit to a real project

## Operating Model

The intended operating flow is:

1. A user enters through `@master`
2. In a new repo, `@master` may first run a bootstrap flow if the briefing still looks generic
3. When relevant, `@master` may also read `.claude/local-context/` for local-only private context
4. `@master` plans the work
5. `@master` decides whether the work is best handled by a single agent, one team, or multiple teams
6. Specialist agents contribute in parallel or sequence
7. `@master` synthesizes the result
8. Durable decisions are proposed as ADRs by default when they should outlive the chat
9. `@workspace-updater` reviews and aligns the core docs after significant changes

This repo currently enforces that model through prompts, settings, hooks, and validation checks rather than through an external execution engine.

Agents are the atomic specialists in that model.

Teams are the reusable collaboration bundles around them.

That means:
- agents do the actual work
- teams give `@master` a repeatable way to activate known multi-agent patterns
- `@master` stays the only top-level orchestrator and final synthesizer

ADR ownership in that model is:
- `@master`: detects ADR-worthy decisions and asks for approval
- `@architect`: owns the technical substance
- `@devils-advocate` and `@judge`: pressure-test the reasoning
- `@tech-writer`: writes the final ADR once approved
- `@workspace-updater`: aligns `README.md`, `CLAUDE.md`, and `AGENTS.md` afterward

The core documentation files in that loop are:
- `CLAUDE.md`
- `AGENTS.md`
- `README.md`

## Maintenance Priorities

When extending the kit, prefer this order:

1. Keep docs aligned with the actual `.claude/` contents
2. Improve setup and validation ergonomics
3. Add tests and CI for hooks, prompts, and metadata
4. Add new agents or skills only when the workflow gap is clear

## Adaptation Layer

When the kit is copied into a real repo, the adaptation work should happen in this order:

1. Customize `CLAUDE.md` and `AGENTS.md` with repo facts
2. Add repo-specific gotchas and delegation rules
3. Define any project-specific documentation sync targets
4. Extend `@master` and `@workspace-updater` only if the repo has repeated sync workflows

## Known Constraints

- `README.md`, `CLAUDE.md`, and `AGENTS.md` can drift unless updated together
- shell hooks rely on common local tools such as `python3`, `black`, `isort`, and `prettier`
- local secrets belong in `.claude/settings.local.json` or environment variables, never tracked files
- local private business and customer context belongs in `.claude/local-context/`, never tracked files by default
