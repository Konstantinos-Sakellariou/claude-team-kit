# Code Quality Rules

## General
- Write code for the next developer, not just the machine
- Functions do ONE thing — if you need "and" to describe it, split it
- Max function length: ~40 lines; max file length: ~400 lines
- No magic numbers or strings — use named constants
- Fail loudly: raise exceptions, don't silently swallow errors
- Delete dead code — don't comment it out
- No TODO comments in committed code — open an issue instead

## Naming
- Names describe intent, not implementation (`get_user_by_email` not `fetch_data`)
- Boolean variables and functions start with is_, has_, can_, should_
- Avoid abbreviations except universally understood ones (id, url, api, db)
- Avoid single-letter variables except in tight loops (i, j, k acceptable)

## Functions & Classes
- Functions: max 3-4 parameters; use objects/dataclasses for more
- Prefer pure functions — same input always returns same output
- Classes represent nouns; methods represent verbs
- Composition over inheritance

## Error Handling
- Catch specific exceptions, never bare `except:` or `catch (e) {}`
- Always include context in error messages ("Failed to fetch user {id}: {reason}")
- Log errors at the point of handling, not re-raise
- Return meaningful error types, not just strings

## Comments
- Comment WHY, not WHAT (the code says what, you explain why)
- Document non-obvious business logic, edge cases, known limitations
- Keep comments up to date — wrong comments are worse than none

## Dependencies
- Minimize dependencies — question every new import
- Pin versions in requirements/package.json
- Prefer standard library when it's sufficient
- Audit new dependencies for security and maintenance status
