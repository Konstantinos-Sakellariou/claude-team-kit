# Data Team

## Purpose

Default team for analytics, pipelines, metrics, experimentation, and data-trust work that is broader than a single report or script.

## Lead

- `@data-engineer` for ingestion, pipeline, and warehouse-delivery work
- `@analytics-engineer` for semantic-layer, marts, and metrics-modeling work

## Supporting Agents

- `@data-analyst`
- `@experiment-analyst`
- `@data-governance-reviewer`
- `@qa-engineer`
- `@security-auditor`

## Typical Triggers

- ingestion or ETL / ELT pipeline work
- warehouse or mart modeling
- metric-definition cleanup
- KPI, cohort, or trend analysis
- experimentation analysis
- data quality, lineage, or sensitive-data governance review

## Default Flow

- pipeline or model scope clarification
- analytics-ready modeling and metric alignment
- decision analysis or experiment interpretation
- mandatory governance/trust review when the output is decision-critical or sensitive
- optional QA or security review when code or sensitive access is involved

## Required Gates

- `@data-governance-reviewer` before trusting decision-critical datasets, metrics, or analytics outputs
- `@security-auditor` when sensitive data access, private datasets, or policy risk is involved
