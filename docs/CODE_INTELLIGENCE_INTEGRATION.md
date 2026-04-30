# Code-Intelligence Integration

`claude-team-kit` is intentionally file-first and markdown-first by default.

That means normal repo work should still start with:
- `README.md`
- `CLAUDE.md`
- `AGENTS.md`
- grep / `rg`
- local CLI inspection
- the existing artifact model

This document defines when an **optional code-intelligence layer** may be worth considering, how it differs from graph/repo intelligence, and what should remain outside the shared core.

## Core Position

Optional code intelligence is about code-aware understanding such as:
- symbol lookup
- dependency lookup
- structural search
- retrieval over code artifacts
- richer repo exploration for larger codebases

It is **not**:
- a required dependency
- a built-in indexing engine
- a replacement for normal repo reading
- justification to turn the kit into a runtime product

## Relationship Layer Versus Code Layer

Keep this distinction explicit:

- graph/repo intelligence
  - artifact relationships
  - docs, plans, backlog, ADRs, workflows, teams
  - “what belongs together?”

- code intelligence
  - implementation-aware search and structure
  - symbols, modules, dependencies, code paths, retrieval
  - “where is this implemented and what code connects to it?”

If the question is mainly about artifact relationships, use `docs/GRAPH_INTELLIGENCE.md`.

If the question is mainly about implementation structure, this is the right optional layer to consider.

## What Problems This Could Solve

An optional code-intelligence layer may help when the repo has grown beyond what normal file-first exploration handles comfortably.

Examples:
- locating the real implementation behind a concept or capability
- understanding which modules depend on a changing area
- retrieving the most relevant code artifacts for a large task
- improving multi-agent shared context in a large codebase
- supporting future app-backed exploration or repo-understanding surfaces

## What Should Stay In The Core

The shared core should continue to provide:
- repo briefings
- commands
- skills
- rules
- context-efficiency guidance
- graph/repo relationship guidance
- docs describing when optional integrations are worth using

The core should **not** provide:
- a bundled code index
- a vector database
- a required symbol server
- a mandatory dependency graph backend

## Boundary Model

Use this split:

### Layer 1 — Shared Core

The kit itself:
- docs
- prompts
- commands
- skills
- rules
- workflow guidance

### Layer 2 — Optional Adapter

A thin integration contract, if ever justified:
- what kinds of code-aware lookup are exposed
- how `@master` or future tools should reason about them
- where results should be summarized rather than dumped raw

### Layer 3 — External Tooling

The actual heavy lifting stays outside the shared core:
- indexing
- retrieval
- symbol extraction
- dependency analysis
- graph backends

## Decision Table

| Repo Shape | Default Recommendation | Why |
|---|---|---|
| Small repo | Do not add code intelligence | `rg`, docs, and normal repo reading are enough |
| Medium repo | Stay docs-first unless search pain is becoming repetitive | avoid premature complexity |
| Large repo | Consider an optional integration path | implementation search and dependency understanding may become expensive manually |
| Multi-agent heavy repo | Consider optional summarized lookup surfaces | helps shared context if the repo is genuinely large or structurally dense |
| Future app-backed exploration surface | Strongest fit for optional integration | this is where code-aware lookup may justify a real adapter boundary |

## When This Layer Is Worth It

Reach for optional code intelligence only when one or more of these are true:
- repeated implementation lookup is slowing work down
- symbol or dependency questions are frequent and costly to answer manually
- large-repo tasks require multiple agents to share tighter code context
- a future app or operator surface needs code-aware exploration

Do not reach for it when:
- the repo is still comfortably explorable with current tools
- the problem is really docs or artifact navigation instead of code understanding
- the integration would introduce more maintenance than leverage
- the real need is better briefing quality, not better indexing

## Best First Public Output

For this repo, the best first output is documentation and a boundary contract:
- explain what optional code intelligence means
- explain when it is worth considering
- explain what belongs outside the shared core

That is enough to help downstream repos make better decisions without forcing any runtime commitment here.

The first concrete example path now lives in:
- `docs/CODE_REVIEW_GRAPH_ADAPTER_EXAMPLE.md`

## Possible Future Adapter Shape

If the value becomes real later, a future optional adapter could expose:
- symbol lookup
- dependency/usage lookup
- code-aware retrieval
- repository exploration summaries

But even then, the adapter should stay:
- optional
- host-aware
- summarization-friendly
- auditable

## Practical Recommendation

Use the current repo model by default.

Only consider optional code-intelligence integration when:
- repo size
- implementation complexity
- or future interactive tooling

make normal file-first exploration no longer sufficient.

Until then:
- keep the core lightweight
- keep the boundary explicit
- keep the heavy intelligence work external
