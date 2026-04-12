# Guided Initialization Plan

## Idea Summary

Extend `@master` so it can proactively guide users through shaping a new or underdefined repo in a collaborative way instead of relying only on a short bootstrap check.

## Artifact Decision

- Type: `docs/plans/`
- Status: Proposed
- Approval: Approved by user on 2026-04-11
- Backlog Link: `BL-035`
- Intended Assignee: `Unassigned`

## Goal

Make new-repo setup feel more like a guided co-creation session with `@master`, while keeping normal tactical work fast and unobstructed.

## Core Idea

The repo already has bootstrap.

This plan does not replace bootstrap. It extends it.

The new behavior should let `@master`:
- ask questions in rounds instead of one big dump
- help the user answer when they are unsure
- suggest candidate answers or temporary assumptions
- progressively improve project context rather than expecting the user to know everything upfront

## When Guided Initialization Should Trigger

Best fit:
- new repos that still look generic
- early project-shaping sessions
- startup/product-definition sessions
- repos where `CLAUDE.md`, `AGENTS.md`, and `README.md` are still weak or incomplete

Should not trigger:
- inside `claude-team-kit` itself unless explicitly appropriate
- in already-customized repos without a clear context gap
- for tiny tactical tasks where the interruption would cost more than it helps

## Desired User Experience

The interaction should feel like:
- collaborative
- supportive
- structured
- flexible

It should not feel like:
- a form
- an interrogation
- a mandatory setup wizard
- a blocker before every task

## Suggested Interaction Model

### Round 1: What Is This?

Questions:
- what is this project?
- who is it for?
- what kind of product or system is it?

If the user is unsure:
- offer likely categories
- allow a rough answer
- mark assumptions as temporary

### Round 2: How Does It Work?

Questions:
- what stack or runtime does it probably use?
- what are the important commands?
- what folders, pages, modules, or services matter most?

If the user is unsure:
- infer from the repo
- propose candidate stack descriptions
- clearly label assumptions

### Round 3: What Should Agents Avoid Getting Wrong?

Questions:
- deployment/runtime constraints
- gotchas
- private local context needs
- backlog mode preference
- docs or sync expectations

## Expected Outputs

The session should progressively improve:
- `CLAUDE.md`
- `AGENTS.md`
- optionally `README.md`
- optionally `.claude/local-context/` guidance when relevant

## Prompt Changes Needed

### `@master`

Add a section such as:
- `## Guided Initialization`

It should define:
- when the mode can activate
- how many questions to ask at once
- how to help when the user is unsure
- how to suggest temporary assumptions
- how to stop when the user just wants tactical work

### `@workspace-updater`

It should understand when the session included guided initialization and verify that:
- the docs improved meaningfully
- assumptions are still clearly marked
- the docs did not become bloated

## Docs To Update When Implemented

- `README.md`
- `CLAUDE.md`
- `AGENTS.md`
- `docs/BOOTSTRAP.md`
- `docs/PROJECT_CUSTOMIZATION.md`
- maybe `docs/AGENT_WORKFLOWS.md`

## Validation To Add

- `scripts/doctor.sh`
- `tests/test_prompt_contracts.py`

Contracts worth checking:
- guided initialization is explicitly defined
- the prompt says to ask in small batches
- the prompt says to accept partial answers
- the prompt says to make temporary assumptions clearly
- docs explain the collaborative nature of initialization

## Risks

- over-triggering and slowing normal work
- asking too many questions at once
- duplicating bootstrap instead of extending it cleanly
- creating bloated project docs from too much speculative detail

## Success Criteria

- new repos feel easier to shape with `@master`
- users who do not know their stack yet can still make progress
- docs get better faster
- tactical sessions remain low-friction

## Recommended Next Step

If this item is selected, implement in this order:

1. extend `@master`
2. align bootstrap docs
3. extend `@workspace-updater`
4. add doctor/test coverage

Keep the first pass narrow:
- guided initialization only for clearly underdefined repos
- small question rounds
- no giant setup wizard
