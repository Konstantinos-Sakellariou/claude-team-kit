# Context Efficiency Rules

## Core Principle
- Protect context quality and token efficiency without cutting away information the task actually needs

## Scope Discipline
- Read narrow first
- Widen scope only when the evidence says the task needs it
- Prefer exact files, errors, diffs, and artifacts over vague repo-wide sweeps

## Large Inputs
- Triage logs before reading them in full
- Inspect diff summaries before full diff bodies
- Inspect schema, headers, keys, or sample rows before full structured payloads
- Read relevant functions or sections before full large files

## Durable Context
- Prefer `BACKLOG.md`, `docs/plans/`, `docs/adr/`, and `.claude/local-context/` over rebuilding the same context from chat repeatedly
- Keep `CLAUDE.md` and `AGENTS.md` concise and linked to deeper docs when needed
- Use durable artifacts to preserve decisions instead of relying on long recap messages

## Tooling Discipline
- Prefer local CLI tools over equivalent MCP tools when the task is solved cleanly that way
- Use only the MCP servers and tools the task actually needs
- If an optional local efficiency tool is installed, use it only when it helps the task instead of assuming it should always be on

## User Guidance
- If a request is broad, help narrow it before exploring everything
- Ask for exact paths, errors, expected output, or constraints when that will materially improve the result
