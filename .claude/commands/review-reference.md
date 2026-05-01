# /review-reference

## Purpose

Run a repeatable reference-review workflow for an external repo, tool, article, image, benchmark, or ecosystem signal.

## Owned By

- Lead: `@researcher` or `Research & Discovery Team`
- Common support: `@vision-partner`, `@strategy-reviewer`, `@tech-writer`, `@backlog-updater`
- Orchestrator: `@master`

## What It Should Do

1. clarify what decision the review should inform
2. evaluate the source with a fit lens, not just summarize it
3. classify it as strong fit, partial fit, inspiration only, or poor fit
4. capture the result locally under `.claude/local-context/research/` when it should persist
5. recommend backlog-only or backlog-plus-follow-up only when the finding deserves real work

## Output

- reference-review memo
- fit recommendation
- optional backlog recommendation
