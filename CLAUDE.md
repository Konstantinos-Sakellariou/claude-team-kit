# Project Context
<!-- CUSTOMIZE THIS SECTION per project -->
Project: [PROJECT NAME]
Description: [What this project does in 1-2 sentences]
Owner: Konstantinos Sakellariou

## Stack
- Language(s): [e.g. Python 3.11 + TypeScript 5]
- Framework(s): [e.g. FastAPI + React/Next.js]
- Database: [e.g. PostgreSQL + Redis]
- Testing: [e.g. pytest + Jest]
- Package manager: [e.g. pip/poetry + npm/pnpm]

## Architecture
<!-- Brief description or link -->
- See @docs/ARCHITECTURE.md (create if needed)
- API: [REST / GraphQL / gRPC] at [base path]
- Key directories: src/, tests/, docs/, scripts/

## Commands
<!-- Customize these -->
- Start dev:    `[command]`
- Run tests:    `[command]`
- Lint:         `[command]`
- Build:        `[command]`
- Deploy:       `[command]`

## Environment
- Copy `.env.example` → `.env.local` before starting
- Required env vars: [list them]

---

# Standing Instructions

## Code Style
@.claude/rules/code-quality.md

## Python Rules
@.claude/rules/python.md

## TypeScript Rules
@.claude/rules/typescript.md

## Security Rules
@.claude/rules/security.md

## Testing Rules
@.claude/rules/testing.md

## Git Workflow
@.claude/rules/git-workflow.md

## Performance Rules
@.claude/rules/performance.md

## API Design
@.claude/rules/api-design.md

---

# Team

You have access to a full professional team via @agent-name or /skill-name.
Use them proactively — don't wait to be asked. If a task touches security,
call @security-auditor. If a decision has business implications, pull in
@business-analyst or @judge. If something feels off, ask @devils-advocate.

## When to delegate automatically:
- Any auth / payments / data handling → @security-auditor reviews it
- Any new feature → @qa-engineer writes the test plan
- Any architectural decision → @architect weighs in
- Any public API change → @customer-advocate checks the UX impact
- Any performance-sensitive path → @performance-engineer reviews it
- Any major commit or release → @risk-officer does a final check

---

# Important Notes
<!-- Add project-specific gotchas here as you discover them -->
- [Add gotchas as you find them]
