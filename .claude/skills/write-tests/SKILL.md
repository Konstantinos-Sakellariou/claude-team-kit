---
name: write-tests
description: Write comprehensive tests for a file, function, or feature. Covers happy paths, edge cases, error paths, and security cases using the project's existing testing framework.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
argument-hint: [file, function name, or feature to test]
---

Write comprehensive tests for: $ARGUMENTS

## Testing Process

### Step 1: Understand what exists
- Read the target code thoroughly — understand all execution paths
- Check existing test files for patterns, fixtures, and testing conventions
- Identify the testing framework in use (pytest, jest, vitest, etc.)
- Note how tests are organized and named

### Step 2: Map the test cases
Before writing a single test, list ALL cases:

**Happy path(s):** Normal, expected inputs producing expected outputs
**Boundary values:** Min, max, exactly at limits, just beyond limits
**Empty/null cases:** None, [], {}, "", 0, False
**Type edge cases:** Wrong types, mixed types
**Business rule cases:** Each distinct business rule needs a test
**Error paths:** Invalid input, missing data, service failures
**Security cases:** Auth bypass attempts, injection, excessive input

### Step 3: Write tests in AAA format
```python
def test_<what>_<when>_<expected>():
    # Arrange
    [setup]

    # Act
    result = [call the thing]

    # Assert
    assert result == expected
```

### Step 4: Verify coverage
- Run tests and confirm they pass
- Check that each test would FAIL if you broke the thing it tests
- For Python: `pytest --cov` to see coverage
- For TS: `jest --coverage`

## Test Quality Checklist
- [ ] Each test tests ONE behavior
- [ ] Test names explain the scenario without reading the code
- [ ] Tests use realistic data, not "foo"/"bar"/"test123"
- [ ] External I/O is mocked
- [ ] Tests are independent — no test depends on another
- [ ] Tests run fast (< 1s each for unit tests)
- [ ] Happy path covered
- [ ] Error paths covered
- [ ] Boundary/edge cases covered
