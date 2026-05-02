# Feedback And Learning

This guide defines how `claude-team-kit` should capture workflow feedback when something did not work as expected.

## Purpose

The repo needs a way to learn from:
- confusing workflows
- weak prompts
- unclear docs
- poor command fit
- implementation misses
- user misuse that reveals missing guidance

The goal is not to keep a complaint diary.

The goal is to create an objective learning loop that helps the kit improve over time.

## Default Artifact

Use a local-first feedback artifact:
- `.claude/local-context/FEEDBACK.md`

Keep it local by default because:
- it may include blunt operational feedback
- it may include user mistakes or confusion patterns
- it may include tool or workflow weaknesses that are still being evaluated

Tracked docs should only receive the approved conclusions, not the raw feedback log.

## Default Command

Use `/log-feedback` when:
- the user says something did not work well
- a workflow caused confusion
- an output missed the mark
- a recurring friction point should be preserved

`@master` should also suggest or run this flow when the signal is clear, even if the user did not know the command name.

## Default Owner

Use `@feedback-analyst` to structure the feedback.

Add:
- `@customer-advocate` when the issue is mainly onboarding, clarity, or trust
- `@backlog-updater` when the issue deserves future work
- `@workspace-updater` when the local feedback artifact should be refreshed

## Entry Shape

Use entries like:

```md
## YYYY-MM-DD - Short Title

- Request:
- Expected:
- Observed:
- Evidence:
- Impact:
- Root-cause class:
- Responsibility split:
- Corrective action:
- Status:
- Related artifacts:
```

## Root-Cause Classes

Use one primary class:
- kit behavior gap
- documentation clarity gap
- command or workflow gap
- user-input ambiguity
- user misuse
- tool or platform limitation
- unresolved bug
- expectation mismatch

## Objectivity Rules

- separate fact from interpretation
- record evidence, not vibes
- if the user used the kit poorly, say so plainly but constructively
- if the kit invited the mistake, say that too
- prefer corrective action over blame
- preserve strong signals that may explain repeated failure later

## Relationship To Other Artifacts

Use this split:
- `ACTIVITY.md`
  - what happened
- `HANDOFF.md`
  - what the next session should know
- `FEEDBACK.md`
  - what did not work well and why
- backlog
  - what should be improved later

Do not use `FEEDBACK.md` as:
- a transcript
- a strategy memo
- a general bug tracker
- a replacement for backlog or ADRs
