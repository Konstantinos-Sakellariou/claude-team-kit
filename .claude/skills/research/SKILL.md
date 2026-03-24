---
name: research
description: Research a technology, library, pattern, or decision. Searches current sources, synthesizes findings, and delivers a structured research report with a clear recommendation.
allowed-tools: WebSearch, WebFetch, Read
model: sonnet
argument-hint: [topic or question to research]
---

Research the following: $ARGUMENTS

## Research Process

### Step 1: Define the research question
What specific decision or question will this research inform?
What depth is needed? (Quick scan → Standard → Deep dive)

### Step 2: Search strategically
Search for:
- Official documentation / GitHub repo
- "production experience [topic]" — real-world lessons
- "[topic] vs [alternatives]" — comparative analysis
- "[topic] issues" / "[topic] problems" — known failure modes
- Recent articles (use current year in search terms)

### Step 3: Evaluate sources
- Official docs: authoritative but may not reflect real-world use
- GitHub issues/discussions: real production problems
- Blog posts from engineers at scale companies: high signal
- Reddit/HN threads: mixed, but often surface real trade-offs
- Tutorials: useful for basics, not for production decisions
- Check publication dates — tech moves fast

### Step 4: Synthesize (don't just list links)
Organize findings into:
- What it is and what problem it solves
- How it works (key concepts only)
- Production usage evidence (who uses it, at what scale)
- Known limitations and failure modes
- Comparison to alternatives
- Clear recommendation

## Output Format

```
## Research Report: [Topic]
*Researched: [date] | Sources: [N] | Depth: Quick / Standard / Deep*

### TL;DR
[2-3 sentences: what you found and what you recommend]

### Key Findings
[The most important facts, with evidence]

### Options Comparison (if applicable)
| Option | Maturity | Performance | DX | Community | Best For |
|--------|---------|-------------|----|-----------|---------||

### Recommendation
[Specific recommendation with clear reasoning]

### Risks & Unknowns
[What you couldn't verify, open questions, risks to watch]

### Sources
- [Title](url) — [why this source matters]
```
