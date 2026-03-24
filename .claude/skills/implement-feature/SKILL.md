---
name: implement-feature
description: Implement a new feature end-to-end: understand requirements, design the approach, write the code, write tests, and summarize what was built.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
argument-hint: [feature description or ticket reference]
---

Implement the following feature: $ARGUMENTS

## Implementation Protocol

### Phase 1: Understand Before Writing
1. Read the existing codebase to understand patterns and conventions
   - How are similar features structured?
   - What naming conventions are used?
   - What testing patterns are in place?
2. Identify all files that need to change
3. Identify potential side effects or regressions
4. If requirements are ambiguous, state your assumptions explicitly

### Phase 2: Design (for anything non-trivial)
- Outline the approach before coding
- Identify the data model changes (if any)
- Identify the API contract (if applicable)
- Identify the edge cases upfront

### Phase 3: Implement
- Follow the codebase's existing style — consistency over personal preference
- Write the simplest code that satisfies the requirements
- Type annotations on everything (Python) / TypeScript types throughout
- Handle errors explicitly — don't let exceptions bubble silently
- No print/console.log debug statements
- No TODO comments in committed code

### Phase 4: Test
- Write unit tests for the core logic
- Write integration tests for the happy path and key error paths
- Run the test suite: confirm all tests pass
- Run the type checker
- Run the linter

### Phase 5: Summarize
Provide a clear summary of:
- What was implemented (high level)
- Files created/modified
- Key decisions made and why
- What was NOT implemented (scope)
- Follow-up tasks or known limitations

## Quality Gates Before Finishing
- [ ] Tests written and passing
- [ ] Type checker clean
- [ ] Linter clean
- [ ] No hardcoded secrets
- [ ] Error paths handled
- [ ] Public functions/classes documented
