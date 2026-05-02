import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def read(path: str) -> str:
    return (ROOT / path).read_text()


class PromptContractTests(unittest.TestCase):
    def test_master_defines_lightweight_and_full_reporting(self) -> None:
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")

        self.assertIn("## Reporting Levels", master)
        self.assertIn("### 1. Lightweight Report", master)
        self.assertIn("### 2. Full Execution Report", master)
        self.assertIn("## Team Activation", master)
        self.assertIn("No delegation was needed because", master)
        self.assertIn("For all tasks, `@master` should at least report:", readme)
        self.assertIn("lightweight visible report even when no delegation was needed", claude)
        self.assertIn("lightweight visible report even when no delegation was needed", agents)

    def test_master_defines_bootstrap_flow(self) -> None:
        master = read(".claude/agents/master.md")

        self.assertIn("## New Repo Bootstrap", master)
        self.assertIn("Do not trigger bootstrap when:", master)
        self.assertIn("Treat bootstrap as needed when", master)
        self.assertIn("## Repo Customization Mode", master)
        self.assertIn("Listen → Summarize → Deepen", master)
        self.assertIn("### Guided Initialization Mode", master)
        self.assertIn("ask in small rounds, not one giant questionnaire", master)
        self.assertIn("offer likely categories or candidate answers", master)
        self.assertIn("### Pack-Aware Guidance", master)
        self.assertIn("Bootstrap question areas:", master)
        self.assertIn("make a reasonable temporary assumption and label it clearly", master)
        self.assertIn("Before I proceed: this repo still looks under-configured", master)

    def test_bootstrap_and_customization_docs_are_aligned(self) -> None:
        master = read(".claude/agents/master.md")
        bootstrap = read("docs/BOOTSTRAP.md")
        customization = read("docs/PROJECT_CUSTOMIZATION.md")
        readme = read("README.md")
        architecture = read("docs/ARCHITECTURE.md")

        self.assertIn("/customize-repo", readme)
        self.assertIn("Bootstrap Versus Customization", bootstrap)
        self.assertIn("Listen → Summarize → Deepen", bootstrap)
        self.assertIn("core kit layer", customization)
        self.assertIn("repo-specific overlay", customization)
        self.assertIn("/customize-repo", customization)
        self.assertIn("repo-specific overlay", architecture)
        self.assertIn("## Repo Customization Mode", master)

    def test_private_local_context_rules_are_aligned(self) -> None:
        master = read(".claude/agents/master.md")
        updater = read(".claude/agents/workspace-updater.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        local_context = read("docs/LOCAL_CONTEXT.md")
        gitignore = read(".gitignore")

        self.assertIn("## Private Local Context", master)
        self.assertIn(".claude/local-context/", master)
        self.assertIn("never copy private local-context details into tracked files automatically", master)
        self.assertIn("## Special Case: Private Local Context Boundary", updater)
        self.assertIn("## Private Local Context", readme)
        self.assertIn("private local context layer", claude)
        self.assertIn("private local context layer", agents)
        self.assertIn(".claude/local-context/", local_context)
        self.assertIn(".claude/local-context/", gitignore)

    def test_durable_memory_architecture_is_tracked_and_visible(self) -> None:
        memory_doc = read("docs/DURABLE_MEMORY.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        architecture = read("docs/ARCHITECTURE.md")
        local_context = read("docs/LOCAL_CONTEXT.md")
        customization = read("docs/PROJECT_CUSTOMIZATION.md")

        self.assertIn("# Durable Memory", memory_doc)
        self.assertIn("## Memory Layers", memory_doc)
        self.assertIn("## Retrieval Model", memory_doc)
        self.assertIn("## Tracked Versus Local", memory_doc)
        self.assertIn("## How We Actually Achieve Durability", memory_doc)
        self.assertIn("## Memory Flow", memory_doc)
        self.assertIn("```mermaid", memory_doc)
        self.assertIn("## Example Use", memory_doc)
        self.assertIn("docs/DURABLE_MEMORY.md", readme)
        self.assertIn("docs/DURABLE_MEMORY.md", claude)
        self.assertIn("docs/DURABLE_MEMORY.md", agents)
        self.assertIn("docs/DURABLE_MEMORY.md", architecture)
        self.assertIn("docs/DURABLE_MEMORY.md", local_context)
        self.assertIn("memory split", customization)

    def test_artifacts_companion_layer_is_tracked_and_visible(self) -> None:
        artifacts = read("docs/ARTIFACTS.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        customization = read("docs/PROJECT_CUSTOMIZATION.md")

        self.assertIn("# Artifacts Companion Layer", artifacts)
        self.assertIn("## Core Position", artifacts)
        self.assertIn("## Best First Use Cases", artifacts)
        self.assertIn("## Relationship To The App Surface", artifacts)
        self.assertIn("## Public Vs Local Boundary", artifacts)
        self.assertIn("docs/ARTIFACTS.md", readme)
        self.assertIn("docs/ARTIFACTS.md", claude)
        self.assertIn("docs/ARTIFACTS.md", agents)
        self.assertIn("docs/ARTIFACTS.md", customization)

    def test_doc_drift_hook_is_tracked_and_registered(self) -> None:
        settings = read(".claude/settings.json")
        hook = read(".claude/hooks/warn-doc-drift.sh")
        readme = read("README.md")

        self.assertIn("warn-doc-drift.sh", settings)
        self.assertIn("DOC DRIFT CHECK", hook)
        self.assertIn("doc-drift warning", readme)

    def test_context_efficiency_guidance_is_aligned(self) -> None:
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        context = read("docs/CONTEXT_EFFICIENCY.md")
        rtk = read("docs/RTK_INTEGRATION.md")

        self.assertIn("## Context Efficiency And Scope Discipline", master)
        self.assertIn("read narrow first", master)
        self.assertIn("prefer local CLI tools over equivalent MCP tools", master)
        self.assertIn("## Model Routing Policy", master)
        self.assertIn("## Context Efficiency", readme)
        self.assertIn("explicit model-routing stance", readme)
        self.assertIn("docs/CONTEXT_EFFICIENCY.md", readme)
        self.assertIn("docs/RTK_INTEGRATION.md", readme)
        self.assertIn("docs/CONTEXT_EFFICIENCY.md", claude)
        self.assertIn("docs/RTK_INTEGRATION.md", claude)
        self.assertIn("docs/CONTEXT_EFFICIENCY.md", agents)
        self.assertIn("docs/RTK_INTEGRATION.md", agents)
        self.assertIn("## Read Narrow First", context)
        self.assertIn("## Triage Large Inputs First", context)
        self.assertIn("## Default Large-Input Workflow", context)
        self.assertIn("## MCP And Tool Hygiene", context)
        self.assertIn("## Model Routing", context)
        self.assertIn("## Optional RTK Usage", context)
        self.assertIn("rtk-ai/rtk", rtk)
        self.assertIn("## Why It Stays Optional", rtk)
        self.assertIn("## Installation", rtk)

    def test_noisy_task_routing_prefers_specialists(self) -> None:
        master = read(".claude/agents/master.md")
        context = read("docs/CONTEXT_EFFICIENCY.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")

        self.assertIn("Specialist-first routing for noisy tasks:", master)
        self.assertIn("log-heavy or traceback-heavy debugging", master)
        self.assertIn("structured data, analytics evidence", master)
        self.assertIn("## Specialist-First Routing For Noisy Tasks", context)
        self.assertIn("specialist-first", readme)
        self.assertIn("specialist-first routing", claude)
        self.assertIn("specialist-first routing", agents)

    def test_team_aware_reporting_is_visible(self) -> None:
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")

        self.assertIn("Primary Team:", master)
        self.assertIn("which team was primary, if a team was used", readme)
        self.assertIn("must identify the primary team, team lead, and activation reason", claude)
        self.assertIn("must identify the primary team, team lead, and activation reason", agents)

    def test_plan_visibility_prompting_is_explicit(self) -> None:
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")

        self.assertIn("do not treat approval to save a plan as approval to track it publicly", master)
        self.assertIn("approving the plan itself is separate from deciding whether it stays local or becomes part of tracked git history", master)
        self.assertIn("approving a plan is not the same as approving a tracked public plan", readme)
        self.assertIn("must ask explicitly which visibility the user wants", claude)
        self.assertIn("must ask explicitly which visibility the user wants", agents)

    def test_request_shaping_guidance_is_aligned(self) -> None:
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")

        self.assertIn("prefer clear step-by-step guidance over vague advice", master)
        self.assertIn("## How To Ask Well", readme)
        self.assertIn("exact file paths", claude)
        self.assertIn("exact file paths", agents)

    def test_readme_includes_badges_and_hero(self) -> None:
        readme = read("README.md")
        hero = read("docs/assets/claude-team-kit-hero.svg")

        self.assertIn("github/actions/workflow/status/Konstantinos-Sakellariou/claude-team-kit/validate.yml", readme)
        self.assertIn("claude-team-kit hero", readme)
        self.assertIn("<svg", hero)
        self.assertIn("Operational Layers", hero)

    def test_backlog_templates_share_the_extended_schema(self) -> None:
        private_template = read("BACKLOG.example.md")
        public_template = read("docs/BACKLOG.example.md")

        for content in (private_template, public_template):
            self.assertIn("Assigned", content)
            self.assertIn("Artifact / Plan", content)
            self.assertIn("| ID | Idea | Description |", content)
            self.assertIn("VISION.example.md", content)
            self.assertIn("ROADMAP.example.md", content)

    def test_roadmap_is_tracked_and_linked(self) -> None:
        roadmap = read("docs/ROADMAP.example.md")
        vision = read("docs/VISION.example.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        architecture = read("docs/ARCHITECTURE.md")
        master = read(".claude/agents/master.md")

        self.assertIn("# Roadmap Template", roadmap)
        self.assertIn("## Phased Roadmap", roadmap)
        self.assertIn("## Timeline View", roadmap)
        self.assertIn("# Vision Template", vision)
        self.assertIn("## Suggested Structure", vision)
        self.assertIn("docs/ROADMAP.example.md", readme)
        self.assertIn("docs/ROADMAP.example.md", claude)
        self.assertIn("docs/ROADMAP.example.md", agents)
        self.assertIn("docs/ROADMAP.example.md", architecture)
        self.assertIn("docs/ROADMAP.example.md", master)

    def test_adr_guidance_is_aligned_across_docs_prompt_and_skill(self) -> None:
        adr_readme = read("docs/adr/README.md")
        tech_writer = read(".claude/agents/tech-writer.md")

        self.assertIn("docs/adr/001-decision-name.md", adr_readme)
        self.assertIn("docs/adr/001-decision-name.md", tech_writer)

        for required in [
            "Date",
            "Status",
            "Deciders",
            "Context",
            "Decision",
            "Rationale",
            "Alternatives Considered",
            "Consequences",
        ]:
            self.assertIn(required, adr_readme)
            self.assertIn(required, tech_writer)

        self.assertIn("Optional ADR sections:", adr_readme)
        self.assertIn("Include when useful:", tech_writer)

    def test_engineering_team_manifest_is_starter_scoped(self) -> None:
        team = read(".claude/teams/engineering-team.md")

        self.assertIn("Engineering Team", team)
        self.assertIn("@senior-developer", team)
        self.assertIn("@architect", team)
        self.assertIn("@qa-engineer", team)
        self.assertIn("@security-auditor", team)

    def test_product_team_manifest_is_starter_scoped(self) -> None:
        team = read(".claude/teams/product-team.md")

        self.assertIn("Product Team", team)
        self.assertIn("@product-owner", team)
        self.assertIn("@product-designer", team)

    def test_starter_agents_exist(self) -> None:
        starter_agents = [
            "master",
            "workspace-updater",
            "senior-developer",
            "architect",
            "qa-engineer",
            "security-auditor",
            "debugger",
            "researcher",
            "product-owner",
            "product-designer",
            "business-analyst",
            "brand-designer",
            "tech-writer",
            "content-writer",
            "project-manager",
        ]
        for agent in starter_agents:
            path = f".claude/agents/{agent}.md"
            self.assertTrue((ROOT / path).exists(), f"Starter agent missing: {path}")

    def test_starter_commands_exist(self) -> None:
        starter_commands = [
            "bootstrap-repo",
            "customize-repo",
            "plan-idea",
            "save-backlog",
            "write-adr",
            "triage-input",
        ]
        for cmd in starter_commands:
            path = f".claude/commands/{cmd}.md"
            self.assertTrue((ROOT / path).exists(), f"Starter command missing: {path}")

    def test_starter_rules_exist(self) -> None:
        starter_rules = [
            "code-quality",
            "documentation-governance",
            "context-efficiency",
            "security",
            "git-workflow",
        ]
        for rule in starter_rules:
            path = f".claude/rules/{rule}.md"
            self.assertTrue((ROOT / path).exists(), f"Starter rule missing: {path}")

    def test_workspace_updater_covers_core_docs(self) -> None:
        updater = read(".claude/agents/workspace-updater.md")
        master = read(".claude/agents/master.md")

        self.assertIn("CLAUDE.md, AGENTS.md, and README.md", updater)
        self.assertIn("## Special Case: New Repo Bootstrap", updater)
        self.assertIn("final doc-impact gate", master)


if __name__ == "__main__":
    unittest.main()
