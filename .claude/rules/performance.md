# Performance Rules

## Measure First
- Never optimize without profiling — assumptions are almost always wrong
- Establish baselines before and after changes
- Tools: cProfile/py-spy (Python), Chrome DevTools/clinic.js (Node), k6/Locust (load testing)
- Set performance budgets: define what "acceptable" means before you start

## Algorithms & Data Structures
- Know your complexity: aim for O(n log n) or better in hot paths
- Use sets/dicts for membership checks, not lists: O(1) vs O(n)
- Avoid N+1 queries — batch database lookups
- Sort once, don't re-sort unless data changes
- Use generators/iterators for large sequences — don't load everything into memory

## Database
- Index columns used in WHERE, JOIN, and ORDER BY clauses
- Use EXPLAIN ANALYZE to verify query plans
- Avoid SELECT * — fetch only needed columns
- Batch inserts/updates — one query beats N queries
- Use connection pooling — don't open/close connections per request
- Cache hot, rarely-changing queries (Redis, in-memory)
- Paginate large result sets — never return unbounded collections

## API & Network
- Return only the data the client needs — no over-fetching
- Compress responses (gzip/brotli) for large payloads
- Use HTTP/2 where possible — multiplexes requests
- Set proper cache headers for static assets and stable data
- Debounce/throttle client-side API calls
- Use CDN for static assets and global distribution

## Python-Specific
- Use `asyncio` for I/O-bound work — don't block the event loop
- For CPU-bound: multiprocessing or C extensions (numpy, pandas)
- List comprehensions and generators over loops for data transformation
- `functools.lru_cache` / `functools.cache` for pure function memoization
- Prefer built-in functions — they're implemented in C

## TypeScript/Node-Specific
- `async/await` for all I/O — never block the event loop
- Use streams for large file operations — don't read files into memory
- Web Workers for CPU-heavy frontend tasks
- Memoize expensive computations with `useMemo` (React)
- Virtualize long lists — render only visible items
- Code split and lazy load — reduce initial bundle size

## Caching Strategy
- Cache at the layer closest to the user
- Cache invalidation: time-based (TTL) for frequently changing, event-based for critical accuracy
- Never cache user-specific data in shared caches
- Document what is cached and for how long

## What NOT to Do
- Don't premature optimize — write clean code first
- Don't cache everything — stale data has real costs
- Don't parallelize everything — coordination overhead exists
- Don't sacrifice readability for micro-optimizations
