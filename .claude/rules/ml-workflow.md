# AI/ML Workflow Rules

## Problem Framing
- Do not start model work without a clear target, success metric, and baseline.
- Prefer the simplest approach that can credibly solve the problem.
- Separate business goals from modeling objectives explicitly.

## Data Discipline
- Prevent leakage: no future information or target proxies in training features.
- Keep train, validation, and test responsibilities clear; never tune on the holdout set.
- Record dataset or snapshot versions whenever results are being compared or handed off.

## Experiment Rigor
- Log runs with enough detail to reproduce them later: data version, config, metrics, artifacts, and code reference.
- Use appropriate evaluation strategy for the problem shape: temporal splits for time-based data, stratification when class balance matters.
- Report uncertainty or stability where relevant, not only a single headline number.

## Model Development
- Baselines come first: heuristic, simple statistical, or simple ML baselines should set the bar.
- Document feature rationale and remove unnecessary complexity when lift is marginal.
- Keep pipelines config-driven and reproducible rather than hardcoded and ad hoc.

## Evaluation
- Compare candidates against baselines or incumbents, not against aspiration alone.
- Check subgroup performance, likely failure modes, and practical trade-offs.
- Treat fairness, explainability, robustness, and drift risk as release criteria when they matter to the use case.
- No model should be treated as production-ready without independent review from `@model-evaluator`.

## Deployment Readiness
- No deployment without a monitoring plan and rollback conditions.
- Rollouts should be staged when risk justifies it: shadow, canary, or equivalent progressive release.
- Production model changes must preserve artifact, dependency, and version traceability.

## Documentation
- Record assumptions, evaluation boundaries, and known limitations.
- Update the relevant docs if AI/ML workflow expectations change at the repo level.
