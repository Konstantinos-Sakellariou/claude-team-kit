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

When the input is especially noisy, the `triage-input` skill is a good fit before deeper reasoning.

## Triage Large Inputs First

Do not dump massive raw inputs into the main reasoning loop unless necessary.

Default workflow:
1. classify the input type before reading deeply
2. inspect the smallest useful slice first
3. extract a compact high-signal summary
4. hand off to the smallest next owner, file set, or team
5. only widen to more raw input if the next step truly needs it

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

## Default Large-Input Workflow

When a task arrives with especially noisy evidence, the kit should follow one default shape:

1. identify whether the evidence is logs, diffs, test output, structured data, a long file, or a mixed bundle
2. inspect a small slice first instead of reading the full raw input
3. return an `Input Triage Report` that captures only the signal needed for the next step
4. route the next step to the best narrow owner
5. widen only if the next owner cannot proceed without more raw evidence

Good default handoffs:
- logs, stack traces, and failing test output -> `@debugger` first, with `@qa-engineer` when reproduction shape matters
- large diffs or review-heavy evidence -> `@code-reviewer`, `Git / GitHub Team`, or a narrow engineering reviewer
- CSV, JSON, analytics exports, or evidence bundles -> `Data Team`, `@data-analyst`, or `@analytics-engineer`
- training traces, eval outputs, and model metrics -> `AI/ML Team`, `@model-evaluator`, or `@ml-engineer`
- mixed planning bundles or decision-heavy evidence -> `Advisory Review Team` or `@architect`

The important discipline is:
- summarize before solving
- route before broadening
- keep the raw evidence available, but do not flood the main thread with it by default

## Specialist-First Routing For Noisy Tasks

When the input is not only large but also domain-heavy, the best next move is usually not more central analysis in the main thread.

Preferred default:
- triage the evidence
- route it into the best narrow specialist or team
- bring back the condensed findings and decision surface

Good defaults:
- debugging logs, stack traces, and failing test bundles -> `@debugger`
- risky diffs, review-heavy code, and merge-readiness evidence -> `Git / GitHub Team` or `@code-reviewer`
- CSV, JSON, metrics exports, or KPI evidence -> `Data Team`
- training logs, model metrics, or evaluation bundles -> `AI/ML Team`
- auth, RLS, schema, migration, or storage evidence -> `Supabase Team`
- mixed planning or decision bundles -> `Advisory Review Team` or `@architect`

The main thread should stay for:
- synthesis
- user-facing recommendations
- tradeoffs
- approvals
- next-step decisions

That keeps long sessions leaner and usually improves quality too, because the first deep read happens in the right domain context.

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

## Model Routing

Model choice is part of efficiency.

Recommended stance:
- use the lightest model that can still do the work well
- keep `Sonnet` as the default middle lane
- use `Haiku` for cheap summarization, low-risk condensation, and repetitive polish
- reserve `Opus` for genuinely heavy reasoning, ambiguity, or high-stakes judgment

Prefer `Haiku` for:
- changelog drafting from already-clear inputs
- backlog curation when the shape is already obvious
- feedback synthesis
- delivery/output monitoring summaries
- other low-risk classification or condensation work

Prefer `Sonnet` for:
- normal implementation
- docs updates
- tests
- repo maintenance
- most planning and review passes

Prefer `Opus` for:
- architecture-heavy ambiguity
- contested strategic decisions
- deep debugging
- high-stakes risk, security, or evaluation work
- idea shaping where one strong pass can remove multiple weaker passes

If you are unsure:
- start with `Sonnet`
- move down to `Haiku` when the work is mostly compressing or polishing already-clear material
- move up to `Opus` only when quality, ambiguity, or risk clearly justify it

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

See [`docs/RTK_INTEGRATION.md`](docs/RTK_INTEGRATION.md) for the dedicated integration guide, correct project/source warning, installation references, and the rule for when RTK is worth using versus when raw output is still better.

## Practical Checklist

Before doing a broad exploration, ask:
- Do I know the likely file already?
- Can I inspect a smaller artifact first?
- Is there already a saved plan, ADR, backlog item, or local-context file for this?
- Would filtered output tell me enough before I read the full raw data?
- Am I using a heavier tool surface than the task needs?

If the answer is yes, start narrower.

If the repo itself feels unclear or bloated, the `context-audit` skill is a good follow-up for checking whether the working briefings and linked artifacts are still healthy.
