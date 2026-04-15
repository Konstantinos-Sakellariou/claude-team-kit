# /save-backlog

## Purpose

Explicitly persist an idea, follow-up, or deferred task into the chosen backlog.

## Owned By

- Lead: `@backlog-updater`
- Orchestrator: `@master`

## What It Should Do

1. confirm the right backlog mode if needed
2. add or update the backlog entry
3. link a plan artifact only when a richer plan is needed and approved

## Output

- backlog update summary
- optional linked plan recommendation
