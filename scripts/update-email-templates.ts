import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function updateTemplates() {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  // Pour chaque template, ajouter une ligne game_type après booking_type
  const templates = [
    { code: 'booking_confirmation_en', typeLabel: 'Activity', gameLabel: 'Game' },
    { code: 'booking_confirmation_fr', typeLabel: 'Activité', gameLabel: 'Jeu' },
    { code: 'booking_confirmation_he', typeLabel: 'פעילות', gameLabel: 'משחק' },
  ]

  for (const t of templates) {
    const { data: template } = await supabase
      .from('email_templates')
      .select('id, body_template')
      .eq('code', t.code)
      .single()

    if (!template) {
      console.log(`Template ${t.code} not found`)
      continue
    }

    // Vérifier si game_type est déjà présent
    if (template.body_template.includes('{{game_type}}')) {
      console.log(`Template ${t.code} already has game_type`)
      continue
    }

    // Ajouter une ligne pour game_type après la ligne Type/booking_type
    // Chercher le pattern de la ligne Type
    const oldPattern = `<tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Type</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{booking_type}}</td>
                      </tr>`

    const newPattern = `<tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Type</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{booking_type}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">${t.gameLabel}</td>
                        <td style="color: #00f0ff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{game_type}}</td>
                      </tr>`

    const newBody = template.body_template.replace(oldPattern, newPattern)

    if (newBody === template.body_template) {
      console.log(`Template ${t.code}: pattern not found, trying alternative...`)
      // Pattern alternatif - chercher juste booking_type et ajouter après
      continue
    }

    const { error } = await supabase
      .from('email_templates')
      .update({ body_template: newBody })
      .eq('id', template.id)

    if (error) {
      console.log(`Error updating ${t.code}:`, error.message)
    } else {
      console.log(`✅ Updated ${t.code}`)
    }
  }
}
updateTemplates()
