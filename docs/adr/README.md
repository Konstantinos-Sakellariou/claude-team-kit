# ADR Directory

Use `docs/adr/` for approved architecture or policy decisions that should persist beyond a single conversation.

Suggested naming:

- `001-decision-name.md`
- `002-another-decision.md`

Required ADR sections:

- Title (`# ADR-001: Decision Title`)
- Date
- Status
- Deciders
- Context
- Decision
- Rationale
- Alternatives Considered
- Consequences

Optional ADR sections:

- Risks
- Revisit When
- Related Decisions
- Follow-Up Docs

File naming rule:

- use zero-padded numeric filenames without repeating the `ADR-` prefix in the file path
- example: `docs/adr/001-decision-name.md`

The ADR title inside the file should still use the ADR label, for example:

- `# ADR-001: Use a private local backlog by default`

`@idea-executor` and `@master` should not save ADRs here without explicit user approval.

Default ownership:

- `@master` decides when a conversation produced an ADR-worthy decision and proposes the save path
- `@architect` owns the technical substance of the record
- `@devils-advocate` and `@judge` pressure-test the reasoning
- `@tech-writer` writes the final ADR after approval
- `@workspace-updater` aligns the rest of the core docs afterward
