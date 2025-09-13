import React from 'react'
import QRCode from 'qrcode.react'

export default function ArtistQR({ slug }) {
  const url = `https://tipbridge.example.com/artist/${slug}`
  return (
    <div style={{display:'flex', justifyContent:'center', margin:'12px 0'}}>
      <QRCode value={url} size={180} />
    </div>
  )
}
