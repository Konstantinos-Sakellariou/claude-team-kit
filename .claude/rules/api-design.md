# API Design Rules

## REST Conventions
- Resources are nouns, plural: `/users`, `/orders`, `/products`
- Actions via HTTP methods — not in the URL:
  - GET    /users          → list users
  - POST   /users          → create user
  - GET    /users/{id}     → get user
  - PATCH  /users/{id}     → partial update
  - PUT    /users/{id}     → full replace
  - DELETE /users/{id}     → delete
- Nested resources for clear ownership: `/users/{id}/orders`
- Actions that don't map to CRUD: `/orders/{id}/cancel` (POST) is acceptable

## Versioning
- Version in URL path: `/api/v1/`, `/api/v2/`
- Never break existing endpoints — add new ones
- Deprecate with a timeline, not a surprise
- Include `Deprecation` and `Sunset` headers for deprecated endpoints

## Request & Response
- Always return JSON (unless binary)
- Consistent response envelope:
  ```json
  {
    "data": { ... },
    "meta": { "page": 1, "total": 100 },
    "errors": null
  }
  ```
- snake_case for JSON keys
- ISO 8601 for dates: `"2024-01-15T10:30:00Z"`
- Never return HTML error pages from an API — always JSON
- Paginate collections — never return unbounded lists
  ```json
  { "data": [...], "meta": { "page": 1, "per_page": 20, "total": 342 } }
  ```

## HTTP Status Codes
- 200 OK — success (GET, PATCH, PUT)
- 201 Created — successful POST (include Location header)
- 204 No Content — success with no body (DELETE)
- 400 Bad Request — invalid input (include what's wrong)
- 401 Unauthorized — not authenticated
- 403 Forbidden — authenticated but not authorized
- 404 Not Found — resource doesn't exist (also use for unauthorized to prevent enumeration)
- 409 Conflict — state conflict (duplicate, optimistic lock)
- 422 Unprocessable — validation failed (include field errors)
- 429 Too Many Requests — rate limited (include Retry-After)
- 500 Internal Server Error — server bug (never include internals in response)

## Error Responses
```json
{
  "errors": [
    {
      "code": "VALIDATION_ERROR",
      "field": "email",
      "message": "Must be a valid email address"
    }
  ]
}
```
- Machine-readable `code` (snake_upper_case)
- Human-readable `message`
- `field` for validation errors
- Never expose stack traces, SQL, or internal paths

## Security
- Auth on every non-public endpoint
- Rate limiting on all endpoints, stricter on auth
- Input validation before any processing
- CORS configured explicitly
- No sensitive data in query params (goes in request body or headers)

## Documentation
- Every endpoint documented: purpose, auth, params, request body, responses, errors
- Provide example requests and responses
- OpenAPI/Swagger spec maintained alongside code (not after)
- Breaking changes announced in changelog
