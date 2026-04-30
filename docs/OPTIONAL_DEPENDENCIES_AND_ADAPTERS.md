# Optional Dependencies And Adapters

`claude-team-kit` should stay dependency-light by default.

This guide defines how the repo should evaluate external repos, tools, or integration surfaces before treating them as something stronger than inspiration.

The goal is:
- keep the shared core lightweight
- make room for high-value optional integrations
- avoid accidental runtime creep

The goal is **not**:
- banning all external tooling
- pretending useful adapters should never exist
- turning the shared kit into a dependency hub

## Core Position

The default stance is:
- shared core first
- optional adapters second
- hard dependencies rarely

Most reviewed repos should influence:
- docs
- workflow contracts
- adapter guidance

not the required dependency graph of the shared core.

## Classification Model

Use one of these four classifications for external repos or tools:

### 1. Required Dependency

Use only when all of these are true:
- the core repo cannot deliver its intended behavior without it
- the dependency is stable and low-risk enough for broad reuse
- removing it would break the shared kit model itself
- the maintenance cost is justified across most users

This should be rare.

### 2. Optional Adapter

Use when:
- the external tool clearly improves a specific advanced workflow
- the shared core still works without it
- the integration can stay removable
- the value is real enough to justify a documented example path

This is the preferred model for stronger external integrations.

### 3. Packaging / Distribution Inspiration

Use when:
- the main value is installability, structure, or composability
- the repo teaches us how to package reusable assets better
- there is no need to depend on it directly

### 4. Inspiration Only

Use when:
- the repo is strategically interesting
- but not a good fit for the shared core boundary
- or the value belongs in a downstream product repo instead

## Admission Criteria For Any New External Dependency

Before anything becomes stronger than inspiration, it must pass these checks:

1. clear user value
2. bounded scope
3. removability
4. maintainability
5. no shared-core identity drift

Meaning:
- the benefit must be concrete
- the integration must stay understandable
- removing it must not break normal kit use
- the maintenance burden must be acceptable
- the repo must remain markdown-first and `.claude/`-first

## Current Classification Of Reviewed Repos

| Source | Classification | Why |
|---|---|---|
| `tirth8205/code-review-graph` | optional adapter | strongest concrete code-intelligence example that can stay external and removable |
| `google/skills` | packaging / distribution inspiration | strong external skill-repo and installability model, but not a core runtime dependency |
| `mattpocock/skills` | packaging / distribution inspiration | strong composable skill-packaging model, but not a shared-core dependency |
| `Larens94/codedna` | inspiration for protocol evaluation | interesting annotation protocol idea, but should be evaluated as a bounded pattern rather than adopted as a dependency |
| `zubair-trabzada/ai-sales-team-claude` | inspiration only | useful downstream vertical-pack packaging example, not a shared-core dependency |
| `aaronjmars/MiroShark` | inspiration only | too runtime-heavy and product-specific for this repo |

## What This Means In Practice

The shared kit should prefer:
- one policy doc
- one optional adapter example
- one packaging/distribution contract
- one bounded protocol evaluation

over:
- installing many third-party tools
- vendoring external repo logic into `.claude/`
- treating every good idea as a dependency candidate

## Relationship To Existing Boundaries

This document works with:
- `docs/CROSS_TOOL_PORTABILITY.md`
- `docs/CODE_INTELLIGENCE_INTEGRATION.md`
- `docs/GRAPH_INTELLIGENCE.md`
- `docs/PROJECT_DNA_AND_STATE.md`

The split is:
- portability = how host adapters should behave
- code intelligence = when code-aware lookup is worth it
- optional dependencies = what level of adoption an external repo deserves
- project DNA = how mature customized repos hold durable identity

## Practical Recommendation

When reviewing a strong external repo:
1. do not start by asking “should we depend on it?”
2. first classify it
3. prefer optional adapter or inspiration-only when possible
4. only add a hard dependency when the shared core genuinely needs it

That keeps `claude-team-kit` extensible without turning it into a pile of borrowed runtime assumptions.
