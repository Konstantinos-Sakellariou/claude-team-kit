import re
import subprocess
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class DoctorScriptTests(unittest.TestCase):
    def test_doctor_passes_with_expected_warnings(self) -> None:
        agent_count = len(list((ROOT / ".claude" / "agents").glob("*.md")))
        rule_count = len(list((ROOT / ".claude" / "rules").glob("*.md")))
        result = subprocess.run(
            [str(ROOT / "scripts" / "doctor.sh")],
            text=True,
            capture_output=True,
            check=False,
        )

        self.assertEqual(result.returncode, 0, msg=result.stdout + result.stderr)
        self.assertIn("PASS: .claude/settings.json sets master as the default agent", result.stdout)
        self.assertIn("PASS: master agent prompt defines a default execution report", result.stdout)
        self.assertIn("PASS: workspace-updater prompt covers all core documentation files", result.stdout)
        self.assertRegex(result.stdout, rf"INFO: agents={agent_count} skills=17 rules={rule_count} hooks=5")

    def test_readme_counts_match_repo(self) -> None:
        readme = (ROOT / "README.md").read_text()

        agent_count = len(list((ROOT / ".claude" / "agents").glob("*.md")))
        skill_count = len([p for p in (ROOT / ".claude" / "skills").iterdir() if p.is_dir()])
        rule_count = len(list((ROOT / ".claude" / "rules").glob("*.md")))
        hook_count = len(list((ROOT / ".claude" / "hooks").glob("*.sh")))

        self.assertIn(f"{agent_count} specialized agents", readme)
        self.assertIn(f"{skill_count} reusable skills", readme)
        self.assertIn(f"agents={agent_count} skills={skill_count} rules={rule_count} hooks={hook_count}", self._doctor_output())

    def _doctor_output(self) -> str:
        result = subprocess.run(
            [str(ROOT / "scripts" / "doctor.sh")],
            text=True,
            capture_output=True,
            check=False,
        )
        self.assertEqual(result.returncode, 0, msg=result.stdout + result.stderr)
        return result.stdout


if __name__ == "__main__":
    unittest.main()
