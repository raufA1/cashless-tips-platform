import hashlib, hmac, os, time

class MockProvider:
    def __init__(self):
        self.secret = os.getenv("PAYMENT_WEBHOOK_SECRET", "dev")

    async def create_session(self, amount: float, currency: str, metadata: dict):
        sid = f"mock_{int(time.time()*1000)}"
        return {"id": sid, "url": f"https://pay.example.com/session/{sid}"}

    def verify_signature(self, signature: str, body: bytes) -> bool:
        mac = hmac.new(self.secret.encode(), body, hashlib.sha256).hexdigest()
        return hmac.compare_digest(signature or "", mac)
