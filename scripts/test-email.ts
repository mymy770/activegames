/**
 * Script de test pour vérifier l'envoi d'email avec Resend
 *
 * Usage: npx ts-node scripts/test-email.ts
 */

import { Resend } from 'resend'
import { config } from 'dotenv'

// Charger les variables d'environnement depuis .env.local
config({ path: '.env.local' })

async function testEmail() {
  const apiKey = process.env.RESEND_API_KEY

  if (!apiKey) {
    console.error('❌ RESEND_API_KEY not found in environment')
    process.exit(1)
  }

  console.log('🔑 API Key found:', apiKey.substring(0, 10) + '...')

  const resend = new Resend(apiKey)

  // Adresse de test - Resend en mode sandbox n'envoie qu'aux emails vérifiés
  // Par défaut, on utilise l'email de test de Resend
  const testEmail = process.argv[2] || 'delivered@resend.dev'

  console.log(`📧 Sending test email to: ${testEmail}`)

  try {
    const { data, error } = await resend.emails.send({
      from: 'ActiveGames <onboarding@resend.dev>',
      to: testEmail,
      subject: 'Test Email from ActiveLaser',
      html: `
        <div style="background-color: #1a1a2e; color: white; padding: 40px; font-family: Arial, sans-serif;">
          <h1 style="color: #00f0ff;">Test Email</h1>
          <p>This is a test email from the ActiveLaser booking system.</p>
          <p>If you see this, the Resend integration is working correctly!</p>
          <p style="color: #a0a0b0; margin-top: 30px;">Sent at: ${new Date().toISOString()}</p>
        </div>
      `,
    })

    if (error) {
      console.error('❌ Error sending email:', error)
      process.exit(1)
    }

    console.log('✅ Email sent successfully!')
    console.log('📬 Response:', JSON.stringify(data, null, 2))

  } catch (err) {
    console.error('❌ Exception:', err)
    process.exit(1)
  }
}

testEmail()
