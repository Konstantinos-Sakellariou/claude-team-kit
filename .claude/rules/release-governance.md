# Release Governance

Use this rule when work is approaching:
- a release
- a release candidate
- a public push with release implications
- a merge-critical change with operational risk

## Purpose

Release governance exists to make high-risk GitHub and delivery flows repeatable.

The goal is not bureaucracy. The goal is to avoid shipping code or workflow changes that are:
- unsafe
- under-tested
- poorly explained
- operationally fragile
- privacy-sensitive

## Default Release Governance Sequence

For release-heavy or merge-critical work, `@master` should prefer this sequence:

1. `@github-safety-guard`
2. `@privacy-reviewer`
3. `@code-reviewer` when code changed
4. `@qa-engineer` when behavior changed
5. `@production-readiness-reviewer`
6. `@changelog-writer`
7. `@risk-officer`
8. `@workspace-updater` when release behavior, docs, or conventions changed

## Mandatory Questions

Before calling a release path "ready," the system should be able to answer:
- Are there unresolved disclosure or secret risks?
- Are tests adequate for the behavior that changed?
- Are rollback, migration, or environment risks understood?
- Are release notes or changelog updates needed?
- Does the user understand any remaining non-blocking risk?

## Blocking Conditions

Do not treat the release path as ready when:
- `@github-safety-guard` reports `NO`
- `@privacy-reviewer` finds unresolved public/private boundary risk
- `@code-reviewer` finds unresolved blocking issues
- `@qa-engineer` says meaningful tests are still missing
- `@production-readiness-reviewer` reports `NOT READY`
- `@risk-officer` does not sign off on a high-risk release path

## Non-Blocking Findings

Non-blocking concerns may remain only when:
- they are clearly identified
- they are lower severity
- the user can make an informed proceed / do not proceed decision

## Expected Output

Release-governance reporting should clearly state:
- release scope
- which gates ran
- blocking findings
- non-blocking findings
- changelog / release-note status
- final recommendation:
  - `READY`
  - `READY WITH NOTED RISK`
  - `NOT READY`

## Notes

- This rule strengthens the Git / GitHub Team rather than replacing it.
- Use the `Git / GitHub Team` as the coordination layer for release-governance work.
- Keep the process stricter for public or production-facing changes than for tiny local-only edits.
