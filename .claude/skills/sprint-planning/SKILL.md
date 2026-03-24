---
name: sprint-planning
description: Run a sprint planning session. Reviews the backlog, estimates stories, checks capacity, identifies risks and blockers, and produces a sprint plan with commitments.
allowed-tools: Read, Bash, Glob, WebSearch
model: sonnet
argument-hint: [sprint number or duration, e.g. "Sprint 5" or "2 weeks"]
---

Run sprint planning for: $ARGUMENTS

## Sprint Planning Process

### Step 1: Capacity Check
- How many working days in this sprint?
- Team availability? (Vacations, on-call rotations, recurring meetings)
- Apply realistic factor: capacity = days × 0.6-0.7 (meetings, reviews, etc.)

### Step 2: Backlog Review
Look for any TODO/BACKLOG/ISSUES files and list of tasks.
Categorize items by:
- P0: Must ship this sprint (blocking customers, SLA commitments)
- P1: High value, clear requirements, ready to work
- P2: Nice to have, requirements clear
- Tech debt: Accumulated issues that slow the team down

### Step 3: Readiness Check
For each candidate story, ask:
- Are requirements clear and complete?
- Are dependencies resolved?
- Is it estimated?
- If NOT ready → move to "Needs Refinement" backlog

### Step 4: Estimation
Use T-shirt sizes:
- S (< 1 day) | M (1-3 days) | L (3-7 days) | XL (>1 week — break it down)

Flag HIGH UNCERTAINTY items → schedule a spike (time-boxed investigation) before committing

### Step 5: Commitment
Fill capacity:
- Start with P0 (must), then P1, then P2 / tech debt
- Leave 10-15% buffer for unexpected work
- Don't commit to XL items without spikes

## Sprint Plan Output

```
## Sprint [N] Plan — [Start Date] to [End Date]

### Capacity
Team size: [N] | Working days: [N] | Effective capacity: [N person-days]

### Sprint Goal
[One sentence: what is the main theme/outcome of this sprint?]

### Committed Stories
| ID | Story | Owner | Size | Priority |
|----|-------|-------|------|---------|
| S1 | [story] | [who] | M | P0 |
| S2 | [story] | [who] | L | P1 |

**Total committed:** [N days / N% of capacity]

### Carryover / Not Included
| ID | Story | Reason not included |
|----|-------|---------------------|

### Risks
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|

### Spikes / Investigations
| Topic | Owner | Time-box | Decision needed |
|-------|-------|----------|----------------|

### Definition of Done (Sprint)
- All committed stories complete and deployed to staging
- All P0 bugs resolved
- Test suite passing
- Retrospective conducted
```
