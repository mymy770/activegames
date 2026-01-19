/**
 * Script pour vérifier les templates d'email dans Supabase
 *
 * Usage: npx tsx scripts/check-templates.ts
 */

import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'

// Charger les variables d'environnement depuis .env.local
config({ path: '.env.local' })

async function checkTemplates() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY

  if (!supabaseUrl || !supabaseKey) {
    console.error('❌ Supabase credentials not found')
    process.exit(1)
  }

  const supabase = createClient(supabaseUrl, supabaseKey)

  console.log('📧 Checking email templates...\n')

  // Récupérer tous les templates
  const { data: templates, error } = await supabase
    .from('email_templates')
    .select('id, code, name, is_active, created_at')
    .order('code')

  if (error) {
    console.error('❌ Error fetching templates:', error.message)
    process.exit(1)
  }

  if (!templates || templates.length === 0) {
    console.log('⚠️  No templates found in database!')
    console.log('\n📋 Please run the SQL migration to create templates:')
    console.log('   supabase/migrations/20240118_email_system.sql')
    process.exit(1)
  }

  console.log(`✅ Found ${templates.length} templates:\n`)

  for (const t of templates) {
    const status = t.is_active ? '🟢' : '🔴'
    console.log(`${status} ${t.code}`)
    console.log(`   Name: ${t.name}`)
    console.log(`   ID: ${t.id}`)
    console.log('')
  }

  // Vérifier les templates de confirmation multi-langues
  const expectedCodes = ['booking_confirmation_fr', 'booking_confirmation_en', 'booking_confirmation_he']
  const foundCodes = templates.map(t => t.code)
  const missingCodes = expectedCodes.filter(code => !foundCodes.includes(code))

  if (missingCodes.length > 0) {
    console.log('\n⚠️  Missing multi-language templates:')
    for (const code of missingCodes) {
      console.log(`   - ${code}`)
    }
    console.log('\n📋 Run the SQL migration to create them:')
    console.log('   supabase/migrations/20240118_email_system.sql')
  } else {
    console.log('✅ All multi-language templates are present!')
  }

  // Vérifier les logs d'email récents
  console.log('\n\n📬 Recent email logs:\n')

  const { data: logs, error: logsError } = await supabase
    .from('email_logs')
    .select('id, recipient_email, subject, status, error_message, created_at')
    .order('created_at', { ascending: false })
    .limit(5)

  if (logsError) {
    console.error('❌ Error fetching logs:', logsError.message)
  } else if (!logs || logs.length === 0) {
    console.log('   No email logs found yet.')
  } else {
    for (const log of logs) {
      const statusIcon = log.status === 'sent' ? '✅' : log.status === 'failed' ? '❌' : '⏳'
      console.log(`${statusIcon} ${log.subject}`)
      console.log(`   To: ${log.recipient_email}`)
      console.log(`   Status: ${log.status}`)
      if (log.error_message) {
        console.log(`   Error: ${log.error_message}`)
      }
      console.log(`   Time: ${log.created_at}`)
      console.log('')
    }
  }
}

checkTemplates()
