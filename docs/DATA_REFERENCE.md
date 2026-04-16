# Data Reference

## What The Data Team Is

The `Data Team` is the reusable domain pack for data-heavy work that is not primarily model-training work.

It covers areas like:
- ingestion and pipeline reliability
- warehouse and mart modeling
- semantic metric definitions
- KPI and trend analysis
- experiment interpretation
- data quality, lineage, access, and governance review

## Why A Data Team Is Needed

Data work often gets squeezed into either:
- generic engineering
- or generic AI/ML

That is usually not enough.

Many real product and company workflows need a separate layer for:
- warehouse and metric trust
- analytics-ready datasets
- business-facing analysis
- experiments and decision support
- governance and privacy around data access

The `Data Team` gives `@master` a reusable coordination model for that middle ground.

## How It Relates To The AI/ML Team

Use the `Data Team` when the work is mainly about:
- pipelines
- warehouse structure
- analytics datasets
- KPIs
- reporting
- experimentation
- governance

Use the `AI/ML Team` when the work is mainly about:
- model framing
- training
- evaluation
- deployment-minded ML conclusions

Sometimes both teams are useful in the same request.
For example:
- `Data Team` prepares trustworthy datasets and metrics
- `AI/ML Team` frames and evaluates the model work built on top

## Expected Project Surface

Real data-heavy repos often have some version of:
- ingestion or pipeline code
- transformation or modeling layers
- warehouse schemas or marts
- reporting or metric definitions
- experiment logs or KPI dashboards
- quality checks and lineage notes

The shared kit stays generic.
Project-specific warehouse schemas, tooling choices, model layers, and compliance rules should live in the copied repo briefing.
