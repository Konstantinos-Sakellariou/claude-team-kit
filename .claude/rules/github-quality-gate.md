# GitHub Quality Gate Rules

## Core Principle
- Code should not be committed, pushed, or packaged for PR as "ready" unless it meets production-minded quality standards

## Required Gates For Code-Affecting Changes
- `@github-safety-guard` for secret, disclosure, and repo-safety review
- `@code-reviewer` for correctness, standards, maintainability, and merge readiness
- `@qa-engineer` for meaningful behavior and regression coverage
- `@security-auditor` when auth, secrets, external input, or exposed surfaces are involved
- `@production-readiness-reviewer` for release-heavy, merge-critical, migration-heavy, or operationally risky changes

## High Standard Definition

A change is GitHub-ready only when it meets all of the following:
- correct behavior
- readable and maintainable implementation
- compliance with repo rules and language expectations
- adequate tests for changed behavior
- no unresolved P0 or P1 findings
- no unresolved secret or disclosure risk
- docs or changelog updates when behavior or workflow changed
- merge or release posture is clearly understood

## Blocking Policy

Block commit, push, PR, or release progression when:
- `@github-safety-guard` reports `NO`
- `@code-reviewer` reports unresolved blocking findings
- required test coverage is missing for changed behavior
- unresolved security issues remain
- `@production-readiness-reviewer` says the change is not ready

Allow progression with explicit user approval only when:
- findings are non-blocking
- follow-up work is clearly separated
- the residual risk is explained honestly

## Standards Guidance

- Python should satisfy project Python rules and PEP 8 expectations
- TypeScript and JavaScript should satisfy project TypeScript and code-quality rules
- Shell, JSON, Markdown, and config changes should be syntactically clean and production-appropriate
- "Works on my machine" is not a production standard
