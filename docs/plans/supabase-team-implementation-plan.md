# Supabase Team Implementation Plan

## Idea Summary

Add a reusable Supabase-oriented team to `claude-team-kit` so `@master` can route common Supabase workflows through a stable collaboration model instead of assembling ad hoc multi-agent chains every time.

## Artifact Decision

- Type: `docs/plans/`
- Status: Proposed
- Approval: Approved by user on 2026-04-09
- Backlog Link: `BL-029`
- Intended Assignee: `Unassigned`

## Goal

Support Supabase-backed projects with a generic team pack that covers schema work, auth, row-level security, storage, edge functions, client integration, migrations, observability, and release safety.

This plan assumes the Supabase team should become a self-contained domain pack inside the kit:
- reusable across many repos
- independently understandable once activated by `@master`
- opinionated about safety and production readiness
- still governed by the same approval, reporting, and artifact rules as the rest of the kit

## Design Principles

1. Keep the Supabase team generic and reusable.
2. Do not bake project-specific URLs, schemas, secrets, or policies into the shared core.
3. Let `@master` activate the team as a reusable orchestration bundle, not as a second orchestrator.
4. Keep security and privacy review explicit for auth, RLS, and data access changes.
5. Preserve the existing artifact and approval rules for plans, ADRs, and core docs.
6. Start with a strong team model before adding a large vendor-specific specialist roster.
7. Treat "independent" as operationally self-contained, not as a new top-level orchestrator.

## Why Supabase Is A Strong Domain Pack

Supabase is a very common stack choice in startup and product repos because it combines:
- Postgres database
- auth
- storage
- row-level security
- server-side functions
- realtime and client SDK support

That means one vendor choice often creates repeated multi-agent work across:
- schema and migrations
- auth/session flow design
- RLS policy review
- storage access
- edge-function or server integration
- rollout risk and operational safety

A Supabase team is useful because those concerns recur together and should not be re-routed from scratch every time.

## What The Team Should Cover

The Supabase team should help with:
- database schema design and migrations
- Supabase auth flows and session handling
- row-level security policy design and review
- storage buckets and access rules
- edge functions and server-side integrations
- client SDK integration patterns
- observability, rollback, and release safety

It should also help answer:
- when Supabase is a good fit versus when a repo only needs Postgres plus a separate auth/provider stack
- what parts of the platform should remain generic in the shared kit versus project-specific in local briefings
- what repo structure a real Supabase-backed app should add so agent work stays grounded in concrete files

## Recommended Team Shape

### Initial Version: Team First

Start by defining the team as a routing bundle using mostly existing agents:

- Lead: `@architect` or `@senior-developer`
- Required reviewers:
  - `@security-auditor`
  - `@qa-engineer`
- Common support:
  - `@debugger`
  - `@performance-engineer`
  - `@code-reviewer`
  - `@risk-officer`
  - `@production-readiness-reviewer`
  - `@tech-writer`
  - `@github-safety-guard`

This gives the kit immediate Supabase coverage without requiring a whole new specialist roster on day one.

### Later Version: Supabase Specialists

If repeated use justifies it, add dedicated agents such as:
- `@supabase-architect`
- `@supabase-auth-specialist`
- `@supabase-database-engineer`
- `@supabase-edge-functions-engineer`
- `@supabase-rls-reviewer`
- `@supabase-ops-reviewer`

Those specialist agents should only be added if repeated real work shows that the team bundle plus existing agents is not enough.

## Independent Operating Model

The Supabase team should be "independent" in the same sense as the Git / GitHub Team:
- `@master` still activates and reports it
- the team has a stable lead and required gates
- the workflows are clear enough that the user does not need to manually assemble specialists
- the documentation explains what the team covers, how it works, and what artifacts it expects

In practice, that means:
- a dedicated team manifest
- explicit `@master` routing triggers
- a small reference doc
- at least two workflow examples
- validation coverage
- optional future dedicated agents if usage justifies them

## Suggested Team Workflows

### Schema / Migration Work

- Lead: `@architect` or future `@supabase-database-engineer`
- Support: `@senior-developer`, `@qa-engineer`, `@code-reviewer`
- Gate: `@security-auditor` for access-sensitive schema changes
- Release gate: `@production-readiness-reviewer` when migrations, seeds, or rollback risk are meaningful

### Auth / RLS Work

- Lead: `@architect`
- Support: `@senior-developer`
- Mandatory gate: `@security-auditor`
- Quality gate: `@code-reviewer`
- Optional: `@customer-advocate` for auth UX implications

### Storage / Access Rules

- Lead: `@senior-developer`
- Mandatory gate: `@security-auditor`
- Quality gate: `@code-reviewer`
- Optional: `@risk-officer` for public/private exposure concerns

### Edge Functions / Backend Logic

- Lead: `@senior-developer`
- Support: `@architect`, `@qa-engineer`, `@code-reviewer`
- Optional: `@performance-engineer`
- Release gate: `@production-readiness-reviewer` when external integrations, cron jobs, or rollout concerns exist

### Supabase Release / Rollout

- Lead: `@risk-officer` or `@github-safety-guard`
- Support: `@security-auditor`, `@qa-engineer`, `@changelog-writer`, `@production-readiness-reviewer`

### Debug / Incident Work

- Lead: `@debugger`
- Support: `@architect`, `@senior-developer`
- Optional: `@security-auditor`, `@performance-engineer`
- Use when the issue is around auth loops, RLS denials, migration failures, function errors, or storage access regressions

## Expected Downstream Project Surface

For the Supabase team to be useful in a real product repo, the target repo will usually need some or most of these project-specific surfaces:

- `supabase/config.toml`
- `supabase/migrations/`
- `supabase/seed.sql` or equivalent seed workflow
- `supabase/functions/` for edge functions when used
- app or server wrappers for client/server/admin usage
- env vars for project URL, anon key, service-role key, and any provider secrets
- project-specific docs describing auth assumptions, RLS strategy, and rollout constraints

The shared kit should not create those project files by default, but it should know to look for them and help shape them during repo bootstrap or project customization.

## Suggested Team Manifest

Possible future file:

```text
.claude/teams/supabase-team.md
```

It should define:
- team purpose
- lead options
- supporting agents
- activation triggers
- required gates
- typical flow patterns
- reporting expectations
- escalation to Git / GitHub Team for commit / push / PR flows
- when project-specific Supabase files must be updated or checked

## Code And Config To Add In This Repo

Phase 1 implementation in `claude-team-kit` should add:

- `.claude/teams/supabase-team.md`
- `@master` routing rules for Supabase requests
- `docs/SUPABASE_REFERENCE.md`
- updates in:
  - `README.md`
  - `CLAUDE.md`
  - `AGENTS.md`
  - `docs/TEAMS.md`
  - `docs/AGENT_WORKFLOWS.md`
  - `docs/PROJECT_CUSTOMIZATION.md`
  - `docs/SYSTEM_REFERENCE.md`
- validation updates in:
  - `scripts/doctor.sh`
  - `tests/test_prompt_contracts.py`

Phase 2 may add:
- command examples or workflow shortcuts when a strong repeated pattern emerges
- optional dedicated Supabase agents
- deeper repo-customization examples for common app stacks such as Next.js or Python backends

## Phased Rollout

### Phase 1: Team Manifest And Routing

Implement the reusable team manifest and teach `@master` to activate it for:
- auth and session work
- schema and migration work
- RLS and policy work
- storage and access rules
- edge functions
- Supabase-backed deployment or release-risk work

### Phase 2: Documentation And Workflow Clarity

Add:
- a Supabase reference doc
- workflow examples
- customization guidance for copied repos
- visible reporting expectations when the team is used

### Phase 3: Validation And Quality Gates

Make sure:
- `@security-auditor` is explicit for auth, RLS, storage, and sensitive access changes
- `@code-reviewer` is part of code-affecting Supabase paths
- `@production-readiness-reviewer` is part of risky rollout paths
- docs and tests assert the team behaves like the rest of the kit

### Phase 4: Optional Specialist Layer

Only if real usage justifies it, add dedicated Supabase specialists and narrower routing.

## Suggested `@master` Routing Triggers

Route to the Supabase team when requests involve:
- Supabase auth
- Supabase database schema or migrations
- Supabase row-level security
- Supabase storage buckets or access rules
- Supabase edge functions
- Supabase client SDK integration
- Supabase deployment or release risk

## Docs To Update When Implemented

- `README.md`
- `CLAUDE.md`
- `AGENTS.md`
- `docs/TEAMS.md`
- `docs/AGENT_WORKFLOWS.md`
- `docs/PROJECT_CUSTOMIZATION.md`
- `.claude/agents/master.md`
- `.claude/teams/supabase-team.md`
- `docs/SUPABASE_REFERENCE.md`
- `docs/SYSTEM_REFERENCE.md`

## Validation Requirements

When implemented, validate:
- team count updates stay correct
- docs explain the Supabase team clearly
- `@master` has explicit routing for Supabase work
- required security gating is documented
- workflow examples cover at least auth/RLS and schema/migrations
- the reference doc explains what Supabase is and what belongs in project-specific files versus shared kit logic

## Risks

- making the team too vendor-specific for the shared core
- turning common database/auth work into overly specialized prompt sprawl
- under-specifying security review for RLS and auth
- hard-coding project-specific Supabase assumptions into the generic kit

## Success Criteria

- Supabase-backed projects have a clear default collaboration pattern
- `@master` can route Supabase work consistently
- security review is explicit for auth and policy work
- code review and production-readiness gating are visible where they matter
- docs stay generic while project-specific Supabase details remain in project briefings

## Recommended Next Step

If this backlog item is selected, start by implementing:
- the reusable team manifest
- `@master` routing
- the Supabase reference doc

Add dedicated Supabase agents later only if repeated use shows the generic team bundle is not enough.
