# Graph And Repo-Intelligence Option Plan

## Idea Summary

Explore whether `claude-team-kit` should support an optional graph-oriented repo-intelligence layer for deeper structural understanding of large or complex repos.

## Why This Might Fit

This fits the repo's long-term direction if the kit evolves toward:
- stronger repo understanding
- better context compression
- richer memory and intelligence layers
- future product surfaces for navigating and operating on complex codebases

It is especially aligned with:
- `context-audit`
- `triage-input`
- bootstrap and guided initialization
- future graph/memory/productization phases

## Why It Should Stay Optional

This should not become a core dependency because:
- the shared kit should remain lightweight
- many repos do not need a graph/index layer
- graph tooling can introduce significant complexity and setup cost
- the kit should not lock users into one intelligence backend too early

## Potential Value

An optional graph/repo-intelligence layer could help with:
- large-repo onboarding
- finding structural relationships quickly
- impact analysis
- better bootstrap/context discovery
- future productized exploration or graph-RAG workflows

## Potential Integration Surfaces

If pursued later, likely connection points are:
- `@master` for repo-understanding assistance
- `context-audit` for structural drift or doc/context mismatch
- bootstrap for understanding a copied repo faster
- future app/product surfaces or MCP-connected intelligence tools

## Rollout Path

### Phase 1

- keep it research-only
- clarify what problem this solves that grep, docs, and current workflows do not
- define optional integration boundaries

### Phase 2

- document a possible optional integration
- decide whether the fit is:
  - docs-only recommendation
  - local optional tooling
  - future product feature

### Phase 3

- only then consider a lightweight integration experiment

## Value Test

This is worth implementing only if it clearly:
- improves repo understanding beyond existing tools
- strengthens context efficiency
- stays optional
- fits the roadmap's intelligence/productization phase rather than bloating the near-term core

## Recommendation

Keep this as a future-facing optional integration track.

It fits the vision and roadmap, but not as near-term core infrastructure.
