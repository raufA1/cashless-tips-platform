# TipBridge (v4)

**Cashless tipping made simple.**  
A provider-agnostic, QR/link-based platform enabling street performers and service workers to receive instant, secure digital tips via Apple Pay, Google Pay, or bank cards.

---

## ✨ MVP Features
- Artist onboarding (basic KYC fields, payout account/IBAN)
- Public artist profile page (`/artist/:slug`)
- QR/link generator
- Payment session via pluggable provider (mock included)
- Webhook signature verification
- Real-time updates & admin payout export (basic)

---

## 🛠️ Stack
- **Backend:** Python (FastAPI), SQLAlchemy-ready, PostgreSQL
- **Frontend:** React (Vite), mobile-first
- **Payments:** Adapter pattern (`mock` ready; add real providers)
- **Infra:** Docker Compose, GitHub Actions

---

## 🚀 Quick Start (Docker)
```bash
docker compose up --build
```
- Backend: http://localhost:8000 (docs: /docs)
- Frontend: http://localhost:5173
- Postgres: localhost:5432 (user/pass/db: tipbridge)

Apply DB schema:
```bash
docker exec -i $(docker ps -qf "name=tipbridge-db-1")   psql -U tipbridge -d tipbridge < sql/schema.sql
```

---

## 🧪 Local (manual)
Backend
```bash
cd backend
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
uvicorn app.main:app --reload --port 8000
```

Frontend
```bash
cd frontend
npm install
npm run dev
```

---

## 🔐 Config
Create `backend/.env` from `.env.example`:
```
DATABASE_URL=postgresql://tipbridge:tipbridge@localhost:5432/tipbridge
PAYMENT_PROVIDER=mock
PAYMENT_API_KEY=CHANGE_ME
PAYMENT_WEBHOOK_SECRET=CHANGE_ME
SECRET_KEY=CHANGE_ME
```

---

## 📚 Plans & Project Management
- See `MASTER_PLAN.md` (single source of truth), `ROADMAP.md`, `PROJECTS.md`
- Import `import_backlog.csv` into Issues to populate your MVP board

MIT licensed. Contributions welcome! See `CONTRIBUTING.md`.
