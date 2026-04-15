# /release-check

## Purpose

Run the Git / GitHub quality and release-readiness path explicitly.

## Owned By

- Lead: `@github-safety-guard`
- Common support: `@privacy-reviewer`, `@risk-officer`, `@changelog-writer`, `@production-readiness-reviewer`
- Team: `Git / GitHub Team`
- Orchestrator: `@master`

## What It Should Do

1. run the relevant safety and readiness checks
2. surface blocking findings clearly
3. produce a go / no-go style summary

## Output

- release or push-readiness report
