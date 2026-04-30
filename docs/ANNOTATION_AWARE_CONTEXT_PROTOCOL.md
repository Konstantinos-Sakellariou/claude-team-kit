# Annotation-Aware Context Protocol

This document evaluates whether mature customized repos should ever adopt a lightweight annotation-aware coordination protocol inspired by ideas such as `codedna`.

The answer is:
- possibly useful
- definitely optional
- not ready to be a default repo pattern

## Purpose

The goal is to evaluate whether carefully bounded annotations could help:
- reduce repeated rediscovery
- preserve local coordination hints
- support multi-agent work in large, high-context codebases

The goal is **not**:
- annotating everything
- replacing normal comments or docs
- creating a second documentation layer by accident

## Core Position

This should remain an evaluation boundary, not a rollout plan.

Only mature customized repos with genuine repeated context loss should even consider it.

For most repos, clearer briefings, better project DNA, better plans, or better code-intelligence tooling are the higher-value answer first.

## What A Protocol In This Class Might Add

Potential value:
- local “read this before changing” signals
- stable coordination hints around risky modules
- explicit verification cues
- lighter rediscovery cost for repeated or parallel work

Potential forms:
- module-level notes
- narrow structured tags
- coordination metadata near high-context code

## Where It Must Stay Distinct

If a repo adopts something in this class, it must remain clearly different from:

- normal code comments
  - implementation explanation

- docs
  - broader human-facing understanding

- project DNA
  - durable repo identity and assumptions

- code-intelligence tools
  - structural search, retrieval, and dependency lookup

- `HANDOFF.md`
  - short-lived session continuity

## Main Risks

This kind of protocol becomes bad quickly when:
- annotations spread everywhere
- nobody prunes stale entries
- comments and annotations duplicate each other
- the repo carries more annotation debt than useful signal
- agents start trusting annotations more than code reality

The biggest danger is not technical complexity.

It is **signal decay**.

## Adoption Threshold

Only consider it when all of these are true:
- the repo is mature and heavily customized
- repeated context loss is real and expensive
- existing docs, project DNA, and code-intelligence approaches are still insufficient
- the team can keep the annotation surface narrow and maintained

If those conditions are not true, do not adopt it.

## Allowed Scope If Ever Tried

If a repo experiments with this later, keep the scope narrow:
- only high-context areas
- only a few annotation types
- only where repeated coordination pain is already proven

Do not:
- standardize it repo-wide immediately
- apply it to every file
- treat it as part of the default kit

## Evaluation Against Current Alternatives

Before trying an annotation-aware protocol, check whether the real need is better solved by:
- tighter `CLAUDE.md` / `AGENTS.md`
- a local `project-dna.md`
- better plans
- a better `HANDOFF.md`
- optional code-intelligence adapters

If one of those solves the problem more cleanly, prefer it.

## Practical Recommendation

Do not adopt an annotation-aware protocol in the shared core.

Keep it as:
- a bounded evaluation
- a mature-repo option
- a last-step coordination aid only when lighter surfaces are no longer enough

That preserves the idea without creating annotation debt across normal repos.
