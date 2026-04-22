# Design Packs

## Purpose

Design packs are the optional layer that sits between the generic kit and a repo's real visual or brand system.

They help a repo start from a stronger design foundation without forcing one aesthetic, one `DESIGN.md` convention, or one brand language across every project.

## How They Fit

The intended model is:

1. `core kit`
2. `starter packs`
3. `solution packs`
4. `design packs`

That means:
- the core kit provides orchestration, teams, rules, memory, and governance
- starter packs shape the broad repo type
- solution packs shape the stack foundation
- design packs shape the visual, brand, and design-system starting point

## Design Packs Vs Starter Packs And Solution Packs

Starter packs answer:
- what kind of repo is this?

Solution packs answer:
- what stack foundation should this repo start from?

Design packs answer:
- what visual or brand foundation should this repo start from?

Examples:
- `Startup Studio` starter pack -> broad operating shape
- `Supabase application foundation` solution pack -> operational stack foundation
- `Clean SaaS product` design pack -> visual and design-system foundation

## Relationship To `DESIGN.md`

`DESIGN.md` is a useful optional artifact, not a hard dependency.

For this repo, the right rule is:
- support a `DESIGN.md`-style artifact when it helps
- keep the concept broader than one external format
- let the `Design Team` own how it is interpreted

So the design-pack layer should work with:
- `DESIGN.md`
- design token docs
- brand briefs
- starter visual-system notes

## What A Design Pack Should Contain

Every design pack should define:

1. Design intent
- audience
- brand feel
- product posture
- trust level

2. Visual foundations
- color direction
- typography direction
- spacing and rhythm
- component tone

3. Surface rules
- app versus marketing guidance
- layout density
- motion bias
- illustration or icon posture

4. Guardrails
- what to avoid
- what would cause design drift
- accessibility considerations

5. Example use cases
- where the pack fits
- where it does not fit

## What A Design Pack Should Not Become

Design packs should not become:
- cloned brand kits
- one aesthetic forced onto every repo
- a replacement for product-specific design judgment
- decorative bloat in the shared core

The design-pack layer should create stronger starting points, not erase customization.

## Public Vs Local Boundary

Tracked/public-safe:
- design-pack architecture guidance
- optional format examples
- generic pack descriptions
- reusable design-system starting points

Local/private:
- actual business brand direction
- customer-specific design decisions
- in-progress visual experiments
- sensitive positioning or market context

## `DESIGN.md` Workflow

Use an optional `DESIGN.md` when the repo benefits from a compact design brief that helps agents and designers stay aligned.

Good uses:
- app or site work with a clear brand direction
- multiple surfaces that should feel coherent
- onboarding a repo that needs faster visual consistency

What `DESIGN.md` should usually contain:
- who the surface is for
- how it should feel
- what visual principles matter most
- what to avoid
- any token or component constraints worth keeping stable

What it should not become:
- a giant moodboard dump
- a full Figma replacement
- duplicated product or backlog strategy

## Recommended First Design-Pack Types

The strongest first candidates are:

1. [`Clean SaaS product`](design-packs/clean-saas.md)
2. [`Startup studio / founder service`](design-packs/startup-studio.md)
3. [`Premium service / advisory`](design-packs/premium-service.md)
4. [`Technical console / dashboard`](design-packs/technical-console.md)

## Related Docs

- `docs/DESIGN_REFERENCE.md`
- `docs/design-packs/README.md`
- `docs/design-packs/clean-saas.md`
- `docs/design-packs/startup-studio.md`
- `docs/design-packs/premium-service.md`
- `docs/design-packs/technical-console.md`
- `docs/solution-packs/README.md`
- `docs/PROJECT_CUSTOMIZATION.md`
- `docs/SYSTEM_REFERENCE.md`
