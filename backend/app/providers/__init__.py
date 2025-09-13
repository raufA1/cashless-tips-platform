import os
from .mock import MockProvider

def get_provider():
    name = os.getenv("PAYMENT_PROVIDER", "mock").lower()
    # Extend here: if name == "epoint": return EpointProvider(...)
    return MockProvider()
