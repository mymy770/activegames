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

  // Le template hébreu a "text-align: left" au lieu de "right"
  const oldPattern = `<tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">סוג</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{booking_type}}</td>
                      </tr>`

  const newPattern = `<tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">סוג</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{booking_type}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">משחק</td>
                        <td style="color: #00f0ff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{game_type}}</td>
                      </tr>`

  const newBody = template.body_template.replace(oldPattern, newPattern)

  if (newBody === template.body_template) {
    console.log('Pattern not found')
    return
  }

  const { error } = await supabase
    .from('email_templates')
    .update({ body_template: newBody })
    .eq('id', template.id)

  if (error) {
    console.log('Error:', error.message)
  } else {
    console.log('✅ Updated Hebrew template')
  }
}
updateHe()
