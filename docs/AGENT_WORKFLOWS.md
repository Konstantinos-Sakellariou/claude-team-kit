# Agent Workflows

All work flows through `@master`. Every example below starts and ends there.

`@master` receives the request, maps the full scope, announces the plan to the user before executing, dispatches agents (in parallel or sequentially depending on dependencies), synthesises their reports, resolves conflicts, and — once the user confirms — triggers `@workspace-updater` as the mandatory final step.

Four workflows are documented here, each demonstrating different collaboration patterns:

1. **Engineering Pipeline** — parallel spikes, sequential implementation, gated quality stages
2. **Content Publishing Pipeline** — research loop, human approval gate, parallel review, delivery feedback loop
3. **Full Project Launch** — dual parallel tracks (engineering + content) converging at a shared release gate
4. **Idea To Execution Planning** — idea shaping, adversarial validation, phased plan, optional backlog capture

---

## Workflow 1 — Engineering Pipeline

**Example trigger:** *"Add rate-limited authentication to the API"*

**Patterns demonstrated:** parallel research, sequential implementation, parallel QA + security, risk gate, workspace update.

```mermaid
flowchart TD
    USER(["👤 User request"])
    USER --> MASTER

    MASTER["@master\nReceives request\nMaps scope\nAnnounces plan"]

    MASTER --> PLAN(["📋 Plan announced to user\nbefore any execution begins"])

    PLAN --> STAGE1

    subgraph STAGE1 ["⚡ Parallel — Stage 1: Understand the problem"]
        direction LR
        ARCH["@architect\nDesigns the\nauthentication flow\nand data model"]
        RESEARCHER["@researcher\nSpikes JWT best\npractices, library\noptions, prior art"]
    end

    STAGE1 --> DEV

    DEV["@senior-developer\nImplements the feature\nbased on architect design\nand researcher findings"]

    DEV --> STAGE2

    subgraph STAGE2 ["⚡ Parallel — Stage 2: Review the implementation"]
        direction LR
        QA["@qa-engineer\nWrites test plan\nunit + integration\nedge cases"]
        SEC["@security-auditor\nReviews auth logic\ntokens, rate limits\ninjection surface"]
    end

    STAGE2 --> GATE1{"All reports\nback to master?"}

    GATE1 -->|"Issues found"| DEV
    GATE1 -->|"✓ Clean"| RISK

    RISK["@risk-officer\nFinal sign-off\nWhat could still\ngo wrong?"]

    RISK --> GATE2{"Master review\nAll clear?"}
    GATE2 -->|"Open items"| DEV
    GATE2 -->|"✓ Approved"| WU

    WU["@workspace-updater\nUpdates CLAUDE.md\nand README.md"]

    WU --> DONE(["✓ Feature shipped"])

    MASTER -. "orchestrates every stage" .-> DONE
```

**Key points:**
- `@architect` and `@researcher` run **in parallel** — they have no dependency on each other
- `@senior-developer` runs **after both** — it needs their outputs
- `@qa-engineer` and `@security-auditor` run **in parallel** — both review the same implementation independently
- `@master` collects both reports and resolves any conflicts before passing to `@risk-officer`
- Failed gates loop back — `@master` routes to the appropriate fix stage rather than starting over

---

## Workflow 2 — Content Publishing Pipeline

**Example trigger:** *"Plan and publish next week's newsletter"*

**Patterns demonstrated:** backlog-first research, human approval gate, parallel multi-reviewer stage, delivery execution, post-send feedback loop back to planning.

```mermaid
flowchart TD
    USER(["👤 Planning request"])
    USER --> MASTER

    MASTER["@master\nReceives request\nMaps full pipeline\nAnnounces plan"]

    MASTER --> BC

    BC["@backlog-curator\nScores and ranks existing\ntopic candidates\nSurfaces top picks"]

    BC --> TR

    TR["@topic-researcher\nFinds fresh sources\nfor top candidates\nAdds new finds"]

    TR --> STAGE1

    subgraph STAGE1 ["⚡ Parallel — Stage 1: Build and validate the plan"]
        direction LR
        CP["@content-planner\nBuilds structured\nweekly plan\nwith angles and prompts"]
        SV1["@source-verifier\nValidates source\ncandidates\nbefore planning locks in"]
    end

    STAGE1 --> HGATE{"👤 Human approval\nReview the plan\nbefore any writing"}

    HGATE -->|"Changes requested"| TR
    HGATE -->|"✓ Approved"| CW

    CW["@content-writer (opus)\nWrites the full draft\nAudience-appropriate\n~5 min read with sources"]

    CW --> STAGE2

    subgraph STAGE2 ["⚡ Parallel — Stage 2: Review the draft"]
        direction LR
        ER["@editorial-reviewer\nReadability, value,\nsource quality,\ndiscussion prompt"]
        TC["@tone-calibrator\nVoice and complexity\nfit for this\nspecific audience"]
        SV2["@source-verifier\nFinal source check\nAll links live\nAll claims supported"]
    end

    STAGE2 --> GATE1{"Master synthesis\nAll reviewers\npassed?"}

    GATE1 -->|"Revisions needed"| CW
    GATE1 -->|"✓ All clear"| PR

    PR["@privacy-reviewer\nPre-publish scan\nNo PII, no secrets\nno private data"]

    PR --> DO

    DO["@delivery-orchestrator\nRenders HTML and plain text\nChecks all gates passed\nDelivers via configured channel\nArchives edition"]

    DO --> DM

    DM["@delivery-monitor\nReads delivery receipt\nFlags bounces or errors\nWrites health summary"]

    DM --> FS

    FS["@feedback-synthesizer\nProcesses audience replies\nExtracts follow-up signals\nAdds to backlog"]

    FS -->|"Feeds next cycle"| BC

    DO --> WU

    WU["@workspace-updater\nArchive path updated\nCLAUDE.md + README current"]

    WU --> DONE(["✓ Edition delivered"])

    MASTER -. "orchestrates every stage" .-> DONE
```

**Key points:**
- `@backlog-curator` runs **before** research — existing knowledge shapes what gets researched
- `@content-planner` and `@source-verifier` run **in parallel** — planning and validation are independent at this stage
- The **human approval gate** is explicit — no writing starts on an unapproved plan
- Three reviewers run **in parallel** — `@master` collects all three reports, resolves any conflicts, and decides pass/fail as a single gate
- The **feedback loop** is structural — `@feedback-synthesizer` routes back to `@backlog-curator` and closes the cycle

---

## Workflow 3 — Full Project Launch

**Example trigger:** *"Ship the new feature and announce it publicly"*

**Patterns demonstrated:** dual parallel tracks (engineering and content), converging release gate, post-launch experimentation, mandatory privacy scan, changelog, workspace update.

```mermaid
flowchart TD
    USER(["👤 Launch request"])
    USER --> MASTER

    MASTER["@master\nMaps full scope\nSplits into two tracks\nAnnounces full plan\nbefore execution"]

    MASTER --> ENG_TRACK
    MASTER --> CNT_TRACK

    subgraph ENG_TRACK ["⚙️ Engineering Track"]
        direction TB
        E1["@architect\nDesigns the feature"]
        E2["@researcher\nSpikes dependencies"]
        E3["@senior-developer\nImplementation"]
        E4["@qa-engineer\nTest coverage"]
        E5["@security-auditor\nSecurity review"]
        E6["@risk-officer\nRelease risk check"]

        E1 --> E3
        E2 --> E3
        E3 --> E4
        E3 --> E5
        E4 --> E6
        E5 --> E6
    end

    subgraph CNT_TRACK ["📝 Content Track"]
        direction TB
        C1["@topic-researcher\nAnnouncement angle\nand supporting context"]
        C2["@content-writer (opus)\nDrafts announcement\nrelease notes, blog post"]
        C3["@editorial-reviewer\nQuality gate"]
        C4["@tone-calibrator\nAudience fit check"]
        C5["@source-verifier\nAll claims verified"]

        C1 --> C2
        C2 --> C3
        C2 --> C4
        C2 --> C5
    end

    ENG_TRACK --> CONV
    CNT_TRACK --> CONV

    CONV(["@master synthesis\nBoth tracks complete?\nConflicts resolved?"])

    CONV -->|"Track issues"| MASTER
    CONV -->|"✓ Both tracks ready"| SHARED

    subgraph SHARED ["🔒 Shared Release Gate — Sequential"]
        direction TB
        S1["@privacy-reviewer\nMandatory pre-publish scan\nSecrets · PII · private paths"]
        S2["@devils-advocate\nWhat are we missing?\nWhat could still go wrong?"]
        S1 --> S2
    end

    SHARED --> HGATE{"👤 Final human approval\nbefore public release"}

    HGATE -->|"Concerns raised"| MASTER
    HGATE -->|"✓ Ship it"| POST

    subgraph POST ["🚀 Parallel — Post-launch"]
        direction LR
        P1["@delivery-orchestrator\nDeploys and announces\nvia all channels"]
        P2["@changelog-writer\nVersioned changelog entry"]
        P3["@ab-tester\nDesigns post-launch\nexperiment for headlines/CTAs"]
    end

    POST --> DM

    DM["@delivery-monitor\nMonitors delivery\nFlags any errors"]

    DM --> WU

    WU["@workspace-updater\nAll docs, CLAUDE.md,\nREADME updated"]

    WU --> DONE(["✓ Launched publicly"])

    MASTER -. "orchestrates both tracks and all shared stages" .-> DONE
```

**Key points:**
- Both tracks start **simultaneously** — `@master` dispatches them at the same moment
- Neither track knows about the other — `@master` is the only entity holding both
- `@master` **converges** both tracks before the shared gate — it waits for the slower track rather than letting one proceed alone
- `@devils-advocate` runs **after** privacy review — it challenges the entire plan at the last responsible moment
- The human final approval gate is the last checkpoint before any irreversible public action
- `@delivery-orchestrator`, `@changelog-writer`, and `@ab-tester` run **in parallel** post-approval — none depend on each other

---

## Workflow 4 — Idea To Execution Planning

**Example trigger:** *"We have an idea for a backlog system and an execution-planning specialist. How should we shape it?"*

**Patterns demonstrated:** idea shaping, adversarial review, coordinated planning, optional backlog persistence, mandatory synthesis by `@master`.

```mermaid
flowchart TD
    USER(["👤 New idea or concept"])
    USER --> MASTER

    MASTER["@master\nReceives the idea\nDefines planning goal\nAnnounces the agent plan"]

    MASTER --> IDEA

    IDEA["@idea-executor\nClarifies the concept\nDrafts execution path\nCreates flow graph\nWrites step-by-step guidance"]

    IDEA --> STAGE1

    subgraph STAGE1 ["⚡ Parallel — Validation Stage"]
        direction LR
        DEVIL["@devils-advocate\nChallenges assumptions\nFinds weak points"]
        JUDGE["@judge\nEvaluates overall quality\nand feasibility"]
        ARCH["@architect\nChecks structure,\nboundaries, and system fit"]
    end

    STAGE1 --> SYNTH

    SYNTH["@master synthesis\nCombines planning + validation\nResolves conflicts\nDecides next step"]

    SYNTH --> DECISION{"Implement now\nor save for later?"}

    DECISION -->|"Implement now"| PLAN_DONE
    DECISION -->|"Save for later"| BACKLOG

    BACKLOG["@backlog-updater\nCreates or updates\nBACKLOG.md entry\nwith implementation context"]

    BACKLOG --> PLAN_DONE

    PLAN_DONE["@master returns:\nsummary\nagents used\nexecution report\nrisks\nnext step"]

    PLAN_DONE --> WU["@workspace-updater\nreviews core docs\nas final step"]
    WU --> DONE(["✓ Planning cycle complete"])
```

**Key points:**
- `@idea-executor` is the primary planning specialist, not the top-level coordinator
- `@master` still owns the thread, announces the selected agents, and synthesizes the result
- `@devils-advocate`, `@judge`, and `@architect` are strong default validators for non-trivial ideas
- If the user wants to defer execution, `@backlog-updater` persists the idea in `BACKLOG.md`
- Even planning-only work still ends with `@workspace-updater` reviewing the core docs

---

## Reading These Diagrams

| Symbol | Meaning |
|---|---|
| `⚡ Parallel — Stage N` subgraph | Agents in this box run at the same time |
| Arrow `A → B` | B waits for A to complete |
| Diamond `{ }` labelled "Master synthesis" | `@master` collects reports, resolves conflicts, decides next step |
| Diamond `{ }` labelled "👤 Human approval" | Execution pauses — a human must decide before work continues |
| Dashed arrow `-.->` | `@master`'s continuous orchestration role across all stages |
| `(opus)` in node label | Agent uses the `claude-opus` model for higher-quality output |
| Loop arrow back | Gate failed — routes back to the appropriate fix stage |
