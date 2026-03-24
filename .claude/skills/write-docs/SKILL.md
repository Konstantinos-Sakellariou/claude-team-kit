---
name: write-docs
description: Write or update documentation for a module, API, or feature. Produces READMEs, docstrings, API docs, or architecture decision records depending on what's needed.
allowed-tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
argument-hint: [what to document: file/module/API/feature]
---

Write documentation for: $ARGUMENTS

## Documentation Process

### Step 1: Understand the audience
Who will read this?
- New team member? → focus on setup, concepts, examples
- Existing developer? → focus on reference, edge cases, changes
- External user/API consumer? → focus on usage, examples, guarantees

### Step 2: Read the code
- Read the code thoroughly — docs must be accurate
- Identify: what are the inputs, outputs, side effects, error cases?
- Find: what's non-obvious that needs explanation?

### Step 3: Choose the right format
- **Docstrings/JSDoc:** For functions, classes, modules
- **README:** For projects, packages, tools
- **ADR:** For significant architectural decisions
- **Runbook:** For operational procedures

### Step 4: Write — with examples
Every piece of documentation needs a real, working example. Examples beat prose.

### Python Docstring Format (Google style)
```python
def function_name(param1: Type, param2: Type) -> ReturnType:
    """Short one-line summary.

    Longer description if needed. Explain WHY or non-obvious behavior.

    Args:
        param1: Description of param1.
        param2: Description of param2.

    Returns:
        Description of what is returned.

    Raises:
        ValueError: When this specific condition is met.
        HTTPException: When the external service fails.

    Example:
        >>> result = function_name("example", 42)
        >>> print(result)
        "expected output"
    """
```

### TypeScript JSDoc Format
```typescript
/**
 * Short one-line summary.
 *
 * @param param1 - Description of param1
 * @param param2 - Description of param2
 * @returns Description of return value
 * @throws {Error} When this condition is met
 *
 * @example
 * const result = functionName("example", 42);
 * // => "expected output"
 */
```

## Quality Check
Before finishing:
- [ ] Every public function/class documented
- [ ] All parameters and return types described
- [ ] At least one working example per public API
- [ ] Error cases documented
- [ ] Non-obvious behavior explained
- [ ] Language is clear to the target audience
