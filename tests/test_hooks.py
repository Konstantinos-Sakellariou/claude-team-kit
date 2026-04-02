import json
import os
import subprocess
import tempfile
import time
import unittest
from pathlib import Path
from typing import Dict, Optional


ROOT = Path(__file__).resolve().parents[1]
HOOKS_DIR = ROOT / ".claude" / "hooks"


def run_hook(name: str, payload: dict, env: Optional[Dict[str, str]] = None) -> subprocess.CompletedProcess:
    hook_path = HOOKS_DIR / name
    merged_env = os.environ.copy()
    if env:
        merged_env.update(env)
    return subprocess.run(
        [str(hook_path)],
        input=json.dumps(payload),
        text=True,
        capture_output=True,
        env=merged_env,
        check=False,
    )


class ProtectFilesHookTests(unittest.TestCase):
    def test_blocks_protected_env_file(self) -> None:
        result = run_hook(
            "protect-files.sh",
            {"tool_input": {"file_path": ".env"}},
        )

        self.assertEqual(result.returncode, 2)
        self.assertIn("BLOCKED", result.stderr)

    def test_allows_regular_file(self) -> None:
        result = run_hook(
            "protect-files.sh",
            {"tool_input": {"file_path": "src/app.ts"}},
        )

        self.assertEqual(result.returncode, 0)


class BlockSecretsHookTests(unittest.TestCase):
    def test_blocks_hardcoded_github_token(self) -> None:
        result = run_hook(
            "block-secrets.sh",
            {
                "tool_input": {
                    "file_path": "src/config.ts",
                    "content": 'const token = "ghp_abcdefghijklmnopqrstuvwxyz1234567890";',
                }
            },
        )

        self.assertEqual(result.returncode, 2)
        self.assertIn("SECRET DETECTED", result.stderr)

    def test_skips_example_files(self) -> None:
        result = run_hook(
            "block-secrets.sh",
            {
                "tool_input": {
                    "file_path": "settings.local.json.example",
                    "content": 'const token = "ghp_abcdefghijklmnopqrstuvwxyz1234567890";',
                }
            },
        )

        self.assertEqual(result.returncode, 0)


class ValidateSqlQueryHookTests(unittest.TestCase):
    def test_blocks_destructive_query(self) -> None:
        result = run_hook(
            "validate-sql-query.sh",
            {"tool_input": {"command": "psql -c 'DROP TABLE users'"}},
        )

        self.assertEqual(result.returncode, 2)
        self.assertIn("SQL SAFETY CHECK", result.stderr)

    def test_allows_safe_command(self) -> None:
        result = run_hook(
            "validate-sql-query.sh",
            {"tool_input": {"command": "npm run lint"}},
        )

        self.assertEqual(result.returncode, 0)


class AutoFormatHookTests(unittest.TestCase):
    def test_formats_json_files(self) -> None:
        with tempfile.TemporaryDirectory() as tmpdir:
            path = Path(tmpdir) / "sample.json"
            path.write_text('{"b":2,"a":1}')

            result = run_hook(
                "auto-format.sh",
                {"tool_input": {"file_path": str(path)}},
            )

            self.assertEqual(result.returncode, 0)
            self.assertEqual(path.read_text(), '{\n  "b": 2,\n  "a": 1\n}\n')

    def test_ignores_missing_file(self) -> None:
        result = run_hook(
            "auto-format.sh",
            {"tool_input": {"file_path": "/tmp/does-not-exist.json"}},
        )

        self.assertEqual(result.returncode, 0)


class NotifyOnCompleteHookTests(unittest.TestCase):
    def test_skips_short_sessions(self) -> None:
        result = run_hook(
            "notify-on-complete.sh",
            {},
            env={"CLAUDE_SESSION_START": str(int(time.time()))},
        )

        self.assertEqual(result.returncode, 0)
        self.assertEqual(result.stdout, "")


if __name__ == "__main__":
    unittest.main()
