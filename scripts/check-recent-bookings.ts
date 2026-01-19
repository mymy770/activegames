import { createClient } from '@supabase/supabase-js'
import { config } from 'dotenv'
config({ path: '.env.local' })

async function checkBookings() {
  const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  const { data: bookings } = await supabase
    .from('bookings')
    .select(`
      id, reference_code, type, customer_first_name, created_at,
      game_sessions (id, game_area, laser_room_id)
    `)
    .order('created_at', { ascending: false })
    .limit(5)
  
  console.log('Recent bookings:')
  bookings?.forEach(b => {
    console.log(`\n- ${b.reference_code} | ${b.type} | ${b.customer_first_name}`)
    console.log(`  Sessions:`, b.game_sessions?.map((s: any) => `${s.game_area} (laser: ${s.laser_room_id})`))
  })

  // Check orders too
  const { data: orders } = await supabase
    .from('orders')
    .select('id, request_reference, order_type, game_area, status, created_at')
    .order('created_at', { ascending: false })
    .limit(5)
  
  console.log('\n\nRecent orders:')
  orders?.forEach(o => {
    console.log(`- ${o.request_reference} | type: ${o.order_type} | game_area: ${o.game_area} | status: ${o.status}`)
  })
}
checkBookings()
