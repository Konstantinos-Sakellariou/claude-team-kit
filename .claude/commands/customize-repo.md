# /customize-repo

## Purpose

Explicitly trigger a repo-specific customization pass when a copied kit already exists but still needs to become much more project-specific.

## Owned By

- Lead: `@master`
- Common support: `@tech-writer`, `@architect`, `@workspace-updater`

## What It Should Do

1. check whether the repo is still too generic or only partially customized
2. use the `Listen → Summarize → Deepen` pattern before proposing changes
3. decide whether the repo needs:
   - lightweight briefing refinement
   - deeper repo-specific customization
   - or no customization at all
4. tighten the right layers as needed:
   - `README.md`
   - `CLAUDE.md`
   - `AGENTS.md`
   - repo-specific commands, agents, skills, hooks, or local-context structure when justified
5. keep reusable kit truth separate from repo-specific overlay logic

## Output

- a visible customization summary
- clearer repo-specific briefing updates when needed
- a recommendation for any next customization layers that should be added later

## Notes

- do not use this as an excuse to rewrite a repo that is already well-shaped
- prefer targeted customization over broad churn
- use this when the repo is no longer brand-new, but still not specific enough to support high-quality work safely
