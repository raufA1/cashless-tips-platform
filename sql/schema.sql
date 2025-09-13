CREATE TABLE IF NOT EXISTS artists (
  id SERIAL PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  tax_id VARCHAR(50),
  iban TEXT,
  profile_image TEXT,
  kyc_status VARCHAR(20) DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE IF NOT EXISTS tips (
  id SERIAL PRIMARY KEY,
  artist_id INT REFERENCES artists(id),
  amount NUMERIC(10,2) NOT NULL,
  currency VARCHAR(10) DEFAULT 'USD',
  processor_fee NUMERIC(10,2),
  donor_paid_fee BOOLEAN DEFAULT TRUE,
  processor_payment_id TEXT,
  status VARCHAR(20) DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE IF NOT EXISTS payouts (
  id SERIAL PRIMARY KEY,
  artist_id INT REFERENCES artists(id),
  amount NUMERIC(10,2),
  status VARCHAR(20) DEFAULT 'requested',
  created_at TIMESTAMP DEFAULT now(),
  processed_at TIMESTAMP
);
