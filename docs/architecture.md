# Architecture (MVP)

**Components**
- Frontend (React/Vite): Mobile-first UI for artist profiles and tipping
- Backend (FastAPI): REST API, payment sessions, webhooks, admin
- Database (PostgreSQL): artists, tips, payouts
- Payment Provider: adapter pattern; mock → real
- CI/CD: GitHub Actions; Docker for dev

**Flow (Happy Path)**
1. Donor visits `/artist/:slug` (QR or link)
2. Selects amount → frontend calls `POST /api/tips/create`
3. Backend creates payment session via provider adapter; returns redirect/client secret
4. Donor completes payment (Apple/Google Pay, card)
5. Provider calls `POST /api/payments/webhook` → backend verifies signature → marks tip `succeeded`
6. Admin exports payouts for settlement

See `sql/schema.sql` for schema.
