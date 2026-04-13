# Artifact Governance Rules

## Core Principle
- Put information where it will stay useful, reviewable, and appropriately private

## Artifact Selection
- Use chat for early exploration and lightweight discussion
- Use `BACKLOG.md` for private local deferred work
- Use `docs/BACKLOG.md` only when the repo wants a tracked public backlog
- Use `docs/plans/` for approved execution plans and structured implementation artifacts
- Use `docs/adr/` for approved architecture, workflow, or policy decisions that should remain traceable
- Use `.claude/local-context/` for private local business, customer, or strategy context that should not be tracked by default

## Approval Rules
- Ask before saving anything into `docs/plans/` or `docs/adr/`
- Ask which backlog mode to use if the repo preference is unknown
- Do not change a backlog item's status unless the user explicitly asked for it

## Planning Rules
- For substantial deferred work, prefer a backlog entry plus a linked plan rather than a backlog row alone
- Keep backlog rows compact and use linked artifacts for the step-by-step details
- Treat durable decisions as ADR candidates by default

## Privacy Rules
- Keep private local context out of tracked docs unless the user explicitly approves promotion
- Keep sensitive local notes, secrets, and company context out of public artifacts
- When in doubt, choose the safer local artifact first and ask before broadening disclosure
