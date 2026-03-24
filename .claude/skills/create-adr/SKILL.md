---
name: create-adr
description: Create an Architecture Decision Record (ADR) documenting a significant technical decision. Records the context, options considered, decision made, and consequences.
allowed-tools: Read, Write, Bash, Glob
model: sonnet
argument-hint: [decision title, e.g. "use PostgreSQL for primary database"]
---

Create an Architecture Decision Record for: $ARGUMENTS

## ADR Process

### Step 1: Find the next ADR number
```bash
ls docs/adr/ 2>/dev/null | grep "^ADR-" | sort | tail -1
# or
ls docs/decisions/ 2>/dev/null | sort | tail -1
```
If no ADR directory exists, create `docs/adr/`.

### Step 2: Understand the decision context
Read relevant existing code, config files, and any existing ADRs to understand:
- What's the current state?
- What forces/constraints are at play?
- What alternatives exist?

### Step 3: Write the ADR

```markdown
# ADR-[N]: [Decision Title]

**Date:** [YYYY-MM-DD]
**Status:** Proposed | Accepted | Deprecated | Superseded by ADR-[N]
**Deciders:** [Who made or approved this decision]

## Context

[What is the situation that led to this decision? What problem are we solving?
What constraints exist? What forces are at play?
Write this for someone who wasn't in the room.]

## Decision

[Clearly state what was decided. Be specific.
"We will use X for Y" not "We might consider using X"]

## Rationale

[Why this option over the others? What were the key deciding factors?
What trade-offs are being made? What assumptions are embedded?]

## Options Considered

### Option A: [The chosen option]
**Pros:**
- [Advantage]
**Cons:**
- [Disadvantage]

### Option B: [Alternative]
**Pros:**
- [Advantage]
**Cons:**
- [Disadvantage — why this wasn't chosen]

### Option C: Do Nothing
**Pros:** No cost, no change
**Cons:** [Why the status quo is unacceptable]

## Consequences

### Positive
- [What becomes easier or better]

### Negative
- [What becomes harder or worse — be honest]
- [Technical debt created]

### Risks
- [What could go wrong with this decision]

## Revisit When
[Under what conditions should this decision be reconsidered?
e.g., "If we exceed 10M records per month" or "If we hire a dedicated iOS team"]

## Related Decisions
- ADR-[N]: [Related decision]
```

### Step 4: Save the file
Save as: `docs/adr/ADR-[N]-[kebab-case-title].md`
