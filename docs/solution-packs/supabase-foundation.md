# Supabase Application Foundation

## Purpose

This solution pack defines a strong starting foundation for repos that want Supabase as the main backend layer for:
- database and migrations
- auth and session flows
- row-level security
- storage
- edge functions
- app-level client and server integration

It helps a repo start from a stronger operational baseline without pretending every Supabase repo should look identical.

## Best Fit

This pack is a strong fit for:
- SaaS products
- internal tools
- startup apps
- authenticated web products
- AI products that still need normal user, data, and storage surfaces

## What This Pack Covers

- expected Supabase file surface
- setup and env contract
- migration and seed expectations
- auth/session boundaries
- RLS and storage expectations
- edge-function boundary
- quality-gate and release expectations
- customization rules for the copied repo

## What This Pack Does Not Cover

- business-specific schema design
- product-specific auth choices
- exact provider configuration
- production secrets
- customer-specific access-control policy
- a full starter app template

## Expected Repo Surface

A strong Supabase-backed repo will often have:
- `supabase/config.toml`
- `supabase/migrations/`
- `supabase/seed.sql`
- `supabase/functions/`
- app-level Supabase wrappers for browser/client, server-side, and privileged usage when needed

## Setup Checklist

When applying this pack to a real repo:

1. confirm the repo actually wants Supabase as a primary backend foundation
2. define the expected `supabase/` surface
3. clarify the auth/session model
4. define the env contract
5. define migration and seed workflow expectations
6. define RLS and storage-review boundaries
7. define edge-function responsibilities if they exist
8. wire the copied repo briefings to the real Supabase surface

## Environment Contract

The copied repo should document the real env boundary clearly.

Typical surfaces include:
- project URL
- anon/public client key
- privileged service-role usage only in server-side or secure contexts
- edge-function or deployment-specific envs

Rules:
- never commit real secrets
- keep credential details out of tracked public docs
- document only the safe shape of the env contract publicly

## Auth And Session Guidance

This pack should make the repo clarify:
- which auth providers are used
- which routes or surfaces require authenticated access
- where session validation happens
- what privileged server-side access exists

## RLS And Storage Guidance

This pack should treat RLS and storage as first-class concerns.

The copied repo should define:
- which tables need policy coverage
- what user or role boundaries matter
- how storage buckets are organized
- what access model each bucket uses

Sensitive changes should always route through:
- `@security-auditor`
- `@qa-engineer`
- `@production-readiness-reviewer` when rollout risk is meaningful

## Edge Functions Guidance

If the repo uses `supabase/functions/`, this pack should clarify:
- what belongs in an edge function versus app/server code
- required envs and secret boundaries
- release and rollback expectations
- how functions are tested or validated

## Workflow And Ownership

The primary owner for this pack is the `Supabase Team`.

Expected flow:
1. `@master` recognizes Supabase-heavy work
2. `Supabase Team` leads
3. schema/auth/RLS/storage/function decisions are reviewed with the right gates
4. the copied repo docs are updated with real project-specific detail

## Quality Gates

Required by default:
- `@security-auditor` for auth, RLS, storage, and privileged access changes
- `@qa-engineer` for behavior-changing work
- `@code-reviewer` for code-affecting paths

Required when risk is higher:
- `@production-readiness-reviewer`
- `@risk-officer`

## MCP And Credentials Guidance

This pack should not assume MCP by default.

Prefer:
1. file and env configuration first
2. CLI setup where practical
3. MCP only when it materially improves the workflow

## CI/CD And Release Expectations

This pack should encourage a copied repo to define:
- migration review and safety expectations
- seed-data discipline
- preview or staging expectations where relevant
- release-readiness checks for risky auth/policy/storage changes

## What The Copied Repo Must Customize

At minimum, the copied repo should make these concrete in `CLAUDE.md`, `AGENTS.md`, or local context:
- actual Supabase file locations
- real auth provider choices
- real schema and migration rules
- actual RLS assumptions
- storage bucket design
- edge-function responsibilities
- rollout and rollback constraints

## Related Docs

- `docs/SOLUTION_PACKS.md`
- `docs/SUPABASE_REFERENCE.md`
- `docs/PROJECT_CUSTOMIZATION.md`
- `docs/TEAMS.md`
