---
name: repo-cleanup
description: Audit a copied repo for generic kit leftovers, then recommend or perform a safe keep/customize/delete cleanup pass once project-specific docs are in place.
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
model: sonnet
argument-hint: [repo area or copied-kit cleanup target]
---

Run a repo cleanup pass for: $ARGUMENTS

## Cleanup Goal

Help a repo that copied `claude-team-kit` stop looking like a generic template and start looking like its own project.

Use this skill after bootstrap or after a repo has enough real project context to decide what generic kit leftovers are still useful.

## Cleanup Workflow

### Step 1: Inspect the current project-specific briefings
- Read `README.md`, `CLAUDE.md`, and `AGENTS.md`
- Confirm whether they already look meaningfully customized
- If the repo is still underdefined, recommend bootstrap or guided initialization first instead of cleanup

### Step 2: Inventory likely template leftovers
Check for files or sections that may still be generic, such as:
- starter backlog files
- example plan artifacts
- generic project descriptions
- template sections that no longer match the repo
- duplicated documentation that exists only because the kit was copied verbatim

### Step 3: Classify each item
For each candidate, decide:
- `Keep`
- `Customize`
- `Delete`

Only recommend `Delete` when the item is clearly no longer useful and no longer referenced.

### Step 4: Check references before removing anything
- Search for links or mentions in `README.md`, `CLAUDE.md`, `AGENTS.md`, docs, scripts, and tests
- Do not remove files that still participate in repo behavior unless you also update the references

### Step 5: Make or recommend the smallest safe cleanup
- Prefer surgical edits over broad deletion
- Prefer replacing generic text with repo-specific text when the file structure is still useful
- Prefer removing pure template leftovers rather than letting them confuse future users

## Output Format

```md
## Repo Cleanup Report

### Cleanup Readiness
[Ready now / Bootstrap first / Need more project context]

### Keep
- ...

### Customize
- [file]: ...

### Delete
- [file]: ...

### Safe Next Steps
1. ...
2. ...
3. ...
```

## Editing Rule

If the user asked you to actually perform cleanup:
- update references together with the cleanup
- do not delete tracked files without clearly accounting for why
- keep the repo-specific docs stronger after cleanup than before

## Guardrails

- Do not treat every example file as automatically disposable
- Do not remove useful infrastructure because it looks generic at first glance
- Cleanup is successful only if the repo becomes clearer, not merely smaller
