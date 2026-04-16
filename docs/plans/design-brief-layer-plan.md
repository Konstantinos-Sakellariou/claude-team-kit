# Design Brief Layer Plan

## Idea Summary

Explore an optional design-brief layer for repos that want to describe visual direction separately from orchestration and implementation instructions.

## Why This Might Fit

This fits the repo's longer-term vision if `claude-team-kit` is going to help build not just code, but digital products and eventually digital companies.

An optional design layer could help by:
- improving frontend and landing-page consistency
- separating "how it should look" from "how it should be built"
- giving agents a cleaner visual-reference surface than bloating `AGENTS.md` or `CLAUDE.md`

## Why It Should Not Be Core Right Away

This should stay optional because:
- many repos using this kit are not design-heavy
- a required design artifact would burden backend, infra, or workflow-only repos
- the kit should not become frontend-biased by default

## Recommended Model

If pursued, use a structure similar to the backlog, roadmap, and vision model:
- tracked public template such as `DESIGN.example.md`
- optional local or repo-specific `DESIGN.md`
- clear guidance on when it belongs in tracked history versus local/private notes

## What It Should Cover

A good design brief would likely include:
- visual mood and tone
- typography direction
- layout and density preferences
- component style
- motion and interaction expectations
- examples of what to emulate or avoid

## What It Should Not Cover

It should not:
- replace product requirements
- replace engineering instructions
- replace accessibility, testing, or implementation rules
- become a giant design dump loaded in every task by default

## Rollout Path

### Phase 1

- document the concept only
- decide whether the artifact should be tracked, local, or hybrid
- define when `@master` should consult it

### Phase 2

- add a template if the concept still looks useful
- document how it interacts with frontend/design tasks
- optionally add a design-oriented workflow or team later

## Value Test

This is worth implementing only if it clearly:
- improves frontend output quality
- reduces repeated design prompting
- stays optional and low-friction
- fits the broader product-building vision

## Recommendation

Keep this as a horizon item.

It fits the vision, but only as an optional layer introduced after the core operating model is more mature.
