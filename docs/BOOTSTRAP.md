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
6. recommend a cleanup pass once the repo is clearly customized enough to prune generic kit leftovers
7. hand off to `@workspace-updater` as the final alignment step

Bootstrap should improve context quality, not create bloated briefing files.

Capture the high-signal facts first and move deeper detail into linked docs when that is cleaner.

Bootstrap should also start with a simple listening discipline:
- listen carefully to what the user already revealed
- summarize the understood project shape back briefly
- deepen only where more information is actually needed

That keeps setup collaborative instead of interrogative.

## Bootstrap Versus Customization

Bootstrap and customization are related, but they are not the same workflow.

Use `bootstrap` when:
- the repo still looks generic
- key briefings are missing
- the project shape is still unclear

Use `customization` when:
- the repo already exists and has some identity
- but the briefing, workflow, or agent layer still feels too generic for the real project
- or the repo has grown enough that it needs a stronger project-specific overlay

The idea is:
- bootstrap gets the repo out of template mode
- customization gets the repo into project-specific operating mode

## Guided Initialization

Bootstrap is the trigger. Guided initialization is the collaborative mode `@master` can use inside that bootstrap when the repo is still especially underdefined.

Use guided initialization when:
- the repo is new and still vague
- the user is shaping the project while setting up the workspace
- the user does not yet know every technical detail
- a few rounds of collaborative questioning will produce much better docs than one rigid questionnaire

Guided initialization should:
- ask in small rounds rather than one long form
- keep each round high-signal and realistic to answer
- help the user with candidate categories, stack guesses, or draft wording when they are unsure
- clearly separate confirmed facts from temporary assumptions
- stop as soon as the repo briefing is good enough to support normal work

Guided initialization should not:
- trigger in already-customized repos without a clear gap
- interrupt tiny tactical tasks
- become a blocking setup wizard
- stuff speculative detail into `CLAUDE.md`, `AGENTS.md`, or `README.md`

## Listen → Summarize → Deepen

When bootstrap or customization is active, `@master` should follow this pattern:

1. Listen
   - notice what the user already told us
   - infer what parts of the repo or business are already clear
2. Summarize
   - reflect the understood project shape briefly before diving into edits or more questions
3. Deepen
   - ask only the smallest necessary follow-up questions, or proceed with labeled assumptions when enough is already clear

This keeps the workflow high-trust and makes it easier for users to confirm that the repo is being shaped in the right direction.

## Company-Building Workflow Mode

Sometimes a copied repo is not only under-configured technically. It is also under-defined as a product and operating workspace.

When the user is shaping a startup, studio, digital service, or early product while also setting up the repo, `@master` should extend guided initialization into a company-building workflow mode.

That mode should:
- keep the same small-round, high-signal questioning style
- clarify product, customer, and operating-model context together
- separate public reusable repo truth from private local company or product-incubation context
- recommend which teams, workflows, and artifacts should become reliable first

That mode should not:
- become a giant founder questionnaire
- force business planning into tracked docs
- pretend the kit itself is a runtime company platform

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
- when founder or company-building mode is active: product promise, target customer, offer or workflow shape, early function needs, and the first delivery loop that should become reliable

## Suggested Rounds

### Round 1: What Is This?

Focus on:
- what the project is
- who it serves
- what kind of product or system it is

### Round 2: How Does It Work?

Focus on:
- likely stack or runtime
- important commands
- key folders, pages, modules, or services

### Round 3: What Should Agents Not Get Wrong?

Focus on:
- deployment constraints or gotchas
- private local context needs
- backlog preference
- any documentation sync expectations

### Founder / Company-Building Rounds

Use these when founder or product-definition work is mixed into setup:

#### Round 1: What Product Are We Actually Building?

Focus on:
- the product or service idea
- who it serves
- what painful problem it solves

#### Round 2: How Should This Operate?

Focus on:
- the likely delivery loop or service model
- which functions matter first
- whether the repo is mainly product delivery, product studio, internal ops, or a hybrid

#### Round 3: What Belongs In Public Briefings Versus Local Context?

Focus on:
- which details are safe tracked repo truth
- which details should stay in `.claude/local-context/`
- which teams or workflows should become reliable first

## Flexibility Rule

Users will not always know the exact stack, deployment shape, or architecture yet.

That is fine.

`@master` should:
- ask what the user does know
- infer sensible temporary assumptions when needed
- offer candidate answers or categories when that helps the user think
- label assumptions clearly
- avoid pretending uncertain information is final

When company-building mode is active, `@master` should also:
- keep tracked docs focused on safe operating truth
- recommend local context for sensitive founder, product-incubation, or company notes
- surface an initial team or workflow recommendation once the first operating loop becomes clear

The goal is better working context, not perfect upfront documentation.

## Post-Bootstrap Cleanup

Once the repo has a real identity and the main docs are no longer generic, run a cleanup review.

The cleanup goal is to decide which copied-kit artifacts should now be:
- kept
- customized
- deleted

Use the `repo-cleanup` skill for that pass rather than leaving template leftovers in place forever.
