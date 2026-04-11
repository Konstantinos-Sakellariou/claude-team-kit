# RTK Integration Plan

## Idea Summary

Support `rtk-ai/rtk` as an optional integration for `claude-team-kit` so users can reduce token waste from noisy shell output during local LLM-assisted workflows.

## Artifact Decision

- Type: `docs/plans/`
- Status: Proposed
- Approval: Approved by user on 2026-04-09
- Backlog Link: `BL-030`
- Intended Assignee: `Unassigned`

## Goal

Give users a safe, documented, opt-in path for using RTK locally without making it a mandatory dependency of the kit or a required part of CI.

## Recommendation

- Yes for local use
- Yes as an optional kit integration
- No as a required dependency
- Usually no for standard CI pipelines

## Why RTK Fits

RTK is valuable when the model frequently consumes noisy shell output such as:
- `git status`
- `git diff`
- `git log`
- large test output
- linter output
- file reads and grep-heavy exploration

Its main benefit is reducing the amount of raw command output that enters the model context.

## Why RTK Should Stay Optional

- not every user wants another local binary
- not every environment supports the same hook model
- some users will prefer raw output for debugging
- this kit should stay portable and low-friction by default

## Best Integration Shape

### Phase 1: Documentation

Create a docs page that explains:
- what RTK is
- which RTK project is the correct one
- where it helps most
- where it is not worth using
- how to install it locally
- how to verify it is working
- how to keep it optional

### Phase 2: Workflow Guidance

Teach `@master` or the docs to prefer RTK only when:
- RTK is present locally
- the command is noisy and supported
- filtered output is appropriate for the task

Do not assume RTK exists.

### Phase 3: Optional Hook Pattern

If useful, add an example-only integration pattern showing how RTK could sit in front of noisy commands.

This should be:
- opt-in
- documented clearly
- never auto-enabled by default

## Where RTK Helps Most

- git-heavy review sessions
- repetitive test/lint runs
- large output from grep, read, or find-like commands
- debugging sessions with verbose but repetitive logs

## Where RTK Helps Least

- small or already concise commands
- tasks where raw output fidelity matters more than compression
- normal CI logs consumed by humans rather than models
- workflows where installation friction outweighs token savings

## Relationship To Existing Backlog Items

RTK integration fits especially well with:
- context-efficiency rules
- large-input triage
- read-narrow-first behavior
- request-shaping guidance
- noisy-task delegation

## Suggested Docs To Add Later

- `docs/RTK_INTEGRATION.md`
- references from `README.md`
- references from `docs/CONTEXT_EFFICIENCY.md`
- optional setup/customization guidance

## Risks

- over-coupling the kit to a third-party tool
- making users think RTK is required
- introducing hook complexity for users who do not need it
- recommending compressed output in cases where raw fidelity is better

## Success Criteria

- users understand whether RTK is worth it for their workflow
- the repo documents a clear optional integration path
- nothing in the kit breaks if RTK is absent
- the integration improves local efficiency without adding mandatory complexity

## Recommended Next Step

Do not implement RTK integration before the context-efficiency docs exist.

Start with:
1. context-efficiency guidance
2. RTK integration docs
3. optional workflow/hook examples only if there is still demand
