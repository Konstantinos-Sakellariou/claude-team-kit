# /write-adr

## Purpose

Trigger the ADR flow explicitly when a durable architecture, workflow, or policy decision should be recorded.

## Owned By

- Lead: `@master`
- Common support: `@architect`, `@devils-advocate`, `@judge`, `@tech-writer`

## What It Should Do

1. confirm the decision is ADR-worthy
2. gather the reasoning and alternatives
3. ask approval before saving
4. create the ADR in the canonical format

## Output

- ADR recommendation
- optional ADR artifact after approval
