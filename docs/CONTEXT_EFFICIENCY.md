# Context Efficiency

This kit should not only be capable. It should also stay efficient.

The goal is simple:
- reduce wasted context
- keep recurring prompts high-signal
- avoid broad exploration when a narrow read would do
- turn repeated chat recap into durable artifacts instead

## Core Principle

Spend context where it creates better decisions.

Do not spend context on:
- bloated briefing files
- repeated recap of saved decisions
- full raw logs when filtered evidence would be enough
- repo-wide scans before reading the obvious files first
- unnecessary tool surfaces for tasks that already have a simple local CLI path

## Keep Always-Loaded Files Lean

`CLAUDE.md` and `AGENTS.md` are special because they are read often.

They should contain:
- project identity
- stack and runtime
- important commands
- architecture constraints
- environment notes
- high-signal gotchas
- workflow rules that would cause mistakes if omitted

They should avoid:
- long catalogs better stored elsewhere
- repeated explanations already covered in linked docs
- raw logs or verbose examples
- business or strategy context that belongs in `.claude/local-context/`

Good rule of thumb:
- if removing a line would not cause a likely mistake, it probably does not belong in the core briefing

## Read Narrow First

Default exploration pattern:

1. read the most likely files first
2. inspect the smallest useful evidence first
3. widen scope only if the evidence says to

Examples:
- inspect `git diff --stat` before `git diff`
- read the relevant function before the whole file
- inspect a failing test and traceback before scanning the full test suite
- inspect schema, headers, or sample rows before a whole dataset

## Shape Requests Well

High-signal requests save both time and tokens.

Good requests include:
- exact file paths when known
- exact error messages when available
- goal or expected outcome
- relevant constraints
- whether the task is exploratory, implementation-focused, or review-focused

Lower-signal requests:
- "scan my whole repo"
- "fix bugs everywhere"
- "look at this giant log and tell me what happened" without narrowing

If the request is broad, `@master` should help narrow it rather than exploding scope immediately.

## Triage Large Inputs First

Do not dump massive raw inputs into the main reasoning loop unless necessary.

Preferred first-pass patterns:

### Logs

- extract errors, warnings, and repeated patterns first
- ignore routine noise unless it is the only signal

Useful commands:

```bash
rg -n "ERROR|WARN|Exception|Traceback|FATAL" app.log
tail -n 200 app.log
```

### Git Diffs

- inspect changed files and diff size first
- read only the most relevant files next

Useful commands:

```bash
git diff --stat
git diff --name-only
```

### Structured Data

- inspect schema, keys, counts, and samples first
- avoid full payload reads unless the task truly depends on them

### Large Code Files

- read the relevant functions, classes, or sections first
- only widen if the local context is not enough

## Prefer Artifacts Over Recap

When context should survive the session, save it into the right artifact:
- `BACKLOG.md` or `docs/BACKLOG.md`
- `docs/plans/`
- `docs/adr/`
- `.claude/local-context/`

This is usually better than re-explaining the same history in every new session.

Use chat for:
- immediate collaboration
- exploration
- short-lived synthesis

Use artifacts for:
- durable plans
- durable decisions
- deferred work
- private business or customer context

## MCP And Tool Hygiene

Every extra tool surface can add complexity and sometimes overhead.

Guidelines:
- use only the MCP servers the task actually needs
- disable or avoid unused MCP servers when possible
- prefer local CLI tools over equivalent MCP tools when they solve the task cleanly
- do not add new tooling just because it exists; add it when it meaningfully improves the workflow

Examples where local CLI is often a good fit:
- `git`
- `gh`
- `rg`
- `find`
- `jq`

## Optional RTK Usage

If `rtk-ai/rtk` is installed locally, it can help reduce noisy shell output before it reaches the model.

Best fit:
- `git status`
- `git diff`
- `git log`
- test output
- lint output
- noisy read/grep flows

Recommended stance:
- good optional local optimization
- not a required dependency of the kit
- usually not necessary for standard CI pipelines

## Practical Checklist

Before doing a broad exploration, ask:
- Do I know the likely file already?
- Can I inspect a smaller artifact first?
- Is there already a saved plan, ADR, backlog item, or local-context file for this?
- Would filtered output tell me enough before I read the full raw data?
- Am I using a heavier tool surface than the task needs?

If the answer is yes, start narrower.
