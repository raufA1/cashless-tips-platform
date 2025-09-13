# TipBridge — Master Plan (SSOT)

Vision: Provider-agnostic, QR/link-based tipping with mobile-first UX and real-time webhooks.

**Success**: E2E tip flow in sandbox, 95%+ payment success, conversion ≥30%, webhook verified, payout export OK.

## Phases
- **Init**: repo, compose, CI
- **MVP**: adapter + webhook + QR + profile + DB + pilot
- **Beta**: admin payouts, notifications, i18n, migrations
- **GA**: reliability, observability, security hardening

## POR (Ordered Tasks)
1) DB: move memory → PostgreSQL
2) Payments: adapter (sandbox) + `verify_signature`
3) Webhook: mark tip succeeded
4) FE: `/artist/:slug` + Tip flow
5) QR: printable assets
6) Pilot: onboarding, feedback
7) Admin: payout CSV
8) CI: lint/tests
9) Observability: error tracking

Governance: DOR/DOD, reviews via PR, no secrets in code.
