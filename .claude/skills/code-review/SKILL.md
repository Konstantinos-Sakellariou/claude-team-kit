---
name: code-review
description: Perform a thorough code review on recent changes, a specific file, or a PR. Reviews for correctness, quality, security, performance, and test coverage.
allowed-tools: Read, Bash, Glob, Grep
model: sonnet
argument-hint: [file/path or "HEAD" for recent changes]
---

Perform a professional code review on: $ARGUMENTS

## Review Process

**Step 1: Get the diff**
If no specific file is given, run: `git diff HEAD~1` or `git diff --cached`
If a file is given, read it in full.

**Step 2: Understand context**
Read surrounding files to understand the patterns and conventions in use.

**Step 3: Review across all dimensions**

### Correctness
- Does the logic accomplish what it claims?
- Are edge cases handled (null, empty, boundary values)?
- Are error cases caught and handled properly?
- Are there off-by-one errors, type mismatches, or incorrect assumptions?

### Code Quality
- Is the code readable and self-documenting?
- Are functions/classes focused and well-named?
- Is there unnecessary complexity that should be simplified?
- Is there duplication that should be extracted?

### Security
- Any hardcoded secrets or sensitive values?
- Is input validated and sanitized?
- Are database queries parameterized?
- Any obvious injection vectors?

### Performance
- Any obvious N+1 query patterns?
- Any blocking operations in async code?
- Any unnecessary work in hot paths?

### Tests
- Are there tests for the new functionality?
- Do tests cover the happy path AND error paths?
- Are tests meaningful (not just coverage padding)?

### Documentation
- Is public API documented?
- Are non-obvious decisions explained in comments?
- Is the README/changelog updated if behavior changed?

## Output Format

```
## Code Review

### Summary
[1-2 sentences overall assessment]

### 🔴 Must Fix (Blockers)
- [File:Line] — [Issue] — [Suggested fix]

### 🟡 Should Fix (Important)
- [File:Line] — [Issue] — [Suggestion]

### 🔵 Consider (Optional)
- [File:Line] — [Suggestion]

### ✅ Done Well
- [What was done well — good reviews call out the positives too]

### Verdict
APPROVED / APPROVED WITH NITS / REQUEST CHANGES
```
