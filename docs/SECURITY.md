# Security changes required before production

- Rotate credentials exposed in the supplied PHP/config/database export.
- Never commit `.env*` files containing live values.
- Keep signed documents and client uploads outside public web roots.
- Use short-lived signed download URLs and authorization checks for every document.
- Enforce `brokerage_id` on all tenant-owned records.
- Hash passwords with bcrypt/argon2; never MD5.
- Store integration access tokens encrypted at rest.
- Verify webhook signatures and implement replay/idempotency protection.
- Use CSRF-safe same-site cookies and origin checks for sensitive writes.
- Record immutable audit events for trust/accounting/signature state changes.
- Require MFA for SaaS/brokerage administrators before production financial controls.
