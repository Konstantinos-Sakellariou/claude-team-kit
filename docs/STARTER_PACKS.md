# Starter Project Packs

## Purpose

Starter packs help a copied repo move from a generic workspace kit to a more concrete project shape faster.

They are:
- optional
- markdown-first
- intended as adaptation overlays

They are not:
- a second runtime layer
- a replacement for bootstrap
- a reason to make the shared core overly specific

Use a starter pack when a repo clearly resembles a common product pattern and you want faster customization of:
- `README.md`
- `CLAUDE.md`
- `AGENTS.md`
- local context
- team-routing expectations

## How The Packs Fit

The intended flow is:

1. copy or set up the kit
2. let `@master` bootstrap the repo if the project brief still looks generic
3. choose the closest starter pack
4. use the pack to shape the project briefing and local context
5. prune generic leftovers with the `repo-cleanup` skill once the repo is specific enough

Starter packs should accelerate customization, not replace it.

## How They Relate To Solution Packs

Starter packs and solution packs solve different problems.

Use starter packs to answer:
- what kind of repo is this?

Use solution packs to answer:
- what stack foundation should this repo start from?

Examples:
- `Startup Studio` starter pack -> broad operating shape
- `Supabase application foundation` solution pack -> concrete stack foundation

See `docs/SOLUTION_PACKS.md` for the pack-contract layer.

## Available Packs

| Pack | Best For | Main Focus |
|---|---|---|
| [`SaaS App`](starter-packs/saas-app.md) | multi-page product apps, dashboards, auth-heavy SaaS products | app structure, auth, billing, support/admin surfaces |
| [`API Service`](starter-packs/api-service.md) | backend services, platforms, integrations, webhooks | service boundaries, contracts, envs, observability, rollout safety |
| [`AI/ML Product`](starter-packs/ai-ml-product.md) | model-backed products, evaluation-heavy apps, ML features | data/model flow, evaluation gates, monitoring, rollout risk |
| [`Startup Studio`](starter-packs/startup-studio.md) | portfolio builders, founder-led studios, multi-initiative product work | shared systems, venture context, company-building workflow, private context |

## What A Pack Should Influence

A strong starter pack should help you decide:
- what facts belong in `CLAUDE.md` and `AGENTS.md`
- which teams should become common defaults
- which local-context notes matter most
- which repo-specific gotchas are worth documenting early
- what cleanup should happen once the repo is project-specific

## What A Pack Should Not Do

Starter packs should not:
- hard-code product-specific facts into the shared kit
- create a second copy of the full repo docs
- replace the need for real project-specific decisions
- turn every repo into the same structure just because the pack exists

## Choosing A Pack

Choose the pack that matches the repo's operating shape, not just the tech stack.

Examples:
- auth, billing, admin surfaces, product dashboards → `SaaS App`
- endpoints, contracts, workers, jobs, integrations → `API Service`
- training, evaluation, prompts, experiments, model rollout → `AI/ML Product`
- multiple product bets, founder context, shared company systems → `Startup Studio`

If a repo spans multiple shapes, start with the primary operating model and then layer in project-specific briefing detail.

## Related Docs

- `docs/PROJECT_CUSTOMIZATION.md`
- `docs/SOLUTION_PACKS.md`
- `docs/BOOTSTRAP.md`
- `docs/LOCAL_CONTEXT.md`
- `docs/SYSTEM_REFERENCE.md`
