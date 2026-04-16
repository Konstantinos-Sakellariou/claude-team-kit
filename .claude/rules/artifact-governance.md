# Artifact Governance Rules

## Core Principle
- Put information where it will stay useful, reviewable, and appropriately private

## Artifact Selection
- Use chat for early exploration and lightweight discussion
- Use `BACKLOG.md` for private local deferred work
- Use `docs/BACKLOG.md` only when the repo wants a tracked public backlog
- Use `docs/plans/` sparingly for approved public-safe example plans, reusable reference plans, or implementation artifacts that are intentionally safe to publish
- Use `.claude/local-context/plans/` for private strategy, roadmap, phase, or company-operating plans that should stay local
- Use `docs/adr/` for approved architecture, workflow, or policy decisions that should remain traceable
- Use `.claude/local-context/` for private local business, customer, or strategy context that should not be tracked by default

## Approval Rules
- Ask before saving anything into `docs/plans/` or `docs/adr/`
- Ask whether a plan should be tracked or local when that visibility choice is not already clear
- Ask which backlog mode to use if the repo preference is unknown
- Do not change a backlog item's status unless the user explicitly asked for it

## Planning Rules
- For substantial deferred work, prefer a backlog entry plus a linked plan rather than a backlog row alone
- Keep backlog rows compact and use linked artifacts for the step-by-step details
- If the plan is reusable, example-like, or intentionally public-safe, use `docs/plans/`
- If the plan contains real strategy, roadmap sequencing, company direction, or private operating detail, keep it under `.claude/local-context/plans/`
- If you are unsure, prefer the safer local plan first and ask before broadening it into tracked history
- Treat durable decisions as ADR candidates by default

## Privacy Rules
- Keep private local context out of tracked docs unless the user explicitly approves promotion
- Keep sensitive local notes, secrets, and company context out of public artifacts
- When in doubt, choose the safer local artifact first and ask before broadening disclosure
