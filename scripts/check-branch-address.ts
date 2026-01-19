import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function checkBranch() {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  const { data: branches } = await supabase.from('branches').select('id, name, address')
  console.log('Branches:', JSON.stringify(branches, null, 2))
}
checkBranch()
