import re
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
README = ROOT / "README.md"


class ReadmeQualityTests(unittest.TestCase):
    def setUp(self) -> None:
        self.readme = README.read_text()

    def test_local_readme_links_resolve(self) -> None:
        targets = re.findall(r'!?\[[^\]]*\]\(([^)]+)\)', self.readme)
        missing = []

        for raw_target in targets:
            target = raw_target.strip()
            if (
                not target
                or target.startswith("#")
                or "://" in target
                or target.startswith("mailto:")
                or target.startswith("tel:")
            ):
                continue

            path_part = target.split("#", 1)[0]
            if path_part and not (ROOT / path_part).exists():
                missing.append(target)

        self.assertEqual(missing, [])

    def test_code_fences_are_balanced(self) -> None:
        self.assertEqual(self.readme.count("```") % 2, 0)

    def test_readme_mermaid_is_github_safe(self) -> None:
        blocks = re.findall(r'```mermaid\n(.*?)\n```', self.readme, flags=re.S)
        self.assertTrue(blocks, "README should keep one lightweight mental-model diagram")

        for block in blocks:
            stripped = block.strip()
            self.assertTrue(
                stripped.startswith(("flowchart ", "sequenceDiagram", "gantt")),
                stripped.splitlines()[0],
            )
            block.encode("ascii")
            self.assertNotIn("<br", block)
            self.assertNotIn("subgraph", block)

    def test_readme_stays_onboarding_first(self) -> None:
        headings = re.findall(r"^## .+$", self.readme, flags=re.M)
        first_headings = headings[:6]

        self.assertEqual(
            first_headings,
            [
                "## Who This Is For",
                "## What You Get",
                "## Quick Start",
                "## Core Mental Model",
                "## Common Workflows",
                "## Workflow Commands",
            ],
        )
        self.assertLessEqual(len(self.readme.splitlines()), 420)


if __name__ == "__main__":
    unittest.main()
