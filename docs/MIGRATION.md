# Migration plan

1. **Stage the database** — restore a copy of production MariaDB and use it for development/testing.
2. **Rotate all exposed secrets** — DB, SMTP, Meta tokens/secrets, OpenAI key, signing/webhook tokens.
3. **Deploy this package read-first** — validate authentication and every module against staging.
4. **Migrate writes** — leads/tasks -> transactions -> documents -> commissions -> trust/accounting -> SignVolt.
5. **Move file storage** — do not keep signed PDFs in a public web directory. Use private object storage with signed URLs.
6. **Webhook cutover** — Meta/Google/signature callbacks should be moved only after staging tests and idempotency checks.
7. **Production switch** — route modules incrementally, keeping rollback available.

### Important
The generated React pages are a functional modernization foundation and database-aware feature map. Complex legacy business actions (commission posting, trust release, PDF stamping, sequential e-sign execution, webhook side effects) require transaction-by-transaction verification before production write access.
