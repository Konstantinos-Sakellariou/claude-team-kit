# Research And Discovery

This guide defines how `claude-team-kit` should handle external reference reviews without turning the repo into a marketplace, awesome-list, or endless pile of copied ideas.

## Purpose

Use this workflow when the repo needs to learn from:
- external repositories
- tools or libraries
- images or design references
- prompt or workflow examples
- ecosystem or marketplace signals

The goal is not just to summarize what exists.

The goal is to answer:
- what it is
- what is worth borrowing
- what does not fit
- what, if anything, should become backlog work

## Default Workflow

1. define the decision the review should inform
2. inspect the source with a fit lens
3. separate fact from interpretation
4. classify the result:
   - strong fit
   - partial fit
   - inspiration only
   - poor fit
5. save the memo locally if it should outlive the session
6. create backlog follow-up only when the signal is strong enough to justify real work

## Default Team

Use the `Research & Discovery Team` when the request is mostly:
- reference evaluation
- ecosystem scanning
- repo-fit review
- tool-fit review
- image/reference critique with implementation implications

The default lead is:
- `@researcher`

Add:
- `@vision-partner` when the user needs stronger option generation
- `@strategy-reviewer` when a reviewed source may influence roadmap or core direction
- `@backlog-updater` when the result should become deferred work

## Command

Use `/review-reference` when a repeatable review path would help.

This command still runs through `@master`.

## Where To Save Research

Keep durable raw reviews local by default:
- `.claude/local-context/research/`

Good examples:
- repo fit reviews
- tool evaluations
- image or design reference reviews
- ecosystem scans
- marketplace notes

Keep tracked docs for:
- approved public-safe conclusions
- reusable contracts or boundaries
- intentionally shareable guidance

## Suggested Review Shape

Use a compact structure:

- source
- what it is
- strongest borrowable ideas
- best fit with this repo
- cautions
- recommendation
- backlog implications

## Research Boundaries

Do not:
- copy big chunks of external docs into the repo
- turn every interesting repo into a roadmap item
- confuse popularity with fit
- let the shared core become a catalog of agent packs, plugins, or ecosystem links

Prefer:
- local-first capture
- explicit fit judgment
- bounded follow-through
- optional distribution and adapter thinking rather than core bloat
