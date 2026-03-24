# claude-team-kit

A production-ready Claude Code workspace starter kit — clone or copy into any project to get an entire professional team of AI agents, skills, hooks, and rules working for you immediately.

## What's Inside

```
.claude/
├── agents/          14 specialized agents (developer, architect, QA, PM, devil's advocate...)
├── skills/          15+ slash commands (code-review, fix-bug, business-case, create-pr...)
├── rules/           Modular rule files for Python, TypeScript, security, testing, git...
├── hooks/           Shell automations (auto-format, secret detection, file protection...)
└── agent-memory/    Persistent per-agent memory (grows over time)
CLAUDE.md            Master briefing file — customize this per project
.mcp.json            MCP server config (GitHub pre-configured)
settings.json        Hook pipeline and permission allowlists
```

## Quick Start

1. Copy this entire folder into your project root (or use as a template repo)
2. Edit `CLAUDE.md` to match your project's stack and conventions
3. Copy `.claude/settings.local.json.example` → `.claude/settings.local.json` and fill in your tokens
4. Add your `GITHUB_TOKEN` to environment or settings.local.json
5. Run `chmod +x .claude/hooks/*.sh` to make hooks executable
6. Open Claude Code: `claude`

## The Team

| Agent | Role |
|---|---|
| `@senior-developer` | Clean, production-ready implementation |
| `@architect` | System design & technical decisions |
| `@debugger` | Deep debugging & root cause analysis |
| `@researcher` | Technology research & best practices |
| `@qa-engineer` | Test plans, coverage, edge cases |
| `@security-auditor` | Vulnerability scanning & hardening |
| `@performance-engineer` | Profiling & optimization |
| `@product-owner` | User stories, acceptance criteria |
| `@project-manager` | Timelines, blockers, sprint planning |
| `@business-analyst` | Requirements, ROI, business cases |
| `@customer-advocate` | Customer perspective & UX empathy |
| `@devils-advocate` | Challenge assumptions, find flaws |
| `@risk-officer` | Risk, compliance, "what could go wrong" |
| `@judge` | Final evaluation — business + technical verdict |

## Key Skills (Slash Commands)

`/code-review` `/fix-bug` `/implement-feature` `/write-tests` `/refactor`
`/security-audit` `/optimize-performance` `/write-docs` `/explain-code`
`/git-commit` `/create-pr` `/business-case` `/sprint-planning` `/research`
`/daily-standup` `/retrospective`

## Customization

- Add project-specific rules to `CLAUDE.md` using `@.claude/rules/your-rule.md`
- Create new agents in `.claude/agents/` following the existing pattern
- Add new skills in `.claude/skills/your-skill/SKILL.md`
- Hook scripts auto-run — configure which ones fire in `settings.json`

## Updating This Kit

This repo is your personal Claude workspace library. Update it as you discover better
prompts, new agents, or improved workflows. Tag versions to track what worked.
