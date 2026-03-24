---
name: refactor
description: Refactor code for clarity, maintainability, and better structure. Makes code cleaner without changing behavior. Validates by running existing tests.
allowed-tools: Read, Edit, Bash, Glob, Grep
model: sonnet
argument-hint: [file or function to refactor]
---

Refactor: $ARGUMENTS

## Refactoring Protocol

### Golden Rule
**Refactoring does NOT change behavior.** Tests must pass before AND after.

### Step 1: Run tests BEFORE starting
```bash
# Run the full test suite first
# Capture baseline: all tests should pass
```
If tests are failing before you start, stop — fix them first.

### Step 2: Read the code
Understand what it does, how it's used, and what other code depends on it.
Check for usages: `grep -r "function_name\|ClassName" . --include="*.py" --include="*.ts"`

### Step 3: Identify refactoring opportunities
**Structural issues:**
- Functions too long (> 40 lines) → extract functions
- Too many parameters (> 4) → group into object/dataclass
- Deep nesting (> 3 levels) → early returns / extract functions
- Duplicated logic → extract shared function

**Naming issues:**
- Unclear names → rename to express intent
- Abbreviations → spell them out
- Misleading names → correct them

**Complexity issues:**
- Complex conditionals → extract to named boolean
- Switch/if-elif chains → polymorphism or dispatch table
- Magic numbers/strings → named constants

**Design issues:**
- Functions doing multiple things → single responsibility
- Tight coupling → introduce interface/abstraction
- Data clumps (same 3 params always together) → extract class/dataclass

### Step 4: Refactor incrementally
One change at a time. Run tests after each meaningful change.
DO NOT:
- Fix bugs while refactoring (separate PR)
- Add features while refactoring
- Refactor outside the scope

### Step 5: Run tests AFTER
All tests that passed before must still pass. If something broke, undo.

## Output
Summarize:
- What was changed and why
- Any follow-up refactoring opportunities identified but not yet done
