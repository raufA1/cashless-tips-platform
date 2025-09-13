import React, { useState } from 'react'
import ArtistQR from './components/ArtistQR.jsx'

export default function App() {
  const [slug, setSlug] = useState('demo-artist')
  const [amount, setAmount] = useState(2)
  const [currency, setCurrency] = useState('USD')

  const createSession = async () => {
    const res = await fetch('http://localhost:8000/api/tips/create', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({ artist_slug: slug, amount: Number(amount), currency })
    })
    const data = await res.json()
    window.open(data.pay_url, '_blank')
  }

  return (
    <div style={{padding: 16, maxWidth: 420, margin: '0 auto', fontFamily: 'system-ui, sans-serif'}}>
      <h1>TipBridge (Demo)</h1>
      <label>Artist slug</label>
      <input value={slug} onChange={e => setSlug(e.target.value)} style={{width:'100%', padding:8, marginBottom:8}} />

      <ArtistQR slug={slug} />

      <label>Amount</label>
      <input type="number" value={amount} onChange={e => setAmount(e.target.value)} style={{width:'100%', padding:8, marginBottom:8}} />

      <label>Currency</label>
      <select value={currency} onChange={e => setCurrency(e.target.value)} style={{width:'100%', padding:8, marginBottom:8}}>
        <option>USD</option>
        <option>EUR</option>
        <option>AZN</option>
      </select>

      <button onClick={createSession} style={{marginTop:12, padding:'10px 16px', width:'100%'}}>Tip Now</button>
      <p style={{marginTop:16, fontSize:12, opacity:0.7}}>Local demo with mock provider. Replace with a real payment adapter.</p>
    </div>
  )
}
