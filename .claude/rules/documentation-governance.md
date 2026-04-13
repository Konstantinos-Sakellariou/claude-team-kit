# Documentation Governance Rules

## Core Principle
- Keep `README.md`, `CLAUDE.md`, and `AGENTS.md` aligned on repo facts and workflow behavior
- Treat stale documentation as a product bug, not a cosmetic issue

## Core Briefings
- Keep `CLAUDE.md` and `AGENTS.md` high-signal because they are loaded often
- Put only the facts that prevent wrong decisions into always-read briefings
- Move deep detail into linked docs when a topic grows long or specialized
- Remove stale, duplicate, or speculative content instead of piling on more words

## Alignment Rules
- When commands, workflow, structure, agents, teams, or artifact policies change, review all three core docs
- `README.md` is for humans; `CLAUDE.md` and `AGENTS.md` are operational briefings, but repo facts must stay consistent across them
- If a detail differs by audience, keep the difference intentional and minimal

## Writing Rules
- Prefer concise updates over full rewrites
- Label temporary assumptions clearly
- Do not invent certainty just to make docs feel complete
- Use linked docs for examples, workflows, or extended guidance instead of bloating core briefings

## Cleanup Rules
- Delete outdated sections when they no longer serve the repo
- If a section repeats information already maintained elsewhere, summarize and link instead
- If a new doc is added, make sure the core briefings point to it only when it meaningfully improves navigation
