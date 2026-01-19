import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function updateHe() {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  const { data: template } = await supabase
    .from('email_templates')
    .select('id, body_template')
    .eq('code', 'booking_confirmation_he')
    .single()

  if (!template) {
    console.log('Template HE not found')
    return
  }

  // Afficher un extrait pour voir le format
  const idx = template.body_template.indexOf('booking_type')
  console.log('Context around booking_type:')
  console.log(template.body_template.substring(idx - 200, idx + 200))
}
updateHe()
