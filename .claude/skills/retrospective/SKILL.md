---
name: retrospective
description: Facilitate a sprint or project retrospective. Analyzes what went well, what didn't, and produces concrete action items. Uses git history and any notes available for evidence-based reflection.
allowed-tools: Bash, Read, Glob, Grep
model: sonnet
argument-hint: [sprint number or time period]
---

Facilitate a retrospective for: $ARGUMENTS

## Retrospective Process

### Step 1: Gather data
```bash
# Commits in the sprint
git log --oneline --since="2 weeks ago"

# Any failed builds or test runs mentioned in commits
git log --oneline --since="2 weeks ago" | grep -i "fix\|bug\|revert\|hotfix"

# PRs merged
git log --oneline --since="2 weeks ago" --merges
```

Check for any notes, retrospective files, or issue trackers in the repo.

### Step 2: Categorize findings
Using the Start/Stop/Continue framework (simple, actionable):

**WENT WELL (Continue):**
- Technical wins
- Process improvements that worked
- Team collaboration moments
- Things shipped on time or under budget

**WENT POORLY (Stop/Fix):**
- Things that slowed the team down
- Recurring problems
- Communication gaps
- Technical debt that bit us
- Missed estimates or scope changes

**EXPERIMENTS TO TRY (Start):**
- New practices to try next sprint
- Tooling improvements
- Process changes

### Step 3: Root cause on key problems
For the top 2-3 issues, go deeper:
- What actually caused this?
- Is this a one-time thing or a pattern?
- What would prevent it next time?

### Step 4: Action items
Each "thing to improve" must produce a SPECIFIC, OWNED action item.
Vague: "improve communication"
Specific: "Add async PR update comment when blocked > 4 hours — Owner: Dev lead — By: End of next sprint"

## Output Format

```
## Retrospective: [Sprint/Period]
**Date:** | **Participants:** [list]

### Sprint Goal Achievement
[Was the sprint goal met? What % of committed stories shipped?]

### What Went Well ✅
- [Specific thing] — [Evidence/example]

### What Needs Improvement ⚠️
- [Specific thing] — [Root cause] — [Impact]

### Action Items 📋
| Action | Owner | Deadline | Success Measure |
|--------|-------|----------|----------------|
| [Specific action] | [Name] | [Date] | [How we'll know it worked] |

### Patterns to Watch
[Recurring issues that need ongoing attention]

### One Thing to Celebrate 🎉
[A genuine win from this sprint]
```
