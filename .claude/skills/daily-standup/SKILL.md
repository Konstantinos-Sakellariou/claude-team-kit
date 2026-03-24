---
name: daily-standup
description: Generate a daily standup summary based on git activity, open issues, and current work. What was done, what's planned, what's blocked.
allowed-tools: Bash, Read, Glob
model: haiku
---

Generate today's standup update.

## Process

```bash
# Yesterday's commits
git log --oneline --since="24 hours ago" --author="$(git config user.email)" 2>/dev/null || \
git log --oneline -10

# Current branch and status
git branch --show-current
git status --short

# Any uncommitted work in progress
git diff --stat HEAD
```

Also check for any TODO/notes files, open issues mentioned in recent commits.

## Output Format

```
## Daily Standup — [Today's Date]

### ✅ Yesterday
- [What was accomplished, based on git log and context]

### 🔄 Today
- [What's planned next based on current branch/WIP]

### 🚫 Blockers
- [Any blockers, merge conflicts, missing info, or waiting-ons]

### 📊 Branch Status
Current branch: [branch name]
[Any open PRs or pending reviews]
```

Keep it concise — standup should take 2 minutes to read.
