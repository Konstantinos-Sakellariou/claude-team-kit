# Python Rules

## Style
- Python 3.10+ features are fine (match/case, union types with |)
- Type hints on ALL function signatures — no bare untyped functions
- Use dataclasses or Pydantic models for structured data, not plain dicts
- f-strings only — no .format() or % formatting
- Use pathlib.Path, not os.path
- Use `with` statements for all resource handling (files, connections, locks)

## Structure
- One class or one logical group of functions per file
- Keep `__init__.py` files minimal — import only what the module exports
- Group imports: stdlib → third-party → local, each group alphabetical
- No wildcard imports: never `from module import *`

## Type Hints
- Use `list[str]` not `List[str]` (Python 3.9+)
- Use `dict[str, Any]` not `Dict[str, Any]`
- Use `X | None` not `Optional[X]`
- Use `X | Y` not `Union[X, Y]`
- Return type always annotated, including `-> None`

## Testing (pytest)
- Test file mirrors source: `src/auth/login.py` → `tests/auth/test_login.py`
- Test function names: `test_<what>_<when>_<expected_outcome>`
- Use fixtures for setup/teardown, not setUp/tearDown
- Use parametrize for multiple input cases
- Mock external I/O — tests must run offline

## Async
- Use `asyncio` / `async def` for I/O-bound work
- Never `asyncio.run()` inside an existing event loop — use `await`
- Use `asyncio.gather()` for concurrent independent tasks
- Always `await` coroutines — bare coroutines silently do nothing

## Common Mistakes to Avoid
- Never use mutable default arguments: `def f(x=[])` — use `None` instead
- Never catch `Exception` broadly without re-raising or specific logging
- Never import inside functions unless avoiding circular imports
- Never use `print()` in production code — use `logging`
- Never hardcode file paths — use config or environment variables
