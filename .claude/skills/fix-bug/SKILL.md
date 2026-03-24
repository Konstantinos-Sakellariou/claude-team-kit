---
name: fix-bug
description: Diagnose and fix a bug. Finds the root cause (not just the symptom), implements the fix, and writes a regression test.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
argument-hint: [bug description, error message, or file:line]
---

Diagnose and fix this bug: $ARGUMENTS

## Bug-Fixing Protocol

### Step 1: Reproduce
- Understand the exact failure: what happens vs what should happen
- Find or write the smallest reproduction case
- If you can't reproduce it, you can't verify the fix

### Step 2: Read the stack trace / logs
- Start at the top of the stack trace
- Find where YOUR code first appears — that's where to start reading
- Identify the exact line and condition that triggered the error

### Step 3: Root cause investigation
- Read the failing code and understand the logic flow
- Form a hypothesis: "I believe X is failing because Y"
- Look for evidence: grep for related code, check recent git changes
- Check: null/None values, off-by-one errors, wrong types, async timing, stale cache

### Step 4: Fix the ROOT CAUSE
- Fix the underlying problem, not the symptom
- If a quick symptom fix is unavoidable (hotfix), document that a proper fix is needed
- Make the minimal change needed — don't refactor unrelated code in a bug fix

### Step 5: Write a regression test
- Write a test that fails BEFORE your fix and passes AFTER
- This proves the fix works and prevents recurrence
- Run the full test suite to check for unintended regressions

### Step 6: Check for similar bugs
- grep/search for the same pattern elsewhere in the codebase
- If the root cause is a pattern (not an isolated typo), fix all instances

## Output
After fixing, provide:
- Root cause (1-2 sentences)
- What the fix does
- The regression test
- Any similar code to audit
