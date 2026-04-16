# Agent Workflows

All work flows through `@master`. Every example below starts and ends there.

`@master` receives the request, maps the full scope, announces the plan to the user before executing, dispatches agents (in parallel or sequentially depending on dependencies), synthesises their reports, resolves conflicts, and — once the user confirms — triggers `@workspace-updater` as the mandatory final step.

These workflows are also the reason the kit now defines reusable teams: when the same multi-agent shape appears repeatedly, `@master` can activate a team instead of reconstructing the orchestration pattern from scratch each time.

Eleven workflows are documented here, each demonstrating different collaboration patterns:

1. **Engineering Pipeline** — parallel spikes, sequential implementation, gated quality stages
2. **Content Publishing Pipeline** — research loop, human approval gate, parallel review, delivery feedback loop
3. **Full Project Launch** — dual parallel tracks (engineering + content) converging at a shared release gate
4. **Idea To Execution Planning** — idea shaping, strategic-fit review, adversarial validation, phased plan, optional backlog capture
5. **Decision To ADR** — durable-decision detection, validation, approval gate, ADR authorship, documentation alignment
6. **AI/ML Delivery Pipeline** — model framing, training, mandatory evaluation gate, operational rollout
7. **New Repo Bootstrap** — adaptive discovery, temporary assumptions, initial briefing alignment
8. **Private Local Context In Planning** — private-context lookup, safe planning support, tracked-doc boundary
9. **Git / GitHub Team Flow** — commit/push safety, PR readiness, and release-governance orchestration
10. **Supabase Team Flow** — schema/auth/RLS coordination with explicit security and rollout gates
11. **Data Team Flow** — ingestion, metrics, analysis, and trust gates for decision-ready data work

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

**Patterns demonstrated:** idea shaping, strategic-fit review, adversarial review, coordinated planning, backlog persistence, optional linked plan artifact, mandatory synthesis by `@master`.

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
        STRAT["@strategy-reviewer\nChecks vision fit,\nroadmap fit,\nand timing"]
        DEVIL["@devils-advocate\nChallenges assumptions\nFinds weak points"]
        JUDGE["@judge\nEvaluates overall quality\nand feasibility"]
        ARCH["@architect\nChecks structure,\nboundaries, and system fit"]
    end

    STAGE1 --> SYNTH

    SYNTH["@master synthesis\nCombines planning + validation\nResolves conflicts\nDecides next step"]

    SYNTH --> DECISION{"Implement now\nor save for later?"}

    DECISION -->|"Implement now"| PLAN_DONE
    DECISION -->|"Save for later"| APPROVAL

    APPROVAL{"👤 Save richer plan\nfor later?"}

    APPROVAL -->|"Backlog only"| BACKLOG
    APPROVAL -->|"Backlog + plan"| VISIBILITY

    VISIBILITY{"👤 Local or tracked\nplan visibility?"}

    VISIBILITY -->|"Local"| PLAN_LOCAL
    VISIBILITY -->|"Tracked"| PLAN_TRACKED

    BACKLOG["@backlog-updater\nCreates or updates\nthe chosen backlog entry\nwith implementation context"]

    PLAN_LOCAL["@backlog-updater + @tech-writer\nCreate or update linked\n`.claude/local-context/plans/<slug>.md`\nand backlog row"]
    PLAN_TRACKED["@backlog-updater + @tech-writer\nCreate or update linked\n`docs/plans/<slug>.md`\nand backlog row"]

    BACKLOG --> PLAN_DONE
    PLAN_LOCAL --> PLAN_DONE
    PLAN_TRACKED --> PLAN_DONE

    PLAN_DONE["@master returns:\nsummary\nagents used\nexecution report\nrisks\nnext step"]

    PLAN_DONE --> WU["@workspace-updater\nreviews core docs\nas final step"]
    WU --> DONE(["✓ Planning cycle complete"])
```

**Key points:**
- `@idea-executor` is the primary planning specialist, not the top-level coordinator
- `@master` still owns the thread, announces the selected agents, and synthesizes the result
- `@strategy-reviewer`, `@devils-advocate`, `@judge`, and `@architect` are strong default validators for non-trivial ideas
- If the user wants to defer execution, `@backlog-updater` persists the idea in the chosen backlog
- For substantial deferred work, the best default is often backlog entry plus linked plan, not backlog row alone
- Approving a richer plan is separate from approving tracked visibility; `@master` should ask explicitly when that choice is not already clear
- Even planning-only work still ends with `@workspace-updater` reviewing the core docs

---

## Workflow 5 — Decision To ADR

**Example trigger:** *"We should make `@master` propose ADRs automatically for durable decisions."*

**Patterns demonstrated:** default ADR detection, adversarial validation, human approval gate, delegated authorship, final doc alignment.

```mermaid
flowchart TD
    USER(["👤 Durable decision discussion"])
    USER --> MASTER

    MASTER["@master\nDetects that the outcome\nchanges a durable convention\nProposes ADR by default"]

    MASTER --> ARCH

    ARCH["@architect\nDefines the technical substance\nand boundaries of the decision"]

    ARCH --> STAGE1

    subgraph STAGE1 ["⚡ Parallel — Decision Validation"]
        direction LR
        DEVIL["@devils-advocate\nChallenges assumptions\nand trade-offs"]
        JUDGE["@judge\nEvaluates overall quality\nand long-term fitness"]
    end

    STAGE1 --> SYNTH

    SYNTH["@master synthesis\nCombines reasoning\nand recommends ADR path"]

    SYNTH --> APPROVAL{"👤 Approve saving\n`docs/adr/<nnn>-<slug>.md`?"}

    APPROVAL -->|"No"| CHAT_DONE["@master keeps it in chat\nor moves it to BACKLOG.md"]
    APPROVAL -->|"Yes"| WRITER

    WRITER["@tech-writer\nWrites the ADR using\narchitect + validation input"]

    WRITER --> WU["@workspace-updater\nAligns README.md,\nCLAUDE.md, and AGENTS.md"]

    CHAT_DONE --> DONE(["✓ Decision captured"])
    WU --> DONE
```

**Key points:**
- `@master` should propose this flow by default when the decision should outlive the current conversation
- `@architect` owns the substance, but `@tech-writer` owns final ADR authorship
- `@devils-advocate` and `@judge` validate the reasoning before the record is written
- Saving to `docs/adr/` is still gated by explicit user approval
- `@workspace-updater` closes the loop so the ADR does not drift away from the repo briefings

---

## Workflow 6 — AI/ML Delivery Pipeline

**Example trigger:** *"Evaluate and operationalize a churn model for deployment."*

**Patterns demonstrated:** domain-specialist routing, sequential model pipeline, mandatory evaluation gate, optional frontier-research advisory, operational rollout.

```mermaid
flowchart TD
    USER(["👤 AI/ML request"])
    USER --> MASTER

    MASTER["@master\nReceives request\nMaps AI/ML scope\nAnnounces plan"]

    MASTER --> DS

    DS["@data-scientist\nFrames the problem\nDefines baselines\nShapes features and metrics"]

    DS --> MLE

    MLE["@ml-engineer\nBuilds reproducible\ntraining pipeline\nand model artifacts"]

    MLE --> GATE1

    RS["@research-scientist\nOptional advisory on\nnovel methods or\nbenchmark claims"]
    RS -.-> MLE
    RS -.-> GATE1

    GATE1["@model-evaluator\nMandatory quality gate\nMetrics, fairness,\nrobustness, readiness"]

    GATE1 --> DECISION{"Approved for\nproduction-minded rollout?"}

    DECISION -->|"No"| MASTER
    DECISION -->|"Yes"| MLO

    MLO["@mlops-engineer\nDefines rollout,\nmonitoring, rollback,\nand lifecycle operations"]

    MLO --> WU["@workspace-updater\nReviews core docs\nas final step"]
    WU --> DONE(["✓ AI/ML cycle complete"])
```

**Key points:**
- `@data-scientist` starts the default AI/ML path with framing, baselines, and feature intent
- `@ml-engineer` turns that intent into reproducible training and artifact flow
- `@model-evaluator` is a hard gate, not a nice-to-have reviewer
- `@research-scientist` is advisory and only needs to run when novelty or literature fit matters
- `@mlops-engineer` should not lead before evaluation sign-off exists

---

## Workflow 7 — New Repo Bootstrap

**Example trigger:** *"We just copied this kit into a new startup repo. Help us set it up properly."*

**Patterns demonstrated:** adaptive discovery, guided initialization in small rounds, flexible questioning, temporary assumptions, initial doc alignment, final workspace sync.

```mermaid
flowchart TD
    USER(["👤 First serious request in a new repo"])
    USER --> MASTER

    MASTER["@master\nDetects repo is not claude-team-kit\nChecks whether docs still look generic\nExplains why bootstrap is recommended"]

    MASTER --> APPROVAL{"👤 Run bootstrap\nbefore major work?"}

    APPROVAL -->|"No"| CONTINUE["@master proceeds with task\nbut notes that repo context\nis still incomplete"]
    APPROVAL -->|"Yes"| QS

    QS["@master\nRuns guided initialization in small rounds\nPurpose first · then stack and commands\nthen constraints and preferences"]

    QS --> INPUT

    INPUT["@master synthesis\nCollects answers\nMakes clearly labeled\ntemporary assumptions where needed"]

    INPUT --> WRITER

    WRITER["@tech-writer\nDrafts stronger\nCLAUDE.md, AGENTS.md,\nand README.md context"]

    INPUT -. "optional support when useful" .-> ARCH
    ARCH["@architect\nHelps shape architecture\nand boundaries if the repo\nis technical or unclear"]

    WRITER --> WU["@workspace-updater\nVerifies bootstrap results\nand reports remaining assumptions"]
    CONTINUE --> WU
    WU --> DONE(["✓ Repo briefing strengthened"])
```

**Key points:**
- bootstrap should not run inside `claude-team-kit` itself
- bootstrap should not interrupt already-customized repos
- `@master` should ask only high-signal questions, not a giant questionnaire
- when the repo is still vague, `@master` should use guided initialization in small rounds instead of a single dump of questions
- if the user is unsure, `@master` should help with candidate answers or repo-informed guesses
- users can answer partially; `@master` may make temporary assumptions and label them clearly
- `@workspace-updater` closes the loop by checking that the core docs now reflect the repo better than before

---

## Workflow 8 — Private Local Context In Planning

**Example trigger:** *"Help me shape the roadmap and messaging for this startup, but keep the sensitive company notes private."*

**Patterns demonstrated:** private-context lookup, planning support without disclosure, tracked-doc boundary.

```mermaid
flowchart TD
    USER(["👤 Strategic or company-sensitive request"])
    USER --> MASTER

    MASTER["@master\nChecks whether\n.claude/local-context/\nexists and is relevant"]

    MASTER --> LC["@master reads only the\nrelevant local-context files\n(project-private / customers /\nconstraints)"]
    LC --> PLAN["@idea-executor or\nadvisory team shapes the work"]

    PLAN --> CHECK{"Would a tracked doc\nneed private details to stay accurate?"}

    CHECK -->|"No"| RESULT["@master returns plan\nusing private context locally"]
    CHECK -->|"Yes"| ASK["👤 Ask user whether the\nprivate detail may be promoted\ninto tracked docs"]

    ASK -->|"No"| RESULT
    ASK -->|"Yes"| WU["@workspace-updater\nmakes the minimum safe\ntracked-doc update"]

    RESULT --> DONE(["✓ Private context used safely"])
    WU --> DONE
```

**Key points:**
- `.claude/local-context/` is optional and local-only
- `@master` should read only the minimum relevant private file
- private context may guide planning without being copied into tracked docs
- when tracked docs would benefit from private context, the user must approve that promotion explicitly

---

## Workflow 9 — Git / GitHub Team Flow

**Example trigger:** *"Before I push and open a PR, run the full repo-safety and release-readiness check."*

**Patterns demonstrated:** reusable team activation, safety-first commit/push flow, PR prep support, optional release-risk gate.

```mermaid
flowchart TD
    USER(["👤 Commit / push / PR request"])
    USER --> MASTER

    MASTER["@master\nActivates Git / GitHub Team\nAnnounces lead, support,\nand approval gates"]

    MASTER --> SAFE["@github-safety-guard\nReviews changes for secrets,\nsensitive disclosures,\nand repo-safety risks"]
    SAFE --> PRIV["@privacy-reviewer\nChecks public/private\nboundary and disclosure risk"]

    PRIV --> DECIDE{"PR or release\nwork also involved?"}

    DECIDE -->|"PR"| PRPREP["@changelog-writer\nSummarizes changes\nfor PR / release notes"]
    DECIDE -->|"Release"| RISK["@risk-officer\nFinal release-risk\nreview and go/no-go"]
    DECIDE -->|"Commit or push only"| REPORT

    PRPREP --> REPORT
    RISK --> REPORT

    REPORT["@master synthesis\nSurfaces findings,\nteam used, and any\napproval gates"]

    REPORT --> USERGATE{"👤 Proceed with\ngit action?"}
    USERGATE -->|"No"| DONE(["✓ Review complete"])
    USERGATE -->|"Yes"| WU["@workspace-updater\nRuns if workflow or docs\nneed alignment"]
    WU --> DONE
```

**Key points:**
- `Git / GitHub Team` is the reusable coordination layer for commit, push, PR, and release-governance work
- `@github-safety-guard` remains the default lead for outgoing repo actions
- `@code-reviewer` acts as the code-quality and standards gate for code-affecting changes
- `@pr-operator` improves PR packaging and reviewer context when a PR is involved
- `@privacy-reviewer` stays explicit for disclosure-sensitive changes
- `@production-readiness-reviewer` is added when the path is merge-critical, migration-heavy, or release-heavy
- `@risk-officer` becomes the decisive gate only when the flow is truly release-heavy
- release-heavy paths should end in a visible `READY`, `READY WITH NOTED RISK`, or `NOT READY` summary
- before substantial work, `@master` should ask whether the branch needs a quick sync check when remote drift is plausible
- `@master` must surface the team, agents used, findings, and approval gate before any irreversible Git action

---

## Workflow 10 — Supabase Team Flow

**Example trigger:** *"Add Supabase auth with RLS-protected organizations and prepare the migration safely."*

**Patterns demonstrated:** reusable domain-team activation, schema plus auth coordination, mandatory security gate, optional production-readiness gate.

```mermaid
flowchart TD
    USER(["👤 Supabase request"])
    USER --> MASTER

    MASTER["@master\nActivates Supabase Team\nAnnounces lead, support,\nand required gates"]

    MASTER --> DESIGN["@architect\nShapes schema, auth,\nand RLS boundaries"]
    DESIGN --> BUILD["@senior-developer\nImplements migration,\npolicies, and integration code"]

    BUILD --> REVIEW

    subgraph REVIEW ["⚡ Parallel — Review and readiness"]
        direction LR
        SEC["@security-auditor\nReviews auth, RLS,\nstorage, and access risk"]
        QA["@qa-engineer\nCovers behavior,\nedge cases, and regressions"]
        CODE["@code-reviewer\nChecks quality,\nstandards, and maintainability"]
    end

    REVIEW --> GATE{"Migration-heavy or\nrelease-risk path?"}
    GATE -->|"Yes"| PROD["@production-readiness-reviewer\nChecks rollback,\nenv, rollout, and safety"]
    GATE -->|"No"| REPORT
    PROD --> REPORT

    REPORT["@master synthesis\nSurfaces team used,\nfindings, blockers,\nand next step"]
    REPORT --> WU["@workspace-updater\nRuns if briefing or workflow\ndocs need alignment"]
    WU --> DONE(["✓ Supabase work reviewed"])
```

**Key points:**
- `Supabase Team` is the reusable coordination layer for Supabase-backed product work
- `@security-auditor` is mandatory for auth, RLS, storage, and sensitive access changes
- `@code-reviewer` stays part of code-affecting Supabase work
- `@production-readiness-reviewer` is added when migrations, rollout, or environment risk are meaningful
- the shared kit stays generic while the actual project-specific Supabase layout belongs in the copied repo briefing

---

## Workflow 11 — Data Team Flow

**Example trigger:** *"Build a trustworthy warehouse mart for activation metrics, review the KPI definition, and tell me whether we can trust the current experiment readout."*

**Patterns demonstrated:** reusable data-domain team activation, pipeline plus semantic modeling coordination, analysis handoff, mandatory governance gate.

```mermaid
flowchart TD
    USER(["👤 Data request"])
    USER --> MASTER

    MASTER["@master\nActivates Data Team\nAnnounces lead, support,\nand trust gates"]

    MASTER --> PIPE["@data-engineer\nShapes ingestion,\npipeline assumptions,\nand source reliability"]
    PIPE --> MODEL["@analytics-engineer\nBuilds marts,\ngrain, and metrics logic"]
    MODEL --> ANALYZE["@data-analyst\nInterprets KPI,\ncohort, or trend signal"]

    ANALYZE --> EXP{"Experiment-specific\nquestion involved?"}
    EXP -->|"Yes"| EXPA["@experiment-analyst\nChecks lift,\nguardrails, and\ninterpretation quality"]
    EXP -->|"No"| GOV
    EXPA --> GOV

    GOV["@data-governance-reviewer\nChecks lineage,\nquality, access,\nand trust boundary"]
    GOV --> SEC{"Sensitive data or\npolicy risk involved?"}
    SEC -->|"Yes"| AUDIT["@security-auditor\nReviews access,\nprivacy, and exposure"]
    SEC -->|"No"| REPORT
    AUDIT --> REPORT

    REPORT["@master synthesis\nSurfaces team used,\nwhat is trustworthy now,\nand what still needs work"]
    REPORT --> WU["@workspace-updater\nRuns if briefing or workflow\ndocs need alignment"]
    WU --> DONE(["✓ Data work reviewed"])
```

**Key points:**
- `Data Team` is the reusable coordination layer for analytics, pipelines, and data-trust work
- `@data-engineer` and `@analytics-engineer` establish the technical and semantic foundation first
- `@data-analyst` and `@experiment-analyst` turn that foundation into decision-ready interpretation
- `@data-governance-reviewer` is the trust gate before decision-critical conclusions are treated as safe
- `@security-auditor` joins when sensitive data, access boundaries, or privacy risk matter

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
