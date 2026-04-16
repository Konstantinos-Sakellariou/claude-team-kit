# SaaS App Starter Pack

## Best For

- product apps with authenticated users
- dashboards and settings-heavy products
- billing or subscription-aware products
- admin, support, or internal tooling surfaces

## Customize Early

Add to `CLAUDE.md` and `AGENTS.md`:
- route or page inventory
- auth model and role assumptions
- billing or plan boundaries
- public vs logged-in experience
- support/admin-only surfaces
- environment-specific behavior such as staging or demo mode

## Team Emphasis

Common recurring team and agent patterns:
- `Engineering Team`
- `Git / GitHub Team`
- `Supabase Team` if auth, RLS, storage, or edge functions are involved
- `@customer-advocate` for UX-sensitive flows
- `@security-auditor` for auth, billing, or external input

## Local Context Suggestions

Useful local-only notes often include:
- ICP or target customer segments
- pricing or packaging constraints
- launch priorities
- sensitive roadmap or GTM notes

## Common Gotchas To Document

- route protection rules
- onboarding or trial assumptions
- subscription gating
- internal-only tools
- email, webhook, or background-job boundaries

## Cleanup Signal

Once the repo has real page, auth, and product briefings, remove or customize generic kit text that still sounds like a template.
