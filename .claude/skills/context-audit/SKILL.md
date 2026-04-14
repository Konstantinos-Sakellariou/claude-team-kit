---
name: context-audit
description: Audit the repo's working context. Reviews README, CLAUDE, AGENTS, and linked docs for drift, missing facts, bloat, privacy-boundary mistakes, and weak briefing quality.
allowed-tools: Read, Bash, Glob, Grep
model: sonnet
argument-hint: [repo area, docs set, or context problem to audit]
---

Run a context audit for: $ARGUMENTS

## Audit Goal

Determine whether the repo's working context is healthy enough for agents to make good decisions without wasted exploration or stale assumptions.

## Audit Workflow

### Step 1: Inspect the core briefings
- Read `README.md`, `CLAUDE.md`, and `AGENTS.md`
- Identify whether they agree on:
  - project identity
  - workflow behavior
  - commands
  - architecture facts
  - privacy and artifact rules

### Step 2: Inspect linked support docs
- Read only the linked docs that materially affect the audit
- Prefer:
  - `docs/ARCHITECTURE.md`
  - `docs/BOOTSTRAP.md`
  - `docs/CONTEXT_EFFICIENCY.md`
  - `docs/LOCAL_CONTEXT.md`
  - `docs/PROJECT_CUSTOMIZATION.md`
- Include other docs only if the current problem depends on them

### Step 3: Check for context health issues
Look for:
- drift between `README.md`, `CLAUDE.md`, and `AGENTS.md`
- always-loaded briefings that are too long, vague, or repetitive
- important project facts missing from the core briefings
- information stored in chat that should instead live in docs or artifacts
- public/private boundary mistakes
- weak bootstrap outcomes in a new repo

### Step 4: Classify findings
Organize findings into:
- aligned and healthy
- drifting or stale
- missing
- too detailed for core briefings
- should move to local-only context

### Step 5: Recommend the smallest useful fix
- Prefer focused doc updates over full rewrites
- Prefer linked docs over bloating core briefings
- Prefer artifact placement fixes when the issue is about where information lives

## Output Format

```md
## Context Audit Report

### Overall Health
[Healthy / Needs attention / Underdefined]

### What Is Working
- ...

### Drift Or Risk Areas
- ...

### Missing Context
- ...

### Context Bloat
- ...

### Privacy / Artifact Boundary Notes
- ...

### Recommended Fixes
1. ...
2. ...
3. ...
```

## Guardrails
- Do not rewrite docs unless the user asked for edits
- Keep the audit evidence-based and repo-specific
- Prefer concrete file references over vague criticism
