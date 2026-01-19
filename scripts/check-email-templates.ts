import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function check() {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  const { data: templates } = await supabase
    .from('email_templates')
    .select('code, name, subject_template')
  
  console.log('Email templates:')
  templates?.forEach(t => {
    console.log(`- ${t.code}: ${t.name}`)
    console.log(`  Subject: ${t.subject_template}`)
  })
}
check()
