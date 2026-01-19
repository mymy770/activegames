import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function test() {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  // Regarder les derniers emails
  const { data: emails } = await supabase
    .from('email_logs')
    .select('id, status, error_message, created_at, recipient_email')
    .order('created_at', { ascending: false })
    .limit(5)
  
  console.log('Derniers emails:')
  emails?.forEach(e => {
    console.log(`- ${e.status} | ${e.recipient_email} | ${e.created_at}`)
    if (e.error_message) console.log(`  ERROR: ${e.error_message}`)
  })
}
test()
