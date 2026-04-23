# Agent SDK User Input Compatibility

## Purpose

This document defines how Agent SDK user-input features could later fit `claude-team-kit`.

The goal is to make the future integration path clear without pretending the current markdown-first repo already has runtime support for SDK callbacks.

## What This Actually Refers To

The relevant future capability is an SDK-backed host that can:
- intercept tool-approval requests
- present structured questions to the user
- return those answers so the workflow can continue

This is the layer often associated with:
- `canUseTool`
- `AskUserQuestion`

Important boundary:
- this is a host/runtime capability
- it is not something the base repo can enable by itself

## Why It Fits This Repo

This is a strong fit because the kit already leans toward:
- guided initialization
- friendlier bootstrap
- clearer approval-heavy flows
- stronger planning guidance
- future app-surface exploration

The most natural owner is still `@master`.

## Best Future Use Cases

The strongest future use cases are:

1. Guided bootstrap
- repo-type selection
- stack-family selection
- backlog visibility preference
- local-context opt-in

2. Approval-heavy flows
- plan save approval
- ADR save approval
- release-governance checkpoints
- Git/GitHub go or no-go confirmations

3. Structured planning support
- narrowing a broad request into a few choices
- clarifying a preferred mode or workflow
- reducing ambiguity for non-expert users

4. Guided intake or onboarding flows
- collecting a few strong signals before choosing a path
- producing a concise summary instead of a raw transcript
- routing a user toward the right workflow, pack, or next step

## What The Core Repo Should Do Today

The core repo should:
- keep prompt-based guided questioning
- keep approval steps explicit in `@master`
- shape prompts so they are easy to map into structured UI later
- document the future compatibility path honestly

The core repo should not:
- claim native SDK user-input support
- imply that `AskUserQuestion` exists in markdown-only mode
- pretend host-side approvals are already available

## Good Prompt-Design Targets

The best current places to keep future-compatible are:
- bootstrap questions
- backlog mode selection
- plan visibility selection
- local-context opt-in
- release and push checkpoints

Good pattern:
- small batches
- clear choices
- low ambiguity
- explicit approval moments
- one strong question at a time when the user is still orienting
- structured summaries that can feed later workflow steps

## Relationship To The App Surface

This is a future app-surface enabler, not a separate product direction.

The intended progression is:
- prompts stay usable in plain chat today
- the repo defines clear approval and question points
- a future SDK/app host can later render those more cleanly through structured UI

One especially strong future use case is a guided intake or onboarding experience:
- ask a short sequence of high-signal questions
- reduce ambiguity before the main workflow begins
- create a compact structured summary
- route the user into the most appropriate next path

That pattern stays compatible with the current markdown-first model because the same logic can still be expressed as prompt-driven questioning today.

That makes this a compatibility target for:
- future product surfaces
- future onboarding flows
- future approval UI

## Risks

The main risks are:
- implying runtime support that does not exist yet
- over-designing around a host feature before there is a host
- making the core docs sound more magical than the actual repo behavior

## Recommended Position

Treat Agent SDK user input as:
- optional
- future-facing
- app-host dependent
- high-value for usability

But keep the current repo:
- prompt-first
- markdown-first
- honest about its boundaries

## Related Docs

- `docs/APP_SURFACE_AND_MCP.md`
- `docs/BOOTSTRAP.md`
- `docs/AGENT_WORKFLOWS.md`
- `docs/SYSTEM_REFERENCE.md`
