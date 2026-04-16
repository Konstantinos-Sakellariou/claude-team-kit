# Supabase Reference

## What Supabase Is

Supabase is a backend platform built around Postgres.

In practice, teams often use it as a combined stack for:
- database and SQL migrations
- authentication
- row-level security
- file storage
- edge functions
- realtime features
- client/server SDK access

That makes it especially common in startup and product repos where one system is expected to cover a lot of backend surface quickly.

## Why It Matters In This Kit

`claude-team-kit` is moving toward stronger domain packs and reusable team models.

Supabase is a strong fit for a domain pack because work around it is rarely just "database work." It usually combines:
- product data modeling
- auth and session behavior
- access-control policy design
- storage permissions
- backend integration logic
- rollout and operational risk

Those concerns cut across architecture, implementation, security, testing, debugging, and release review. A reusable Supabase team gives `@master` a stable way to orchestrate that work without re-inventing the routing every time.

## When Supabase Is Useful

Supabase is often a good fit when a product repo wants:
- Postgres with a managed operational experience
- a fast path to auth and user/session flows
- SQL-first access control through row-level security
- built-in storage and backend-adjacent functions
- a compact stack for MVP or product-builder teams

It is especially common in:
- startup apps
- SaaS products
- internal tools
- AI products that still need normal product auth and data layers

## What The Supabase Team Should Cover

A strong generic Supabase team in this kit should cover:
- schema design and migrations
- auth and session handling
- row-level security policy design and review
- storage buckets and access rules
- edge functions
- client integration patterns
- debugging, observability, rollback, and release readiness

## What Should Stay Generic Versus Project-Specific

### Shared Kit Logic

The shared kit should know:
- how to recognize common Supabase work
- what supporting agents and gates are appropriate
- what risks usually matter for auth, RLS, storage, and migrations
- what docs and checks should exist

### Project-Specific Briefing

The copied repo should hold:
- real project URL and environments
- actual schema and migration history
- auth provider choices
- RLS assumptions and data-access model
- storage bucket layout
- edge-function responsibilities
- deployment and rollback constraints

Those details belong in the project's own `CLAUDE.md`, `AGENTS.md`, `README.md`, and local context when sensitive.

## Typical File Surface In A Real Supabase Repo

The team becomes much more useful when the target repo has a recognizable Supabase surface such as:

- `supabase/config.toml`
- `supabase/migrations/`
- `supabase/seed.sql`
- `supabase/functions/`
- app-level wrappers for browser, server, and admin access
- environment variables for project URL, anon key, and service-role usage

The shared kit should not hard-code these files, but it should know to look for them and help create or refine them in a project-specific repo.

## Why Security Needs To Be Explicit

Supabase work often touches:
- identity
- session trust boundaries
- row visibility
- storage access
- privileged server-side keys

That is why the planned Supabase team should make `@security-auditor` a required gate for auth, RLS, storage, and sensitive access changes.

## Why Production Readiness Also Matters

Supabase changes can be operationally risky even when the code looks fine.

Examples:
- a migration cannot be rolled back safely
- a policy blocks legitimate reads or writes
- an edge function depends on missing environment variables
- a storage rule leaks more than intended

That is why risky Supabase work should also involve:
- `@code-reviewer`
- `@qa-engineer`
- `@production-readiness-reviewer`

## Practical Recommendation For This Kit

Build the Supabase support in this order:

1. Add a reusable `Supabase Team` manifest
2. Teach `@master` when to activate it
3. Document the workflow and expected project surface
4. Add validation
5. Only later decide if dedicated Supabase specialist agents are needed

That keeps the shared kit strong and reusable without overfitting too early.
