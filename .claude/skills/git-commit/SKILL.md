---
name: git-commit
description: Create a well-structured conventional commit. Reviews the staged changes, writes a high-quality commit message, and commits. Use after staging your changes.
allowed-tools: Bash
model: haiku
disable-model-invocation: false
---

Create a conventional commit for the currently staged changes.

## Process

1. Run `git diff --cached` to see what's staged
2. If nothing is staged, run `git status` and report what's unstaged
3. Analyze the changes:
   - What TYPE of change is this? (feat/fix/refactor/docs/chore/test/perf/ci)
   - What SCOPE does it affect? (optional: module/component name)
   - What is the SHORT description? (imperative mood, under 72 chars)
   - Is a longer body needed? (explain WHY, not what — the diff shows what)
   - Are there breaking changes?
   - Are there issue references? (Closes #N, Refs #N)

4. Construct the commit message:
```
<type>(<scope>): <short description>

[optional body: explain WHY, context, trade-offs]

[optional footer: Closes #123, BREAKING CHANGE: ...]
```

5. Run the commit:
```bash
git commit -m "$(cat <<'EOF'
<your message here>
EOF
)"
```

6. Confirm success and show the commit hash

## Rules
- Imperative mood: "add feature" not "added feature"
- Subject line under 72 characters
- No period at the end of subject line
- Body explains WHY, not WHAT (the diff shows what)
- NEVER commit if: tests are failing, linter has errors, secrets detected
- If unsure of type, default to `feat` (new things) or `fix` (corrections)
