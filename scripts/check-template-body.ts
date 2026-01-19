import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function check() {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  const { data: template } = await supabase
    .from('email_templates')
    .select('code, body_template')
    .eq('code', 'booking_confirmation_en')
    .single()
  
  console.log('Template EN body:')
  console.log(template?.body_template)
}
check()
