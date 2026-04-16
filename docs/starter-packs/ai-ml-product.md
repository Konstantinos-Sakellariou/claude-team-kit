# AI/ML Product Starter Pack

## Best For

- model-backed product features
- evaluation-heavy AI applications
- experimentation-heavy product repos
- data and model workflow projects

## Customize Early

Add to `CLAUDE.md` and `AGENTS.md`:
- what the model or ML feature does
- data sources and feature boundaries
- evaluation criteria and release gates
- offline vs online validation expectations
- monitoring and rollback expectations
- where prompt, model, or dataset artifacts live

## Team Emphasis

Common recurring team and agent patterns:
- `AI/ML Team`
- `Engineering Team`
- `Git / GitHub Team`
- `@model-evaluator` as the mandatory quality gate for release-readiness
- `@mlops-engineer` for deployment and monitoring
- `@research-scientist` when method or benchmark choices are novel

## Local Context Suggestions

Useful local-only notes often include:
- customer pain points behind the ML feature
- benchmark tradeoffs and target metrics
- private model/provider comparisons
- internal quality concerns not ready for public docs

## Common Gotchas To Document

- eval sets and acceptance thresholds
- prompt or model versioning assumptions
- fallback behavior
- human-review boundaries
- cost and latency constraints

## Cleanup Signal

Once the repo has a real data/model/evaluation briefing, remove generic kit text that hides the actual ML operating model.
