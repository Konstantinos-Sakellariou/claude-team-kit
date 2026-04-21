# Solution Packs

## Purpose

Solution packs are the optional layer that sits between the generic kit and a real startup or product stack.

They help a repo start from a stronger operational foundation without turning the shared core into a vendor-specific template.

## How They Fit

The intended model is:

1. `core kit`
2. `starter packs`
3. `solution packs`
4. `integration adapters`

That means:
- the core kit provides orchestration, teams, rules, memory, and governance
- starter packs shape the broad repo type
- solution packs shape the stack foundation
- integration adapters handle provider-specific wiring where it is actually useful

## Starter Packs Vs Solution Packs

Starter packs answer:
- what kind of repo is this?

Solution packs answer:
- what stack foundation should this repo start from?

Examples:
- `Startup Studio` starter pack -> broad operating shape
- `Supabase application foundation` solution pack -> concrete stack foundation

Starter packs are broader.
Solution packs are narrower and more operational.

## What A Solution Pack Should Contain

Every pack should define:

1. Purpose
- what problem it solves
- what repo or customer shape it fits

2. Scope boundary
- what it includes
- what it leaves out

3. Foundation surface
- expected directories
- config surfaces
- env contracts
- setup steps
- validation expectations

4. Workflow expectations
- how `@master` should route the relevant work
- which team owns the pack
- which quality gates are required

5. Provider and integration notes
- whether MCP is actually useful
- what can be done through CLI or env setup instead
- what credentials are required
- what is safe to track publicly

6. Customization rules
- what should be customized first
- what should stay generic
- what should move into local context or project-specific docs

## What A Solution Pack Should Not Become

Solution packs should not become:
- a monolithic app template
- a replacement for starter packs
- a hidden runtime dependency
- a vendor hard-lock for the whole repo
- a second copy of all core docs

The pack layer should accelerate setup, not bloat the shared kit.

## Public Vs Local Boundary

Tracked/public-safe:
- generic pack architecture
- reusable foundation guidance
- safe examples
- team and routing rules

Local/private:
- real business stack choices
- customer-specific credentials
- exact product integration decisions
- company-specific rollout order

If a pack needs sensitive implementation detail, keep the sequencing or private overlays local first and publish only the reusable safe portion.

## Recommended First-Wave Packs

The strongest first candidates are:

1. [`Supabase application foundation`](solution-packs/supabase-foundation.md)
2. [`GitHub + CI/CD foundation`](solution-packs/github-cicd-foundation.md)
3. `Vercel deployment foundation`

Why these first:
- they match the current startup-stack direction strongly
- they build on capabilities the kit already has
- they help real product repos move faster immediately

## Future Pack Categories

Later categories may include:
- deployment packs such as Cloudflare
- service packs such as Stripe, PostHog, Sentry, Resend, Clerk, Upstash, or Pinecone
- design packs for visual and brand-system starting points

Those should come later, after the pack contract proves itself.

## MCP And Credentials Guidance

Solution packs should not assume MCP by default.

Each pack should answer:
- is MCP worth it here?
- what can be done with file, env, or CLI setup instead?
- where do credentials live?
- what is safe to track publicly?

Preferred order:
1. file/env/CLI path first
2. MCP where it clearly improves the workflow
3. never put private credentials in tracked docs

## Example Mental Model

Think of a solution pack as:
- stronger than a starter pack
- lighter than a full template
- reusable across many repos
- customizable on top

So instead of saying:
- "Here is the one startup template everyone should use"

the kit should say:
- "Here is a solid foundation pack for the stack you are actually building on."

## Related Docs

- `docs/STARTER_PACKS.md`
- `docs/solution-packs/README.md`
- `docs/solution-packs/supabase-foundation.md`
- `docs/solution-packs/github-cicd-foundation.md`
- `docs/PROJECT_CUSTOMIZATION.md`
- `docs/SYSTEM_REFERENCE.md`
- `docs/LOCAL_CONTEXT.md`
