import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function run() {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  // Exécuter la migration via SQL
  const { error } = await supabase.rpc('exec_sql', {
    sql: 'ALTER TABLE email_logs ADD COLUMN IF NOT EXISTS body_html TEXT;'
  })

  if (error) {
    console.log('RPC failed, trying direct query...')
    // Essayer directement
    const { error: error2 } = await supabase.from('email_logs').select('body_html').limit(1)
    if (error2 && error2.message.includes('does not exist')) {
      console.log('Column does not exist, please add it manually in Supabase dashboard')
    } else {
      console.log('Column already exists or accessible')
    }
  } else {
    console.log('✅ Column added')
  }
}
run()
