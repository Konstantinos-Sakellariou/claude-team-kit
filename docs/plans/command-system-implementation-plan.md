# Command System Implementation Plan

## Idea Summary

Add a thin command layer to `claude-team-kit` so users can trigger common, high-structure workflows explicitly while keeping `@master` as the only top-level orchestrator.

## Artifact Decision

- Type: `docs/plans/`
- Status: Proposed
- Approval: Approved by user on 2026-04-09
- Backlog Link: `BL-027`
- Intended Assignee: `Unassigned`

## Goal

Improve repeatability, discoverability, and orchestration consistency by introducing a command system that sits on top of the existing agents, teams, and skills instead of competing with them.

## Core Design Principles

1. Commands are user-facing entrypoints.
2. `@master` remains the only top-level orchestrator.
3. Commands never bypass approvals, safety checks, or documentation flows.
4. Skills remain the reusable procedure layer.
5. Teams remain reusable collaboration bundles.
6. Agents remain the actual specialists that do the work.

## Recommended Architecture

Use this layering model:

- `command` = explicit user entrypoint
- `@master` = interpreter and orchestrator
- `skill` = reusable procedure logic
- `team` = reusable multi-agent routing bundle
- `agent` = specialist worker or reviewer
- `artifact` = durable output when needed (`BACKLOG.md`, `docs/plans/`, `docs/adr/`, core docs)

### Operating Rule

Users call commands.

`@master` interprets the command, selects the right skill, team, and agents, and returns the result in the normal orchestration/reporting format.

Agents should not rely on commands as if they were users. They should use the underlying workflow logic directly.

## Why This Helps

- reduces prompt ambiguity for repeated workflows
- makes high-value workflows easier to discover
- improves consistency of artifacts and approvals
- lowers token waste on repeated setup instructions
- keeps the system scalable without creating a second orchestration model

## What Commands Should Be Used For

Commands are best for workflows that are:
- repeated often
- structurally predictable
- approval-gated
- artifact-producing
- onboarding-heavy
- safety-critical

Commands are a weaker fit for:
- casual conversation
- one-off bespoke analysis
- tiny edits where direct natural-language prompting is already clear

## Recommended First Command Set

### `/bootstrap-repo`

- Purpose: start the new-repo bootstrap flow explicitly
- Lead: `@master`
- Typical support: `@tech-writer`, `@architect`
- Outputs: stronger `CLAUDE.md`, `AGENTS.md`, optional `README.md` updates

### `/save-backlog`

- Purpose: persist an idea or follow-up explicitly
- Lead: `@backlog-updater`
- Outputs: backlog row in `BACKLOG.md` or `docs/BACKLOG.md`

### `/plan-idea`

- Purpose: turn an idea into a validated execution plan
- Lead: `@idea-executor`
- Typical support: `@devils-advocate`, `@judge`, `@architect`
- Outputs: chat plan, optional `docs/plans/<slug>.md` after approval

### `/write-adr`

- Purpose: trigger the ADR flow explicitly
- Lead: `@master`
- Typical support: `@architect`, `@devils-advocate`, `@judge`, `@tech-writer`
- Outputs: optional `docs/adr/<NNN>-<slug>.md` after approval

### `/release-check`

- Purpose: run the pre-push or pre-release governance path
- Lead: `@github-safety-guard`
- Typical support: `@privacy-reviewer`, `@risk-officer`, `@changelog-writer`
- Outputs: safety report and go/no-go recommendation

### `/sync-docs`

- Purpose: explicitly run final documentation alignment
- Lead: `@workspace-updater`
- Outputs: `CLAUDE.md`, `AGENTS.md`, and `README.md` review/update summary

### `/triage-input`

- Purpose: preprocess large logs, diffs, dumps, or noisy inputs before deeper work
- Lead: `@master`
- Typical support: domain specialist based on input type
- Outputs: narrowed evidence and next-step recommendation

### `/context-audit`

- Purpose: review whether repo context is bloated, missing, generic, or inconsistent
- Lead: `@master` or `@tech-writer`
- Outputs: context-quality report and recommended fixes

## Suggested File Structure

Possible future structure:

```text
.claude/
├── commands/
│   ├── bootstrap-repo.md
│   ├── save-backlog.md
│   ├── plan-idea.md
│   ├── write-adr.md
│   ├── release-check.md
│   ├── sync-docs.md
│   ├── triage-input.md
│   └── context-audit.md
```

Each command file should define:
- command name
- user intent
- owning skill or workflow
- lead team or agent
- supporting agents
- approval gates
- artifact targets
- default report shape

## Command Routing Model

When a command is invoked:

1. `@master` identifies the command
2. `@master` maps it to the owning workflow
3. `@master` announces:
   - command used
   - selected team or lead
   - supporting agents
   - expected outputs
4. work runs through the normal agent/team flow
5. `@master` returns the synthesized result
6. `@workspace-updater` still runs when the workflow materially changes the repo

## Reporting Contract

Command-triggered work should still follow the main reporting model.

Suggested report shape:

```text
## Command Run

### Command
/plan-idea

### Teams / Agents Used
- ...

### What Happened
- ...

### Artifacts
- ...

### Next Step
- ...
```

## Approval Rules

Commands must not weaken the current approval model.

Still require explicit approval for:
- saving into `docs/plans/`
- saving into `docs/adr/`
- any commit or push after safety review
- any promotion of private local-context material into tracked docs

## What Should Stay Command-Free

Do not over-command the system.

Avoid commands for:
- generic implementation requests that natural language already expresses well
- tiny tactical edits
- open-ended brainstorming without a stable workflow shape
- anything that would create duplicate entrypoints for the same simple behavior

## Implementation Phases

### Phase 1: Command Architecture

1. document the command model
2. define how commands relate to skills, teams, and agents
3. define the first command set
4. document approvals and artifacts

### Phase 2: `@master` Integration

1. teach `@master` to recognize and route commands
2. add reporting expectations for command-triggered flows
3. keep all command paths compatible with current team and artifact rules

### Phase 3: Command Definitions

1. create `.claude/commands/`
2. add the first command files
3. map each command to its workflow owner and outputs

### Phase 4: Validation And Docs

1. update `README.md`, `CLAUDE.md`, and `AGENTS.md`
2. add prompt-contract tests for command routing
3. extend `doctor.sh` to validate command/docs alignment

## Dependencies

- existing skill system in `.claude/skills/`
- existing team manifests in `.claude/teams/`
- current artifact policy for backlog/plans/ADRs
- `@master` remaining the only top-level orchestrator

## Risks

- creating a second orchestration system instead of a thin entry layer
- making commands overlap too much with existing natural-language use
- letting commands bypass approvals or safety checks
- overbuilding too many commands before the highest-value set is proven

## Success Criteria

- commands make repeated workflows easier to trigger
- `@master` remains the only top-level orchestrator
- commands improve consistency without adding conceptual clutter
- artifacts and approvals remain intact
- users can still use natural language for everything else

## Recommended Next Step

If this backlog item is selected, start with Phase 1 and Phase 2 only:

1. document the command architecture
2. teach `@master` how commands should behave
3. define the first command set

Then decide whether `.claude/commands/` is worth adding immediately or after the routing model feels right.
