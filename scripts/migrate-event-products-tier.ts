/**
 * Migration Script: Link EVENT formulas to tier-based products
 *
 * This script:
 * 1. Fetches all event formulas without product_id
 * 2. Creates tier-based products (event_laser_5_15 format)
 * 3. Links formulas to their products
 * 4. Syncs products to iCount
 *
 * Run with: npx tsx scripts/migrate-event-products-tier.ts
 */

import * as dotenv from 'dotenv'
dotenv.config({ path: '.env.local' })

import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY!

const supabase = createClient(supabaseUrl, supabaseServiceKey, {
  auth: { autoRefreshToken: false, persistSession: false }
})

interface EventFormula {
  id: string
  branch_id: string
  name: string
  game_type: 'LASER' | 'ACTIVE' | 'BOTH'
  min_participants: number
  max_participants: number
  price_per_person: number
  product_id: string | null
  is_active: boolean
}

interface Product {
  id: string
  branch_id: string
  code: string
  name: string
  unit_price: number
}

function generateEventProductCode(formula: EventFormula): string {
  return `event_${formula.game_type.toLowerCase()}_${formula.min_participants}_${formula.max_participants}`
}

async function main() {
  console.log('=== Migration: Event Products to Tier-Based Naming ===\n')

  // 1. Fetch all event formulas
  const { data: formulas, error: formulasError } = await supabase
    .from('icount_event_formulas')
    .select('*')
    .order('branch_id')

  if (formulasError) {
    console.error('Error fetching formulas:', formulasError.message)
    return
  }

  console.log(`Found ${formulas?.length || 0} event formulas\n`)

  if (!formulas || formulas.length === 0) {
    console.log('No formulas to migrate.')
    return
  }

  // 2. Process each formula
  let created = 0
  let linked = 0
  let skipped = 0
  let errors = 0

  for (const formula of formulas as EventFormula[]) {
    const productCode = generateEventProductCode(formula)
    console.log(`\nProcessing: ${formula.name}`)
    console.log(`  Game type: ${formula.game_type}`)
    console.log(`  Participants: ${formula.min_participants}-${formula.max_participants}`)
    console.log(`  Price: ${formula.price_per_person}`)
    console.log(`  Current product_id: ${formula.product_id || 'none'}`)
    console.log(`  Target code: ${productCode}`)

    // Check if already linked
    if (formula.product_id) {
      console.log('  → Already has product_id, skipping')
      skipped++
      continue
    }

    // Check if product exists
    const { data: existingProduct } = await supabase
      .from('icount_products')
      .select('*')
      .eq('branch_id', formula.branch_id)
      .eq('code', productCode)
      .single()

    let productId: string

    if (existingProduct) {
      console.log(`  → Found existing product: ${existingProduct.id}`)
      productId = existingProduct.id

      // Update price if different
      if (existingProduct.unit_price !== formula.price_per_person) {
        console.log(`  → Updating price: ${existingProduct.unit_price} -> ${formula.price_per_person}`)
        await supabase
          .from('icount_products')
          .update({
            unit_price: formula.price_per_person,
            name: formula.name,
            name_he: formula.name,
          })
          .eq('id', productId)
      }
    } else {
      // Create new product
      console.log('  → Creating new product...')
      const { data: newProduct, error: createError } = await supabase
        .from('icount_products')
        .insert({
          branch_id: formula.branch_id,
          code: productCode,
          name: formula.name,
          name_he: formula.name,
          name_en: formula.name,
          unit_price: formula.price_per_person,
          is_active: true,
          sort_order: 100,
        })
        .select()
        .single()

      if (createError || !newProduct) {
        console.error(`  ✗ Failed to create product: ${createError?.message}`)
        errors++
        continue
      }

      productId = newProduct.id
      created++
      console.log(`  ✓ Created product: ${productId}`)
    }

    // Link formula to product
    const { error: linkError } = await supabase
      .from('icount_event_formulas')
      .update({ product_id: productId })
      .eq('id', formula.id)

    if (linkError) {
      console.error(`  ✗ Failed to link: ${linkError.message}`)
      errors++
    } else {
      linked++
      console.log(`  ✓ Linked formula to product`)
    }
  }

  // 3. Summary
  console.log('\n\n=== Migration Summary ===')
  console.log(`Total formulas: ${formulas.length}`)
  console.log(`Products created: ${created}`)
  console.log(`Formulas linked: ${linked}`)
  console.log(`Skipped (already linked): ${skipped}`)
  console.log(`Errors: ${errors}`)

  // 4. Show final state
  console.log('\n\n=== Final State ===')
  const { data: finalFormulas } = await supabase
    .from('icount_event_formulas')
    .select('id, name, game_type, min_participants, max_participants, price_per_person, product_id')
    .order('branch_id')

  finalFormulas?.forEach(f => {
    const code = `event_${f.game_type.toLowerCase()}_${f.min_participants}_${f.max_participants}`
    console.log(`${f.name}: ${code} -> product_id: ${f.product_id || 'NOT LINKED'}`)
  })

  console.log('\n\nNote: Products need to be synced to iCount separately.')
  console.log('Run: POST /api/icount-products/sync to sync all products to iCount.')
}

main().catch(console.error)
