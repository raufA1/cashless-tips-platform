# TipBridge

**Cashless tipping made simple.**  
A provider-agnostic, QR/link-based platform enabling street performers and service workers to receive instant, secure digital tips via Apple Pay, Google Pay, or bank cards.

---

## 🎯 Mission
As cash usage declines, performers and workers lose spontaneous support. TipBridge aims to **bridge the generosity gap** with the fastest, most trusted way to tip — ensuring the intended amount reaches the artist.

---

## ✨ Core MVP Features
- Artist onboarding (basic KYC fields, payout account/IBAN)
- QR/link generator (EMVCo/national QR pluggable)
- Public artist profile page (name, photo, bio)
- Payment session creation via pluggable providers
- Real-time payment notifications (webhooks)
- Mobile-first tipping flow (Apple/Google Pay ready)

---

## 🛠️ Tech Stack
- **Backend:** Python (FastAPI), SQLAlchemy, PostgreSQL
- **Frontend:** React (Vite), mobile-first UI
- **Payments:** Provider-agnostic adapter pattern (e.g., Stripe-like, Epoint, etc.)
- **Infra:** Docker, GitHub Actions, .env-based config

---

## 📦 Monorepo Layout
```
tipbridge/
├─ backend/            # FastAPI app + payment adapters
├─ frontend/           # Vite + React app
├─ sql/                # Database schema & migrations (initial)
├─ docs/               # Architecture, pilots, compliance placeholders
├─ .github/            # CI, issue/PR templates
└─ docker-compose.yml  # Local dev stack (API + DB + Frontend)
```

---

## 🚀 Quick Start (Local Dev)

### 1) Docker (recommended)
```bash
docker compose up --build
```
- Backend: http://localhost:8000
- Frontend: http://localhost:5173
- Postgres: localhost:5432 (user: tipbridge, pass: tipbridge)

### 2) Manual

**Backend**
```bash
cd backend
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
uvicorn app.main:app --reload --port 8000
```

**Frontend**
```bash
cd frontend
npm install
npm run dev
```

---

## 🔐 Configuration
Create `backend/.env` from `.env.example`:
```
DATABASE_URL=postgresql://tipbridge:tipbridge@localhost:5432/tipbridge
PAYMENT_PROVIDER=mock            # mock | epoint | stripe | ...
PAYMENT_API_KEY=CHANGE_ME
PAYMENT_WEBHOOK_SECRET=CHANGE_ME
SECRET_KEY=CHANGE_ME
```

---

## 🧪 Testing
- Add unit tests in `backend/tests` and `frontend` as needed.
- CI runs build and basic checks on each push/PR.

---

## 📌 Roadmap (MVP)
- [ ] Payment adapter (mock → real provider)
- [ ] Webhook signature verification
- [ ] Artist profile & tipping page (mobile-first)
- [ ] QR/link generator & printable assets
- [ ] Pilot with early users
- [ ] Basic admin (payout requests/exports)

---

## 🤝 Contributing
Issues and PRs are welcome. See `.github/` templates.

---

## 📝 License
MIT — see [LICENSE](./LICENSE).
