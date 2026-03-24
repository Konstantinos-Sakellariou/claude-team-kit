---
name: create-pr
description: Create a pull request on GitHub with a well-structured description. Reviews all commits on the branch, writes a complete PR description, and opens the PR via gh CLI.
allowed-tools: Bash, Read, Glob
model: sonnet
argument-hint: [base branch, default: main]
---

Create a pull request for the current branch.

Base branch: $ARGUMENTS (default: main if not specified)

## Process

### Step 1: Understand what's in this PR
```bash
git log main..HEAD --oneline          # All commits on this branch
git diff main...HEAD --stat           # Files changed
git diff main...HEAD                  # Full diff
```

### Step 2: Check PR readiness
- [ ] All tests passing: run the test suite
- [ ] No linting errors
- [ ] No merge conflicts with base branch
- [ ] Self-review: are there any obvious issues?

### Step 3: Write the PR description
```markdown
## Summary
[2-4 bullet points: what this PR does, at a high level]

## Changes
- **[file/module]:** [what changed and why]

## Testing
- [How was this tested? Manual steps? Automated tests added?]
- [ ] Unit tests added/updated
- [ ] Integration tests passing
- [ ] Tested manually: [describe how]

## Screenshots (if UI change)
[Before/after or demo]

## Notes for Reviewer
[Anything specific to look at, design decisions, trade-offs, things you're unsure about]

## Related Issues
Closes #[issue number]
```

### Step 4: Create the PR
```bash
gh pr create \
  --base [base-branch] \
  --title "[conventional commit format title]" \
  --body "[description above]"
```

### Step 5: Output the PR URL
