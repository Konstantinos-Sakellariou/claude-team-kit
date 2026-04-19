# RTK Integration

This repo supports RTK as an **optional local efficiency layer**.

Use it when you want to reduce noisy shell output before it reaches the model.  
Do not treat it as a required dependency of `claude-team-kit`.

## What RTK Is

RTK here means the token-optimization CLI from:
- [`rtk-ai/rtk`](https://github.com/rtk-ai/rtk)

It sits in front of noisy shell commands and compresses the output before it reaches the model context.

That makes it a good fit for:
- `git status`
- `git diff`
- `git log`
- verbose test output
- verbose lint output
- noisy `find`, `grep`, `rg`, or read-like shell workflows

## Why It Fits This Kit

This kit already emphasizes:
- read narrow first
- triage large inputs before deep reasoning
- specialist-first routing for noisy evidence
- model and context efficiency

RTK fits that direction because it can reduce avoidable shell noise during local LLM-assisted development without changing the core workflow model.

## Why It Stays Optional

RTK should stay optional because:
- not every user wants another local binary
- not every environment needs it
- some tasks still need raw output fidelity
- this kit should remain portable even when RTK is absent

If RTK is not installed, nothing in the kit should break.

## Correct Project Warning

There is a naming collision around `rtk`.

If you want the token-optimization tool for AI coding workflows, use:
- [`rtk-ai/rtk`](https://github.com/rtk-ai/rtk)

After installation, verify you have the right tool with:

```bash
rtk --version
rtk gain
which rtk
```

If `rtk gain` does not work, you likely installed the wrong package.

## Installation

Official project source:
- [rtk-ai/rtk README](https://github.com/rtk-ai/rtk/blob/master/README.md)
- [rtk-ai/rtk INSTALL.md](https://github.com/rtk-ai/rtk/blob/master/INSTALL.md)

Common install paths from the official project include:

### Homebrew

```bash
brew install rtk
```

### Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
```

### Verify

```bash
rtk --version
rtk gain
```

## Quick Start

The official project currently documents initialization like this:

```bash
rtk init -g
```

There are also tool-specific variants such as Codex support in the upstream docs.

After initialization:
- restart the supported coding tool if needed
- verify the hook is actually active
- only rely on RTK when local behavior is confirmed

## Best Fit

RTK helps most when:
- the work is shell-heavy
- commands are repetitive and noisy
- the main problem is output volume, not missing reasoning
- compressed output is good enough for the next step

Good examples:
- repeated git inspection during review
- repeated test/lint loops
- shell-based large-input triage
- noisy repo exploration in bigger projects

## Weak Fit

RTK helps less when:
- output is already short
- exact raw output matters more than compression
- you are debugging a format-sensitive issue
- the workflow is mostly using tool-native readers rather than shell commands

## Recommended Usage In This Kit

Recommended stance:
- yes for local personal use
- yes for larger repos with noisy shell workflows
- no as a required dependency
- no as a default assumption in prompt logic

`@master` should only prefer RTK when:
- it is already installed locally
- the command is noisy enough to benefit
- filtered output is appropriate for the task

## Practical Rule

Use RTK to reduce shell noise.  
Do not use RTK as a substitute for:
- reading the right file
- narrowing scope
- triaging evidence properly
- routing to the right specialist

RTK is an optimization layer, not a reasoning layer.
