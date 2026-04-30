# External Skill Repos

This guide explains how external skill repositories should relate to `claude-team-kit`.

The goal is:
- make reusable skill packaging easier
- keep the shared core focused
- give downstream repos a cleaner way to adopt domain skills

The goal is **not**:
- building a skill marketplace inside the kit
- making external skill installation mandatory
- treating every useful skill as core material

## Core Position

The shared core should contain:
- the small set of skills that are broadly useful across many repos
- the skill authoring and governance expectations for the kit itself

External skill repos should carry:
- domain-specific skill bundles
- organization-specific skill packs
- highly specialized workflows that are useful but not generic enough for the core

## What Belongs In The Shared Core

A skill belongs in the core when:
- it is broadly reusable
- it strengthens the main kit experience for many repos
- it does not depend on a niche stack, domain, or organization context
- it is worth maintaining as part of the shared baseline

Examples:
- code review
- bug fixing
- docs writing
- planning or backlog hygiene

## What Belongs In An External Skill Repo

A skill belongs in an external skill repo when:
- it is domain-specific
- it is vendor- or product-specific
- it reflects a narrow team’s way of working
- it is useful, but not generic enough to justify shared-core weight

Examples:
- vertical product workflows
- organization-specific publishing flows
- specialized platform packs
- niche language or framework rituals

## Recommended External Skill Repo Shape

The first public contract should stay simple.

Recommended structure:
- one clear README
- one or more skill directories
- one short install/use story
- examples of when to use each skill
- minimal assumptions about host tooling

The important principle is:
- skills should stay understandable as repo artifacts
- installation should remain optional
- composition should remain explicit

## Relationship To Customization

External skill repos are downstream tools for customization, not part of bootstrap by default.

The flow should be:
1. bootstrap the repo
2. customize the repo
3. notice a stable domain-specific gap
4. add or recommend an external skill repo only if it solves that gap cleanly

That keeps the shared core from absorbing every specialized workflow.

## Relationship To Starter Packs And Solution Packs

Use this split:

- starter packs
  - repo shape

- solution packs
  - stack or product foundation

- external skill repos
  - procedural workflow bundles

They can complement each other, but they should not collapse into the same thing.

## Installation And Discovery Stance

The kit should support a clear stance, not a heavy platform:
- external skill repos may be recommended
- discovery can be documented
- installation can be optional
- the core repo should remain usable without them

Do not assume:
- a universal registry
- automatic install flows
- mandatory external network access

## Comparison To Reviewed Sources

Strongest inspirations:
- `google/skills`
  - installable public skill collections
- `mattpocock/skills`
  - compact, composable, practical skill packaging

Best lesson from both:
- the shared core should define the contract
- external repos can carry the specialization

## Practical Recommendation

Use external skill repos when specialization is real.

Keep the shared core for:
- the most reusable skills
- governance
- authoring expectations
- adaptation guidance

That makes the kit better at reuse and distribution without turning it into a marketplace or bloating the baseline install.
