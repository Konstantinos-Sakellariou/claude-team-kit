---
name: optimize-performance
description: Profile and optimize performance bottlenecks in code. Identifies the actual bottleneck (not the assumed one), proposes targeted optimizations, and verifies improvement.
allowed-tools: Read, Bash, Edit, Glob, Grep
model: sonnet
argument-hint: [file, function, or endpoint that is slow]
---

Profile and optimize: $ARGUMENTS

## Performance Optimization Protocol

### Step 1: Establish baseline (measure first!)
```bash
# Python - profile a function
python -c "import cProfile; cProfile.run('your_function()')"

# Check if there's an existing benchmark
grep -r "benchmark\|perf\|timing" tests/ --include="*.py" --include="*.ts"
```

Read the target code and identify:
- What is the expected input/output?
- What does it do at a high level?
- What's the approximate data size it handles?

### Step 2: Identify the bottleneck
Look for:
- **N+1 queries:** A database call inside a loop
- **Missing indexes:** Query without WHERE clause index
- **Blocking I/O in async code:** sync operations in async context
- **Repeated computation:** Same expensive calculation done multiple times
- **Over-fetching:** Loading entire objects when only 1-2 fields needed
- **Unnecessary serialization:** Converting to/from JSON/dict in hot loops
- **GC pressure:** Many small object allocations in tight loops

### Step 3: Targeted optimization
Fix the BOTTLENECK only. Don't optimize everything.
- Database: batch queries, add indexes, reduce fetched columns
- Computation: cache results, use more efficient algorithms/data structures
- I/O: make async, batch operations, use streaming
- Memory: use generators, process in chunks

### Step 4: Verify improvement
Re-run the profiler and compare. Expected improvement should be significant.
If improvement is < 20%, you may not have hit the real bottleneck — investigate further.

## Output Format

```
## Performance Analysis: [Component]

### Bottleneck Found
**Location:** file.py:line_number
**Type:** N+1 Query / Missing Index / Sync I/O / etc.
**Evidence:** [Profiler output or reasoning]

### Root Cause
[Why this is slow]

### Proposed Fix
[Code change with explanation]

### Expected Improvement
[Estimated speedup, based on profiling data]

### Verification
[How to confirm the improvement]
```
