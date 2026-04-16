# API Service Starter Pack

## Best For

- backend services
- webhook processors
- internal platform APIs
- integration-heavy service repos

## Customize Early

Add to `CLAUDE.md` and `AGENTS.md`:
- endpoint or contract overview
- job, queue, or worker boundaries
- deployment/runtime assumptions
- env and secret handling rules
- observability and alerting expectations
- rollback or migration sensitivity

## Team Emphasis

Common recurring team and agent patterns:
- `Engineering Team`
- `Git / GitHub Team`
- `@security-auditor`
- `@performance-engineer`
- `@production-readiness-reviewer`
- `@risk-officer` for migration or rollout-heavy work

## Local Context Suggestions

Useful local-only notes often include:
- partner or customer integration constraints
- SLA or support expectations
- operational incidents to remember
- private rollout plans

## Common Gotchas To Document

- backward-compatibility rules
- webhook retry/idempotency behavior
- service-to-service auth assumptions
- data retention or privacy boundaries
- migration and rollback procedures

## Cleanup Signal

Once the repo has real contracts, deploy rules, and operational notes, prune generic template wording that no longer helps service work.
