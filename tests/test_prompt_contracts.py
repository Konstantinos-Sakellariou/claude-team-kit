import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def read(path: str) -> str:
    return (ROOT / path).read_text()


class PromptContractTests(unittest.TestCase):
    def test_master_defines_backlog_mode_and_linked_plan_flow(self) -> None:
        master = read(".claude/agents/master.md")

        self.assertIn("Backlog mode rules:", master)
        self.assertIn("Private backlog", master)
        self.assertIn("Public backlog", master)
        self.assertIn("backlog + linked plan", master)
        self.assertIn("Before I save this backlog item:", master)
        self.assertIn("Approve saving both?", master)

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

    def test_command_layer_is_tracked_and_visible(self) -> None:
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        architecture = read("docs/ARCHITECTURE.md")
        system_reference = read("docs/SYSTEM_REFERENCE.md")

        for path in [
            ".claude/commands/bootstrap-repo.md",
            ".claude/commands/save-backlog.md",
            ".claude/commands/plan-idea.md",
            ".claude/commands/write-adr.md",
            ".claude/commands/release-check.md",
            ".claude/commands/sync-docs.md",
            ".claude/commands/triage-input.md",
            ".claude/commands/context-audit.md",
        ]:
            self.assertTrue((ROOT / path).exists(), path)

        self.assertIn("## Command Layer", master)
        self.assertIn("/bootstrap-repo", master)
        self.assertIn("Workflow Commands", readme)
        self.assertIn("Inspect command layer", claude)
        self.assertIn("Inspect command layer", agents)
        self.assertIn(".claude/commands/", architecture)
        self.assertIn("Current command set:", system_reference)

    def test_master_defines_bootstrap_flow(self) -> None:
        master = read(".claude/agents/master.md")

        self.assertIn("## New Repo Bootstrap", master)
        self.assertIn("Do not trigger bootstrap when:", master)
        self.assertIn("Treat bootstrap as needed when", master)
        self.assertIn("### Guided Initialization Mode", master)
        self.assertIn("ask in small rounds, not one giant questionnaire", master)
        self.assertIn("offer likely categories or candidate answers", master)
        self.assertIn("Bootstrap question areas:", master)
        self.assertIn("make a reasonable temporary assumption and label it clearly", master)
        self.assertIn("Before I proceed: this repo still looks under-configured", master)

    def test_workspace_updater_understands_bootstrap_follow_up(self) -> None:
        updater = read(".claude/agents/workspace-updater.md")

        self.assertIn("## Special Case: New Repo Bootstrap", updater)
        self.assertIn("bootstrap flow for a repo outside `claude-team-kit`", updater)
        self.assertIn("call out any still-temporary assumptions clearly", updater)
        self.assertIn("If the master brief says guided initialization was used:", updater)

    def test_private_local_context_rules_are_aligned(self) -> None:
        master = read(".claude/agents/master.md")
        guard = read(".claude/agents/github-safety-guard.md")
        updater = read(".claude/agents/workspace-updater.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        local_context = read("docs/LOCAL_CONTEXT.md")
        gitignore = read(".gitignore")

        self.assertIn("## Private Local Context", master)
        self.assertIn(".claude/local-context/", master)
        self.assertIn("never copy private local-context details into tracked files automatically", master)
        self.assertIn(".claude/local-context/", guard)
        self.assertIn("## Special Case: Private Local Context Boundary", updater)
        self.assertIn("## Private Local Context", readme)
        self.assertIn("private local context layer", claude)
        self.assertIn("private local context layer", agents)
        self.assertIn(".claude/local-context/", local_context)
        self.assertIn(".claude/local-context/", gitignore)

    def test_context_efficiency_guidance_is_aligned(self) -> None:
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        context = read("docs/CONTEXT_EFFICIENCY.md")

        self.assertIn("## Context Efficiency And Scope Discipline", master)
        self.assertIn("read narrow first", master)
        self.assertIn("prefer local CLI tools over equivalent MCP tools", master)
        self.assertIn("## Context Efficiency", readme)
        self.assertIn("docs/CONTEXT_EFFICIENCY.md", readme)
        self.assertIn("docs/CONTEXT_EFFICIENCY.md", claude)
        self.assertIn("docs/CONTEXT_EFFICIENCY.md", agents)
        self.assertIn("## Read Narrow First", context)
        self.assertIn("## Triage Large Inputs First", context)
        self.assertIn("## MCP And Tool Hygiene", context)

    def test_governance_rules_are_tracked_and_linked(self) -> None:
        documentation = read(".claude/rules/documentation-governance.md")
        cleanup_rule = read(".claude/rules/repo-cleanup.md")
        artifact = read(".claude/rules/artifact-governance.md")
        context_rule = read(".claude/rules/context-efficiency.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        architecture = read("docs/ARCHITECTURE.md")
        docs_governance = read("docs/DOCUMENTATION_GOVERNANCE.md")
        system_reference = read("docs/SYSTEM_REFERENCE.md")

        self.assertIn("Keep `README.md`, `CLAUDE.md`, and `AGENTS.md` aligned", documentation)
        self.assertIn("After this kit is copied into a real repo", cleanup_rule)
        self.assertIn("Use `BACKLOG.md` for private local deferred work", artifact)
        self.assertIn("Read narrow first", context_rule)
        self.assertIn("docs/VISION.example.md", readme)
        self.assertIn("docs/VISION.example.md", claude)
        self.assertIn("docs/VISION.example.md", agents)
        self.assertIn("docs/ROADMAP.example.md", readme)
        self.assertIn("docs/ROADMAP.example.md", claude)
        self.assertIn("docs/ROADMAP.example.md", agents)
        self.assertIn("docs/SELF_UPGRADE.md", readme)
        self.assertIn("docs/SELF_UPGRADE.md", claude)
        self.assertIn("docs/SELF_UPGRADE.md", agents)
        self.assertIn("docs/STARTER_PACKS.md", readme)
        self.assertIn("docs/STARTER_PACKS.md", claude)
        self.assertIn("docs/STARTER_PACKS.md", agents)
        self.assertIn("hot path lean", docs_governance)
        self.assertIn("full feature and connection map", system_reference)
        self.assertIn("@.claude/rules/documentation-governance.md", claude)
        self.assertIn("@.claude/rules/documentation-governance.md", agents)
        self.assertIn("@.claude/rules/repo-cleanup.md", claude)
        self.assertIn("@.claude/rules/repo-cleanup.md", agents)
        self.assertIn("@.claude/rules/artifact-governance.md", claude)
        self.assertIn("@.claude/rules/artifact-governance.md", agents)
        self.assertIn("@.claude/rules/context-efficiency.md", claude)
        self.assertIn("@.claude/rules/context-efficiency.md", agents)
        self.assertIn("documentation alignment", architecture)
        self.assertIn("artifact placement", architecture)

    def test_self_upgrade_guide_is_visible_and_actionable(self) -> None:
        guide = read("docs/SELF_UPGRADE.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        architecture = read("docs/ARCHITECTURE.md")
        system_reference = read("docs/SYSTEM_REFERENCE.md")
        docs_governance = read("docs/DOCUMENTATION_GOVERNANCE.md")

        self.assertIn("## Surface Selection", guide)
        self.assertIn("## Public vs Local Boundary", guide)
        self.assertIn("## Validation Standard", guide)
        self.assertIn("docs/SELF_UPGRADE.md", readme)
        self.assertIn("docs/SELF_UPGRADE.md", claude)
        self.assertIn("docs/SELF_UPGRADE.md", agents)
        self.assertIn("docs/SELF_UPGRADE.md", architecture)
        self.assertIn("docs/SELF_UPGRADE.md", system_reference)
        self.assertIn("docs/SELF_UPGRADE.md", docs_governance)

    def test_starter_packs_are_tracked_and_visible(self) -> None:
        packs = read("docs/STARTER_PACKS.md")
        saas = read("docs/starter-packs/saas-app.md")
        api = read("docs/starter-packs/api-service.md")
        ai_ml = read("docs/starter-packs/ai-ml-product.md")
        studio = read("docs/starter-packs/startup-studio.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        customization = read("docs/PROJECT_CUSTOMIZATION.md")
        system_reference = read("docs/SYSTEM_REFERENCE.md")

        self.assertIn("## Available Packs", packs)
        self.assertIn("SaaS App", packs)
        self.assertIn("API Service", packs)
        self.assertIn("AI/ML Product", packs)
        self.assertIn("Startup Studio", packs)
        self.assertIn("## Team Emphasis", saas)
        self.assertIn("## Team Emphasis", api)
        self.assertIn("## Team Emphasis", ai_ml)
        self.assertIn("## Team Emphasis", studio)
        self.assertIn("docs/STARTER_PACKS.md", readme)
        self.assertIn("docs/STARTER_PACKS.md", claude)
        self.assertIn("docs/STARTER_PACKS.md", agents)
        self.assertIn("docs/STARTER_PACKS.md", customization)
        self.assertIn("docs/STARTER_PACKS.md", system_reference)

    def test_doc_drift_hook_is_tracked_and_registered(self) -> None:
        settings = read(".claude/settings.json")
        hook = read(".claude/hooks/warn-doc-drift.sh")
        readme = read("README.md")
        architecture = read("docs/ARCHITECTURE.md")

        self.assertIn("warn-doc-drift.sh", settings)
        self.assertIn("DOC DRIFT CHECK", hook)
        self.assertIn("doc-drift warning", readme)
        self.assertIn("drift-warning shell hooks", architecture)

    def test_new_skills_are_tracked_and_visible(self) -> None:
        context_audit = read(".claude/skills/context-audit/SKILL.md")
        triage_input = read(".claude/skills/triage-input/SKILL.md")
        repo_cleanup = read(".claude/skills/repo-cleanup/SKILL.md")
        readme = read("README.md")
        context = read("docs/CONTEXT_EFFICIENCY.md")

        self.assertIn("Audit the repo's working context", context_audit)
        self.assertIn("Triage this input first", triage_input)
        self.assertIn("Audit a copied repo for generic kit leftovers", repo_cleanup)
        self.assertIn("20 reusable skills", readme)
        self.assertIn("context-audit", readme)
        self.assertIn("triage-input", readme)
        self.assertIn("repo-cleanup", readme)
        self.assertIn("`triage-input` skill", context)
        self.assertIn("`context-audit` skill", context)

    def test_git_github_team_is_defined_and_visible(self) -> None:
        team = read(".claude/teams/git-github-team.md")
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        teams_doc = read("docs/TEAMS.md")

        self.assertIn("# Git / GitHub Team", team)
        self.assertIn("@github-safety-guard", team)
        self.assertIn("Git / GitHub Team", master)
        self.assertIn("git, GitHub, PR, or repository-safety work", master)
        self.assertIn("Git / GitHub Team", readme)
        self.assertIn("Git / GitHub Team", claude)
        self.assertIn("Git / GitHub Team", agents)
        self.assertIn("Git / GitHub Team", teams_doc)
        self.assertIn("lightweight sync-readiness check", master)
        self.assertIn("quick sync check or pull", readme)
        self.assertIn("quick sync check or pull", claude)
        self.assertIn("quick sync check or pull", agents)

    def test_team_aware_reporting_is_visible(self) -> None:
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")

        self.assertIn("Primary Team:", master)
        self.assertIn("which team was primary, if a team was used", readme)
        self.assertIn("must identify the primary team, team lead, and activation reason", claude)
        self.assertIn("must identify the primary team, team lead, and activation reason", agents)

    def test_supabase_team_is_defined_and_visible(self) -> None:
        team = read(".claude/teams/supabase-team.md")
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        teams_doc = read("docs/TEAMS.md")
        workflows = read("docs/AGENT_WORKFLOWS.md")
        customization = read("docs/PROJECT_CUSTOMIZATION.md")
        reference = read("docs/SUPABASE_REFERENCE.md")

        self.assertIn("# Supabase Team", team)
        self.assertIn("@security-auditor", team)
        self.assertIn("Supabase Team", master)
        self.assertIn("Supabase auth, schema, migrations, RLS, storage, or edge-function work", master)
        self.assertIn("Supabase Team", readme)
        self.assertIn("Supabase Team", claude)
        self.assertIn("Supabase Team", agents)
        self.assertIn("Supabase Team", teams_doc)
        self.assertIn("Workflow 10 — Supabase Team Flow", workflows)
        self.assertIn("If The Project Uses Supabase", customization)
        self.assertIn("What Supabase Is", reference)

    def test_github_quality_gate_agents_and_rule_are_visible(self) -> None:
        code_reviewer = read(".claude/agents/code-reviewer.md")
        pr_operator = read(".claude/agents/pr-operator.md")
        prod_ready = read(".claude/agents/production-readiness-reviewer.md")
        quality_gate = read(".claude/rules/github-quality-gate.md")
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        teams_doc = read("docs/TEAMS.md")
        workflows = read("docs/AGENT_WORKFLOWS.md")

        self.assertIn("Production-grade code reviewer", code_reviewer)
        self.assertIn("Pull-request readiness", pr_operator)
        self.assertIn("Final production-readiness gate", prod_ready)
        self.assertIn("Code should not be committed, pushed, or packaged for PR as \"ready\"", quality_gate)

    def test_release_governance_pack_is_visible(self) -> None:
        release_rule = read(".claude/rules/release-governance.md")
        release_doc = read("docs/RELEASE_GOVERNANCE.md")
        release_command = read(".claude/commands/release-check.md")
        git_team = read(".claude/teams/git-github-team.md")
        teams_doc = read("docs/TEAMS.md")
        master = read(".claude/agents/master.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")
        workflows = read("docs/AGENT_WORKFLOWS.md")
        system_reference = read("docs/SYSTEM_REFERENCE.md")

        self.assertIn("Default Release Governance Sequence", release_rule)
        self.assertIn("READY WITH NOTED RISK", release_rule)
        self.assertIn("This kit also includes a stricter release-governance layer", readme)
        self.assertIn("@.claude/rules/release-governance.md", claude)
        self.assertIn("@.claude/rules/release-governance.md", agents)
        self.assertIn("release-governance report", release_command)
        self.assertIn("release-governance check", git_team)
        self.assertIn("For **any release-heavy path** prefer an explicit release-governance sequence", master)
        self.assertIn("READY WITH NOTED RISK", master)
        self.assertIn("release-heavy paths should end in a visible `READY`, `READY WITH NOTED RISK`, or `NOT READY` summary", workflows)
        self.assertIn("release-governance.md", system_reference)
        self.assertIn("Git / GitHub blocking policy:", master)
        self.assertIn("GitHub Quality Gate", readme)
        self.assertIn("@.claude/rules/github-quality-gate.md", claude)
        self.assertIn("@.claude/rules/github-quality-gate.md", agents)
        self.assertIn("@code-reviewer", teams_doc)
        self.assertIn("@code-reviewer", workflows)

    def test_request_shaping_guidance_is_aligned(self) -> None:
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")

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

    def test_backlog_updater_schema_includes_assignment_and_artifact(self) -> None:
        backlog_updater = read(".claude/agents/backlog-updater.md")

        self.assertIn("Assigned", backlog_updater)
        self.assertIn("Artifact / Plan", backlog_updater)
        self.assertIn("docs/BACKLOG.md", backlog_updater)
        self.assertIn("Do not change the `Status` of an existing backlog item unless the user explicitly asked", backlog_updater)

    def test_idea_executor_distinguishes_backlog_only_vs_backlog_plus_plan(self) -> None:
        idea_executor = read(".claude/agents/idea-executor.md")

        self.assertIn("Backlog Only", idea_executor)
        self.assertIn("Backlog + Plan", idea_executor)
        self.assertIn("Proposed Backlog Target", idea_executor)
        self.assertIn("Proposed Plan Path", idea_executor)

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
        system_reference = read("docs/SYSTEM_REFERENCE.md")
        backlog_updater = read(".claude/agents/backlog-updater.md")
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
        self.assertIn("docs/ROADMAP.example.md", system_reference)
        self.assertIn("docs/ROADMAP.example.md", backlog_updater)
        self.assertIn("docs/ROADMAP.example.md", master)

    def test_bootstrap_docs_exist_and_are_aligned(self) -> None:
        bootstrap = read("docs/BOOTSTRAP.md")
        readme = read("README.md")
        claude = read("CLAUDE.md")
        agents = read("AGENTS.md")

        self.assertIn("When `claude-team-kit` is dropped into a repo other than itself", bootstrap)
        self.assertIn("private local context layer", bootstrap)
        self.assertIn("## Guided Initialization", bootstrap)
        self.assertIn("## Suggested Rounds", bootstrap)
        self.assertIn("## New Repo Bootstrap", readme)
        self.assertIn("guided initialization style", readme)
        self.assertIn("docs/BOOTSTRAP.md", readme)
        self.assertIn("Bootstrap should stay flexible:", claude)
        self.assertIn("use guided initialization when the repo is especially underdefined", claude)
        self.assertIn("Bootstrap should stay flexible:", agents)
        self.assertIn("use guided initialization when the repo is especially underdefined", agents)

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

    def test_optional_local_create_adr_skill_aligns_when_present(self) -> None:
        skill_path = ROOT / ".agents" / "skills" / "create-adr" / "SKILL.md"

        if not skill_path.exists():
            self.skipTest("Optional local create-adr skill is not present in this checkout")

        create_adr = skill_path.read_text()

        self.assertIn("docs/adr/[NNN]-[kebab-case-title].md", create_adr)
        self.assertIn("# ADR-[NNN]: [Decision Title]", create_adr)
        self.assertIn("Always include:", create_adr)
        self.assertIn("Optional sections:", create_adr)
        self.assertIn("Follow-Up Docs", create_adr)


if __name__ == "__main__":
    unittest.main()
