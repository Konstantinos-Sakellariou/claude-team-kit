---
name: explain-code
description: Explain how a piece of code works — what it does, why it does it that way, and what to watch out for. Tailored for developers who need to understand unfamiliar code quickly.
allowed-tools: Read, Bash, Glob, Grep
model: sonnet
argument-hint: [file path, function name, or paste the code]
---

Explain this code: $ARGUMENTS

## Explanation Process

### Step 1: Read the code in full context
- Read the file
- Understand what imports/dependencies it uses
- Find where it's called from: `grep -r "function_name" . --include="*.py" --include="*.ts" -l`

### Step 2: Understand the purpose
- What problem does this code solve?
- What does it take in, and what does it produce?
- When/why would you call this?

### Step 3: Walk through the logic
- What are the key steps in sequence?
- What are the important conditions / branches?
- What are the side effects?

### Step 4: Identify design decisions
- Why is it structured this way?
- What alternatives might someone consider?
- What constraints shaped this approach?

### Step 5: Flag things to watch out for
- Non-obvious behavior
- Known edge cases or limitations
- Performance characteristics
- Error handling (or lack thereof)

## Output Structure

```
## Code Explanation: [Name/File]

### What It Does (1 paragraph)
[Plain English: purpose, input, output]

### How It Works
[Step-by-step walkthrough of the key logic. Not line-by-line — conceptual steps.]

### Key Design Decisions
[Why is it structured this way? What trade-offs were made?]

### Dependencies
[What does it rely on? External services, libraries, other modules?]

### Things to Watch Out For
[Edge cases, limitations, gotchas, performance notes]

### How to Use It
[Example call with realistic parameters]
```
