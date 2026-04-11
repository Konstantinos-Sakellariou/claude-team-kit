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

## Design Principles

1. Keep the Supabase team generic and reusable.
2. Do not bake project-specific URLs, schemas, secrets, or policies into the shared core.
3. Let `@master` activate the team as a reusable orchestration bundle, not as a second orchestrator.
4. Keep security and privacy review explicit for auth, RLS, and data access changes.
5. Preserve the existing artifact and approval rules for plans, ADRs, and core docs.

## What The Team Should Cover

The Supabase team should help with:
- database schema design and migrations
- Supabase auth flows and session handling
- row-level security policy design and review
- storage buckets and access rules
- edge functions and server-side integrations
- client SDK integration patterns
- observability, rollback, and release safety

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
  - `@risk-officer`
  - `@tech-writer`

This gives the kit immediate Supabase coverage without requiring a whole new specialist roster on day one.

### Later Version: Supabase Specialists

If repeated use justifies it, add dedicated agents such as:
- `@supabase-architect`
- `@supabase-auth-specialist`
- `@supabase-database-engineer`
- `@supabase-edge-functions-engineer`
- `@supabase-rls-reviewer`

## Suggested Team Workflows

### Schema / Migration Work

- Lead: `@architect` or future `@supabase-database-engineer`
- Support: `@senior-developer`, `@qa-engineer`
- Gate: `@security-auditor` for access-sensitive schema changes

### Auth / RLS Work

- Lead: `@architect`
- Support: `@senior-developer`
- Mandatory gate: `@security-auditor`
- Optional: `@customer-advocate` for auth UX implications

### Storage / Access Rules

- Lead: `@senior-developer`
- Mandatory gate: `@security-auditor`
- Optional: `@risk-officer` for public/private exposure concerns

### Edge Functions / Backend Logic

- Lead: `@senior-developer`
- Support: `@architect`, `@qa-engineer`
- Optional: `@performance-engineer`

### Supabase Release / Rollout

- Lead: `@risk-officer` or `@github-safety-guard`
- Support: `@security-auditor`, `@qa-engineer`, `@changelog-writer`

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

## Validation Requirements

When implemented, validate:
- team count updates stay correct
- docs explain the Supabase team clearly
- `@master` has explicit routing for Supabase work
- required security gating is documented
- workflow examples cover at least auth/RLS and schema/migrations

## Risks

- making the team too vendor-specific for the shared core
- turning common database/auth work into overly specialized prompt sprawl
- under-specifying security review for RLS and auth
- hard-coding project-specific Supabase assumptions into the generic kit

## Success Criteria

- Supabase-backed projects have a clear default collaboration pattern
- `@master` can route Supabase work consistently
- security review is explicit for auth and policy work
- docs stay generic while project-specific Supabase details remain in project briefings

## Recommended Next Step

If this backlog item is selected, start by implementing the reusable team manifest and `@master` routing only.

Add dedicated Supabase agents later only if repeated use shows the generic team bundle is not enough.
