# MyRealDesk 2.0 — Next.js / React

GitHub-ready modernization scaffold generated from the supplied MyRealDesk PHP application and MariaDB export.

## What is included

- Next.js App Router + React + TypeScript
- Existing MariaDB/MySQL database compatibility (`mysql2`)
- Login compatible with existing PHP bcrypt hashes (`$2y$` normalized for Node)
- Brokerage-aware session and query scoping
- Dashboards and data views for CRM, leads, pipeline, tasks, messaging, community, transactions, listings, open houses, property pages, goals, resources, commissions, accounting, banking, trust, reconciliation, compliance, reports, T4A/payroll, agents, lead distribution, integrations, imports, email templates and brokerage settings
- SignVolt views for documents, templates, signers and signing audit events
- Allow-listed JSON resource API
- Structure-only copy of the legacy database schema (no INSERT statements)
- Security-safe `.env.example`; no live credentials are included

## Run locally

```bash
npm install
cp .env.example .env.local
# fill in DB credentials and AUTH_SECRET
npm run dev
```

Open http://localhost:3000 and sign in with an existing MyRealDesk user.

## Deploy

Recommended: GitHub -> Vercel. Your MariaDB must accept connections from the deployment environment. For production, consider a managed MySQL-compatible database or a secure API/database network path.

## Migration approach

This package intentionally reads your **existing schema** first. That allows staged migration from PHP without forcing a risky one-day database cutover. Write actions and the more complex workflow engines should be migrated module-by-module and tested against a staging database before changing production traffic.

See `docs/MIGRATION.md`, `docs/FEATURE-MAP.md`, and `docs/SECURITY.md`.


## Hostinger compatibility

This package is pinned to Next.js 15 for compatibility with Hostinger environments that expose an older GLIBC runtime. mysql2 includes its own TypeScript definitions; do not install @types/mysql2.
