# Testing Rules

## Philosophy
- Tests are first-class code — refactor and maintain them like production code
- Tests document behavior — reading them should explain what the code does
- Test behavior, not implementation (test what, not how)
- A test that never fails is worthless — verify it fails before making it pass
- Tests must be deterministic — no flaky tests allowed

## Coverage Targets
- Unit tests: aim for 80%+ line coverage on business logic
- Integration tests: cover all happy paths and key error paths
- E2E tests: cover the 5-10 most critical user journeys only
- Don't chase 100% coverage — test what matters, not what's easy

## Test Structure (AAA Pattern)
```
# Arrange — set up the world
# Act — call the thing being tested
# Assert — verify the outcome
```
Each test tests ONE behavior. If you use "and" in the test name, split it.

## Naming
- Python: `test_<function>_<scenario>_<expected>`
  e.g. `test_login_with_invalid_password_returns_401`
- TypeScript: `describe('login') > it('returns 401 with invalid password')`

## Unit Tests
- Fast: < 1ms per test, no I/O
- Isolated: mock all external dependencies (DB, API, file system, time)
- One assertion concept per test (can have multiple `assert` statements)
- Use factories/fixtures for test data — no copy-paste setup

## Integration Tests
- Test the actual database, not mocks (use a test database)
- Reset state between tests — use transactions that rollback
- Test one integration path per test (e.g., API → DB, not full stack)

## E2E Tests
- Use Playwright (TS) or pytest + httpx (Python API tests)
- Run against a real environment (staging or docker compose)
- Keep E2E suite small and fast — under 5 minutes total
- Don't test UI pixel-by-pixel — test user flows

## What to Always Test
- Happy path (normal use)
- Edge cases (empty input, max values, null/None)
- Error paths (invalid input, missing data, service failures)
- Security boundaries (unauthorized access, injection attempts)
- Business rules (calculations, state transitions, permissions)

## What NOT to Test
- Third-party library internals
- Getter/setter trivials with no logic
- Framework boilerplate
- Things better covered by type checking

## CI Requirements
- All tests run on every PR — no merging with failing tests
- Tests run in parallel where possible
- Test results and coverage reports archived as artifacts
