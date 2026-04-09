# New Repo Bootstrap

When `claude-team-kit` is dropped into a repo other than itself, `@master` should check whether the project briefing still looks generic before major work begins.

This bootstrap flow exists to stop the most common failure mode of template-based adoption:
- the tooling is present
- but `CLAUDE.md`, `AGENTS.md`, and `README.md` still describe the kit instead of the real project

## What Bootstrap Does

When bootstrap is needed, `@master` should:

1. explain briefly why the repo still looks under-configured
2. ask a short structured set of questions
3. accept partial answers
4. make clearly labeled temporary assumptions when the user does not know something yet
5. draft or improve the project-facing docs
6. hand off to `@workspace-updater` as the final alignment step

## When It Should Trigger

Bootstrap is appropriate when a repo outside `claude-team-kit` still looks template-like.

Common signs:
- `CLAUDE.md` missing
- `AGENTS.md` missing
- `README.md` missing or extremely thin
- project metadata still points at `claude-team-kit`
- stack and commands still describe the kit rather than the project
- architecture notes lack concrete project facts

## When It Should Not Trigger

Do not run bootstrap when:
- the current repo is `claude-team-kit`
- the docs already look clearly customized
- the user is asking for a tiny tactical task and bootstrap would only create friction
- the repo already completed bootstrap recently and the context is still valid

## Question Areas

The bootstrap question flow should stay lightweight and adaptive.

Good question areas:
- what the project is and who it serves
- likely stack, framework, runtime, or platform
- key commands
- important folders, modules, routes, or services
- deployment constraints and gotchas
- preferred backlog mode: private local or tracked public
- whether the repo should use the private local context layer for sensitive business, customer, or strategy notes

## Flexibility Rule

Users will not always know the exact stack, deployment shape, or architecture yet.

That is fine.

`@master` should:
- ask what the user does know
- infer sensible temporary assumptions when needed
- label assumptions clearly
- avoid pretending uncertain information is final

The goal is better working context, not perfect upfront documentation.
