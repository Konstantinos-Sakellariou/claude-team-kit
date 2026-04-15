# Repo Cleanup Rules

## Goal

After this kit is copied into a real repo and the project-specific briefings are created, clean up the generic leftovers that no longer help that repo.

The objective is not to delete documentation aggressively.
The objective is to:
- keep what is useful
- customize what should become repo-specific
- remove what is still generic noise

## Cleanup Principle

A copied repo should not keep generic kit scaffolding forever just because it shipped with the template.

Once the project has:
- a real `CLAUDE.md`
- a real `AGENTS.md`
- a real `README.md`
- enough context to operate safely

then the repo should review whether any kit-origin files, examples, or placeholders should be:
- kept
- customized
- moved
- deleted

## What To Review

Common cleanup targets:
- example backlog files
- example plan artifacts
- generic starter docs that are no longer useful
- duplicate explanatory text that only made sense during bootstrap
- temporary placeholder sections
- repo-specific docs that still describe the kit instead of the actual project

## Decision Rules

### Keep

Keep files when they remain useful as:
- reusable workspace infrastructure
- templates the project still intends to use
- canonical documentation for real repo behavior

### Customize

Customize files when the structure is useful but the content is still too generic.

Typical examples:
- `README.md`
- `CLAUDE.md`
- `AGENTS.md`
- project-specific workflow docs

### Delete

Delete files when they are:
- generic leftovers from the kit
- duplicated elsewhere
- no longer referenced
- likely to confuse future users or agents

## Guardrails

- Do not delete tracked files silently; surface the recommendation first
- Prefer a review list with `keep / customize / delete` decisions instead of acting blindly
- Keep the repo operational after cleanup; do not remove files that the repo still references
- If a file is only useful as a local example during setup, either remove it or replace it with a clearer repo-specific artifact

## Ideal Outcome

After cleanup, the repo should feel:
- specific to the project
- free of obvious template leftovers
- still well-documented
- easier for humans and agents to trust
