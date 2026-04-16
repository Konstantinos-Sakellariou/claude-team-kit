# Supabase Team

## Purpose

Default team for Supabase-backed product work spanning schema and migrations, auth and session flows, row-level security, storage access, edge functions, client integration, and release safety.

## Lead

- `@architect` for schema shape, auth boundaries, RLS strategy, and structural platform decisions
- `@senior-developer` for implementation-heavy Supabase integration and function work

## Supporting Agents

- `@security-auditor`
- `@qa-engineer`
- `@code-reviewer`
- `@production-readiness-reviewer`
- `@debugger`
- `@performance-engineer`
- `@risk-officer`
- `@tech-writer`
- `@github-safety-guard`

## Typical Triggers

- Supabase auth or session handling
- schema and migration work
- row-level security policy design or review
- storage bucket and access-rule changes
- edge functions or server-side Supabase integrations
- Supabase client integration
- Supabase rollout, migration safety, or release-risk work

## Default Flow

- inspect the Supabase surface and clarify the project-specific files involved
- design or review the schema, auth, policy, storage, or function shape
- implement or refine the code and configuration
- run mandatory security and QA review for sensitive changes
- run code-quality review for code-affecting paths
- add production-readiness review for migration-heavy, rollout-heavy, or operationally risky changes
- surface findings, risks, and go/no-go guidance through `@master`

## Required Gates

- `@security-auditor` for auth, RLS, storage, and sensitive access changes
- `@qa-engineer` for behavior-changing work
- `@code-reviewer` for code-affecting paths
- `@production-readiness-reviewer` for migration-heavy, merge-critical, or release-heavy Supabase paths
