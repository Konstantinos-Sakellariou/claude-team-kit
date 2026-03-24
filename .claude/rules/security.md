# Security Rules

## Secrets & Credentials
- NEVER hardcode secrets, tokens, passwords, or API keys in source code
- NEVER commit .env files — always use .env.example with dummy values
- Use environment variables for all secrets; read at startup, not inline
- Rotate any secret that was accidentally committed immediately
- Use secret managers (AWS Secrets Manager, Vault) in production

## Input & Validation
- Validate ALL user input on the server — client validation is UX only
- Use allowlists, not blocklists for input validation
- Sanitize before rendering to prevent XSS (use framework escaping)
- Parameterized queries always — NEVER string-concatenate SQL
- Validate file uploads: type, size, content (not just extension)
- Strip or reject unexpected fields from API payloads

## Authentication & Authorization
- Use established auth libraries — never roll your own crypto
- Hash passwords with bcrypt, argon2, or scrypt — never md5/sha1
- Enforce authorization on EVERY endpoint — never assume frontend hides it
- Implement rate limiting on auth endpoints (login, reset password)
- Use short-lived JWTs with refresh token rotation
- HTTPS everywhere — reject HTTP in production

## API Security
- Return 404 (not 403) when an unauthorized user requests a resource that exists
  (prevents enumeration)
- Never expose stack traces or internal errors to clients
- Sanitize error messages — log full detail server-side only
- CORS: specify exact allowed origins, never `*` in production
- Set security headers: Content-Security-Policy, X-Frame-Options, etc.

## Dependencies
- Run `pip audit` / `npm audit` regularly and in CI
- Review changelogs before major dependency upgrades
- Remove unused dependencies — they're attack surface
- Pin transitive dependencies in lock files

## Data
- Encrypt sensitive data at rest (PII, payments, health data)
- Minimize data collection — don't store what you don't need
- Implement data retention policies
- Mask/redact sensitive fields in logs (emails, tokens, card numbers)

## Code Review Security Checklist
Before any auth/payments/data PR merges:
- [ ] No secrets in code or logs
- [ ] All inputs validated and sanitized
- [ ] Authorization check on every action
- [ ] SQL uses parameterized queries
- [ ] Errors handled without leaking internals
- [ ] Dependencies audited
