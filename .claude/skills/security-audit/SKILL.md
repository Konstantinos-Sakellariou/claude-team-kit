---
name: security-audit
description: Run a security audit on a file, module, or the full codebase. Checks for OWASP Top 10 vulnerabilities, hardcoded secrets, insecure dependencies, and security anti-patterns.
allowed-tools: Read, Bash, Glob, Grep
model: opus
argument-hint: [file/path or "full" for whole project]
---

Run a security audit on: $ARGUMENTS

## Audit Steps

### 1. Secret Detection
```bash
# Check for hardcoded secrets patterns
grep -rn "password\s*=\s*['\"]" --include="*.py" --include="*.ts" --include="*.js" .
grep -rn "api_key\s*=\s*['\"]" .
grep -rn "secret\s*=\s*['\"]" .
grep -rn "token\s*=\s*['\"]" .
# Check .env is gitignored
cat .gitignore | grep -E "\.env"
```

### 2. Dependency Vulnerabilities
```bash
# Python
pip audit 2>/dev/null || echo "pip-audit not installed: run pip install pip-audit"
# Node
npm audit 2>/dev/null || echo "no package.json found"
```

### 3. Injection Vulnerabilities
Search for:
- SQL string concatenation (not parameterized)
- Shell command injection (user input in shell calls)
- Path traversal (unvalidated file paths)
- XSS (unescaped output to HTML)

### 4. Authentication & Authorization
Review:
- All endpoints for authorization checks
- Password hashing (bcrypt/argon2 vs md5/sha1)
- Session handling
- Rate limiting on auth endpoints

### 5. Data Exposure
Check:
- Error messages for internal details
- Logs for sensitive data (PII, tokens)
- API responses returning more than needed
- Debug mode in production

### 6. Cryptography
- Custom crypto implementations (red flag)
- Weak algorithms (MD5, SHA1 for security, DES, RC4)
- Hardcoded encryption keys

## Output Format

```
## Security Audit Report
**Target:** [what was audited]
**Date:** [today]

### Critical 🔴
[Must fix immediately]

### High 🟠
[Fix before next release]

### Medium 🟡
[Fix this sprint]

### Low 🔵
[Track in backlog]

### Informational ℹ️
[Best practice suggestions]

### Dependencies
[Output from pip audit / npm audit]

### Overall Risk Level: CRITICAL / HIGH / MEDIUM / LOW
```
