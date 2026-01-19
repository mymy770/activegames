import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function updateAddresses() {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  // Mise à jour Rishon LeZion
  const { error: error1 } = await supabase
    .from('branches')
    .update({ address: 'At Laser City complex, Aliyat HaNoar 1, Bar-On Center – Floor 5' })
    .eq('name', 'Rishon LeZion')

  if (error1) {
    console.error('Error updating Rishon:', error1)
  } else {
    console.log('✅ Updated Rishon LeZion address')
  }

  // Mise à jour Petah Tikva
  const { error: error2 } = await supabase
    .from('branches')
    .update({ address: 'At Laser City complex, Amal 37' })
    .eq('name', 'Petah Tikva')

  if (error2) {
    console.error('Error updating Petah Tikva:', error2)
  } else {
    console.log('✅ Updated Petah Tikva address')
  }

  // Vérifier
  const { data: branches } = await supabase.from('branches').select('name, address')
  console.log('\nUpdated addresses:')
  branches?.forEach(b => console.log(`- ${b.name}: ${b.address}`))
}
updateAddresses()
