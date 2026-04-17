# /sync-docs

## Purpose

Explicitly run the documentation-alignment step across the core briefings and other named sync targets, especially when doc drift was deferred earlier or the user wants a deliberate doc-impact gate and sync pass now.

## Owned By

- Lead: `@workspace-updater`
- Orchestrator: `@master`

## What It Should Do

1. review `README.md`, `CLAUDE.md`, and `AGENTS.md`
2. review any explicitly named sync targets
3. assess doc impact and deferred drift explicitly
4. update only what is needed

## Output

- documentation alignment summary
- doc-impact outcome
