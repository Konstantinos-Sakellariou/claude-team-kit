# /bootstrap-repo

## Purpose

Explicitly trigger the new-repo bootstrap flow when a repo still looks generic or underdefined.

## Owned By

- Lead: `@master`
- Common support: `@tech-writer`, `@architect`

## What It Should Do

1. check whether bootstrap is actually needed
2. ask a short structured question set if needed
3. use guided initialization when the repo is still underdefined
4. strengthen `CLAUDE.md`, `AGENTS.md`, and `README.md` as needed

## Output

- a visible bootstrap summary
- stronger repo briefings when the repo needed them

## Notes

- do not use this to interrupt tiny tactical work unnecessarily
- if the repo is already well configured, say so and stop
