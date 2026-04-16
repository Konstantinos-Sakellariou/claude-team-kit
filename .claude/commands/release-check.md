# /release-check

## Purpose

Run the Git / GitHub quality and release-readiness path explicitly.

## Owned By

- Lead: `@github-safety-guard`
- Common support: `@privacy-reviewer`, `@risk-officer`, `@changelog-writer`, `@production-readiness-reviewer`
- Team: `Git / GitHub Team`
- Orchestrator: `@master`

## What It Should Do

1. run the relevant safety, privacy, quality, and operational-readiness checks
2. surface blocking findings clearly
3. confirm changelog or release-note status
4. produce a release-governance summary with `READY`, `READY WITH NOTED RISK`, or `NOT READY`

## Output

- release-governance report
