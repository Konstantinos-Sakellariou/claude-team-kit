---
name: triage-input
description: Triage large or noisy inputs before deeper analysis. Compresses logs, diffs, dumps, structured data, or bulky evidence into a smaller, high-signal summary and recommended next steps.
allowed-tools: Read, Bash, Glob, Grep
model: sonnet
argument-hint: [log, diff, dump, dataset, or noisy input to triage]
---

Triage this input first: $ARGUMENTS

## Triage Goal

Reduce a large or noisy input into the minimum high-signal summary needed for the next reasoning or implementation step.

## Triage Workflow

### Step 1: Identify the input type
Classify the input before reading deeply:
- logs
- git diff
- test output
- stack trace
- JSON / CSV / structured data
- long code file
- mixed evidence bundle

### Step 2: Inspect the smallest useful slice first
Examples:
- logs: errors, warnings, repeated patterns, last failing region
- git: `git diff --stat`, changed files, largest risky files
- tests: failing tests only, traceback origin, repeated failure pattern
- structured data: keys, headers, schema, row samples, counts
- long files: relevant functions, classes, or changed sections

### Step 3: Extract signal
Summarize:
- what the input mostly contains
- what looks important first
- what can probably wait
- where the likely root cause or decision surface sits

### Step 4: Recommend the next narrow read
Hand off to the smallest next investigation target:
- specific files
- specific functions
- specific logs
- specific diff hunks
- specific agents or teams if relevant

## Output Format

```md
## Input Triage Report

### Input Type
[log / diff / data / test output / mixed]

### High-Signal Findings
- ...

### Likely Hotspots
- ...

### Noise To Ignore For Now
- ...

### Recommended Next Read
1. ...
2. ...

### Suggested Handoff
[direct handling / specific agent / specific team]
```

## Guardrails
- Do not dump the full raw input unless the task truly needs it
- Keep the triage summary compact and actionable
- Prefer narrowing the next step over solving the whole problem prematurely
