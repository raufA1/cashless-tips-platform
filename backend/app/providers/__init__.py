import os
from .mock import MockProvider

def get_provider():
    name = os.getenv("PAYMENT_PROVIDER", "mock").lower()
    # TODO: add other providers e.g. Stripe/Epoint with dedicated classes
    return MockProvider()
