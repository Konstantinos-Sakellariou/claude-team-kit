# ADR Directory

Use `docs/adr/` for approved architecture or policy decisions that should persist beyond a single conversation.

Suggested naming:

- `001-decision-name.md`
- `002-another-decision.md`

Typical ADR sections:

- Context
- Decision
- Alternatives Considered
- Consequences
- Status

`@idea-executor` and `@master` should not save ADRs here without explicit user approval.

Default ownership:

- `@master` decides when a conversation produced an ADR-worthy decision and proposes the save path
- `@architect` owns the technical substance of the record
- `@devils-advocate` and `@judge` pressure-test the reasoning
- `@tech-writer` writes the final ADR after approval
- `@workspace-updater` aligns the rest of the core docs afterward
