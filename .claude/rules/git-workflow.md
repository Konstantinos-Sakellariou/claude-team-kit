# Git Workflow Rules

## Branches
- `main` — production, always deployable, protected
- `develop` — integration branch (use if team > 2 people)
- `feature/short-description` — new features
- `bugfix/short-description` — bug fixes
- `hotfix/short-description` — urgent production fixes
- `chore/short-description` — tooling, deps, non-functional changes
- `docs/short-description` — documentation only

Branch off from `main` (or `develop` if using GitFlow).
Delete branches after merge.

## Commits — Conventional Commits
Format: `<type>(<scope>): <short description>`

Types:
- `feat` — new feature (triggers MINOR version bump)
- `fix` — bug fix (triggers PATCH version bump)
- `docs` — documentation only
- `style` — formatting, no logic change
- `refactor` — restructuring, no behavior change
- `perf` — performance improvement
- `test` — adding or fixing tests
- `chore` — build, tooling, dependencies
- `ci` — CI/CD changes
- `revert` — reverting a previous commit
- `BREAKING CHANGE` — in footer, triggers MAJOR version bump

Examples:
```
feat(auth): add OAuth2 Google login
fix(api): handle null user in profile endpoint
refactor(db): extract connection pooling to separate module
chore(deps): upgrade FastAPI to 0.110
```

## Commit Rules
- Commits are atomic — one logical change per commit
- Present tense imperative: "add feature" not "added feature"
- Subject line under 72 characters
- Add a body when the WHY isn't obvious
- Reference issues: `Closes #123` or `Refs #456` in footer
- Never commit directly to `main`
- Never force-push to shared branches

## Pull Requests
- Title follows same format as conventional commits
- Description includes: what changed, why, how to test, screenshots if UI
- Link to the related issue
- Keep PRs focused — one logical change
- Squash trivial fixup commits before merging
- Delete branch after merge

## Before Every Commit
1. Run linter: no new warnings
2. Run tests: all passing
3. Run type checker
4. Review your own diff — no debug code, no console.log, no secrets

## Tags & Releases
- Use semantic versioning: `v1.2.3`
- Tag releases on main
- Write a CHANGELOG entry for every release
