from fastapi import FastAPI, Request, HTTPException, Depends
from pydantic import BaseModel
import os

from .providers import get_provider

app = FastAPI(title="TipBridge API", version="0.1.0")

# --- Models (Pydantic) ---
class ArtistCreate(BaseModel):
    name: str
    tax_id: str | None = None
    iban: str | None = None

class TipCreate(BaseModel):
    artist_slug: str
    amount: float
    currency: str = "USD"

# --- In-memory store (replace with DB layer) ---
ARTISTS = {"demo-artist": {"name": "Demo Artist", "tax_id": None, "iban": None}}
TIPS = []

@app.get("/health")
async def health():
    return {"status": "ok"}

@app.post("/api/artists")
async def create_artist(payload: ArtistCreate):
    slug = payload.name.lower().replace(" ", "-")
    if slug in ARTISTS:
        raise HTTPException(status_code=409, detail="Artist already exists")
    ARTISTS[slug] = payload.dict()
    return {"result": "ok", "slug": slug}

@app.get("/api/artists/{slug}")
async def get_artist(slug: str):
    artist = ARTISTS.get(slug)
    if not artist:
        raise HTTPException(status_code=404, detail="Not found")
    return {"slug": slug, **artist}

@app.post("/api/tips/create")
async def create_tip(payload: TipCreate, provider=Depends(get_provider)):
    # TODO: replace with DB lookups
    if payload.artist_slug not in ARTISTS:
        raise HTTPException(status_code=404, detail="Artist not found")

    session = await provider.create_session(
        amount=payload.amount,
        currency=payload.currency,
        metadata={"artist_slug": payload.artist_slug},
    )
    tip = {
        "artist_slug": payload.artist_slug,
        "amount": payload.amount,
        "currency": payload.currency,
        "status": "pending",
        "session_url": session["url"],
        "session_id": session["id"],
    }
    TIPS.append(tip)
    return {"pay_url": session["url"]}

@app.post("/api/payments/webhook")
async def payments_webhook(req: Request, provider=Depends(get_provider)):
    signature = req.headers.get("X-Signature", "")
    body = await req.body()
    if not provider.verify_signature(signature, body):
        raise HTTPException(status_code=400, detail="Invalid signature")
    data = await req.json()
    session_id = data.get("session_id")
    status = data.get("status", "succeeded")
    for tip in TIPS:
        if tip.get("session_id") == session_id:
            tip["status"] = status
            break
    return {"ok": True}
