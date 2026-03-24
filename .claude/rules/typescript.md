# TypeScript Rules

## Compiler
- Strict mode always: `"strict": true` in tsconfig
- No `any` — use `unknown` when the type is truly unknown, then narrow
- No `@ts-ignore` — fix the type error properly
- `noImplicitReturns`, `noFallthroughCasesInSwitch` enabled

## Style
- ES modules only: `import/export`, never `require()`
- Arrow functions for callbacks and short utilities
- `const` by default, `let` only when reassignment is needed, never `var`
- Destructure objects and arrays at the top of functions
- Template literals for string interpolation
- Optional chaining (`?.`) and nullish coalescing (`??`) over ternary chains

## Types
- Prefer `interface` for object shapes that could be extended
- Use `type` for unions, intersections, and mapped types
- Export types separately from values when possible
- Avoid enums — use `as const` objects instead:
  ```ts
  const STATUS = { ACTIVE: 'active', INACTIVE: 'inactive' } as const
  type Status = typeof STATUS[keyof typeof STATUS]
  ```
- Use discriminated unions for variant types

## Functions
- Always annotate return types on exported functions
- Prefer named exports over default exports (easier to refactor)
- Use generics for reusable functions, but don't over-engineer
- Async functions always return `Promise<T>` — annotate it

## React (if applicable)
- Functional components only — no class components
- Type props explicitly: `interface ButtonProps { ... }`
- `React.FC` is acceptable but explicit props typing is preferred
- Custom hooks start with `use` and return typed values
- Keys in lists must be stable and unique — never array index

## Testing (Jest / Vitest)
- Test file: `Component.test.tsx` next to the component
- Mock external modules with `jest.mock()` / `vi.mock()` at module level
- Avoid `any` in test assertions — type your mocks
- Use `@testing-library/user-event` over `fireEvent` for user interactions

## Common Mistakes to Avoid
- Never use `==` — always `===`
- Never `Object.assign` for merging — use spread: `{ ...a, ...b }`
- Never mutate function arguments
- Never `catch (e: any)` — use `catch (e: unknown)` and narrow
- Avoid `!` non-null assertion — prefer explicit null checks
