import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function check() {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  const { data: emails } = await supabase
    .from('email_logs')
    .select('id, status, error_message, created_at, template_code')
    .order('created_at', { ascending: false })
    .limit(10)
  
  console.log('Recent email logs:')
  emails?.forEach(e => {
    console.log(`- ${e.status} | ${e.template_code} | ${e.created_at}`)
    if (e.error_message) console.log(`  ERROR: ${e.error_message}`)
  })
}
check()
