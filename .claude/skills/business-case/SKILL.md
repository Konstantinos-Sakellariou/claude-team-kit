---
name: business-case
description: Write or evaluate a business case for a feature, initiative, or investment. Analyzes ROI, risks, alternatives, and produces a structured document suitable for stakeholder review.
allowed-tools: Read, WebSearch, Glob
model: opus
argument-hint: [initiative or feature to evaluate]
---

Write a business case for: $ARGUMENTS

## Business Case Development Process

### Step 1: Problem Discovery
Before proposing solutions, deeply understand the problem:
- Who experiences this problem? (Be specific — persona/segment)
- How often? How severely?
- What does it cost today? (Time, money, lost revenue, customer churn)
- What's the evidence? (Data, user feedback, support tickets, interviews)

### Step 2: Solution Definition
- What specifically are we proposing to build/do?
- What is explicitly NOT included?
- What are the viable alternatives (including "do nothing")?

### Step 3: Financial Modeling
For each alternative, estimate:
- Investment: engineering time, infrastructure, licensing, maintenance
- Return: revenue gain, cost savings, risk reduction
- Timeline: when does ROI turn positive?
- Confidence: how certain are these numbers?

### Step 4: Risk Assessment
- What could prevent this from achieving expected returns?
- What are the technical risks?
- What external dependencies exist?
- What's the cost of being wrong?

## Output: Full Business Case

```markdown
# Business Case: [Title]
**Date:** | **Requested by:** | **Status:** Draft

## Executive Summary
[5-7 sentences: problem, solution, investment, expected return, recommendation]

## Problem Statement
**The Problem:** [Specific, evidence-backed description]
**Affected Users:** [Who and how many]
**Current Cost:** [Quantified impact of the problem today]
**Evidence:** [Data, research, customer quotes]

## Proposed Solution
**What:** [Specific description]
**Why this approach:** [Key reasoning]
**Out of Scope:** [Explicit exclusions]

## Financial Analysis
| Item | Year 1 | Year 2 | Year 3 |
|------|--------|--------|--------|
| Investment | | | |
| Revenue impact | | | |
| Cost savings | | | |
| Net benefit | | | |
| **Cumulative ROI** | | | |

**Payback period:** [X months]
**Confidence level:** [Low/Medium/High — explain why]

## Alternatives
| Option | Investment | Expected Return | Risks | Recommendation |
|--------|-----------|-----------------|-------|---------------|
| Build (proposed) | | | | ✓ Recommended |
| Buy existing solution | | | | |
| Do nothing | $0 | [cost of status quo] | | |

## Risk Register
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|

## Success Metrics
| Metric | Baseline | Target | Measurement |
|--------|----------|--------|------------|

## Recommendation
**PROCEED / DEFER / REJECT**
[Clear reasoning in 3-5 sentences]

## Appendix
[Supporting data, research, customer feedback]
```
