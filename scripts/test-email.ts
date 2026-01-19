/**
 * Script de test pour vérifier l'envoi d'email avec Brevo
 *
 * Usage: npx ts-node scripts/test-email.ts
 */

import * as Brevo from '@getbrevo/brevo'
import { config } from 'dotenv'

// Charger les variables d'environnement depuis .env.local
config({ path: '.env.local' })

async function testEmail() {
  const apiKey = process.env.BREVO_API_KEY

  if (!apiKey) {
    console.error('❌ BREVO_API_KEY not found in environment')
    process.exit(1)
  }

  console.log('🔑 API Key found:', apiKey.substring(0, 15) + '...')

  const apiInstance = new Brevo.TransactionalEmailsApi()
  apiInstance.setApiKey(Brevo.TransactionalEmailsApiApiKeys.apiKey, apiKey)

  // Adresse de test
  const testEmailAddr = process.argv[2] || 'test@example.com'

  console.log(`📧 Sending test email to: ${testEmailAddr}`)

  try {
    const sendSmtpEmail = new Brevo.SendSmtpEmail()
    sendSmtpEmail.sender = {
      email: process.env.BREVO_FROM_EMAIL || 'no-reply@activegames.co.il',
      name: process.env.BREVO_FROM_NAME || 'ActiveGames'
    }
    sendSmtpEmail.to = [{ email: testEmailAddr, name: 'Test User' }]
    sendSmtpEmail.subject = 'Test Email from ActiveLaser'
    sendSmtpEmail.htmlContent = `
      <div style="background-color: #1a1a2e; color: white; padding: 40px; font-family: Arial, sans-serif;">
        <h1 style="color: #00f0ff;">Test Email</h1>
        <p>This is a test email from the ActiveLaser booking system.</p>
        <p>If you see this, the Brevo integration is working correctly!</p>
        <p style="color: #a0a0b0; margin-top: 30px;">Sent at: ${new Date().toISOString()}</p>
      </div>
    `

    const response = await apiInstance.sendTransacEmail(sendSmtpEmail)

    if (response?.body?.messageId) {
      console.log('✅ Email sent successfully!')
      console.log('📬 Message ID:', response.body.messageId)
    } else {
      console.error('❌ No messageId in response')
      console.log('Response:', JSON.stringify(response, null, 2))
      process.exit(1)
    }

  } catch (err) {
    console.error('❌ Exception:', err)
    process.exit(1)
  }
}

testEmail()
