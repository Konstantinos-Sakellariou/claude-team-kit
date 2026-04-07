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
        self.assertIn("Always include:", create_adr)
        self.assertIn("Optional sections:", create_adr)


if __name__ == "__main__":
    unittest.main()
