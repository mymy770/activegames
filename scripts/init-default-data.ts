/**
 * Script pour initialiser les données par défaut dans la nouvelle base
 * Usage: npx tsx scripts/init-default-data.ts
 */

import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

async function initDefaultData() {
  if (!supabaseUrl || !supabaseServiceKey) {
    console.error('❌ Variables d\'environnement manquantes')
    console.error('   Chargez .env.local ou définissez:')
    console.error('   - NEXT_PUBLIC_SUPABASE_URL')
    console.error('   - SUPABASE_SERVICE_ROLE_KEY\n')
    process.exit(1)
  }

  console.log('🚀 Initialisation des données par défaut...\n')

  const supabase = createClient(supabaseUrl, supabaseServiceKey)

  try {
    // 1. Vérifier si des branches existent déjà
    const { data: existingBranches } = await supabase
      .from('branches')
      .select('id, name')
      .limit(1)

    if (existingBranches && existingBranches.length > 0) {
      console.log('⚠️  Des branches existent déjà dans la base')
      console.log('   Branches trouvées:', existingBranches.map(b => b.name).join(', '))
      console.log('\n   Pour réinitialiser, supprimez d\'abord les branches existantes.\n')
      process.exit(0)
    }

    console.log('📦 Création des branches...')

    // 2. Créer les branches par défaut
    const branches = [
      {
        slug: 'rishon-lezion',
        name: 'Rishon LeZion',
        name_en: 'Rishon LeZion',
        address: 'Aliyat HaNoar 1, Bar-On Center – Floor 5',
        phone: '03-5512277',
        phone_extension: '1',
        timezone: 'Asia/Jerusalem',
        is_active: true,
      },
      {
        slug: 'petah-tikva',
        name: 'Petah Tikva',
        name_en: 'Petah Tikva',
        address: 'Amal 37',
        phone: '03-5512277',
        phone_extension: '3',
        timezone: 'Asia/Jerusalem',
        is_active: true,
      },
    ]

    const { data: createdBranches, error: branchesError } = await supabase
      .from('branches')
      .insert(branches)
      .select()

    if (branchesError) {
      throw new Error(`Erreur création branches: ${branchesError.message}`)
    }

    console.log(`✅ ${createdBranches?.length || 0} branches créées`)

    if (!createdBranches || createdBranches.length === 0) {
      throw new Error('Aucune branche créée')
    }

    // 3. Créer les settings pour chaque branche
    console.log('\n📋 Création des paramètres par défaut...')

    const defaultSettings = {
      max_concurrent_players: 84,
      slot_duration_minutes: 15,
      game_duration_minutes: 60,
      event_total_duration_minutes: 120,
      event_game_duration_minutes: 60,
      event_buffer_before_minutes: 15,
      event_buffer_after_minutes: 15,
      event_min_participants: 1,
      game_price_per_person: 0,
      bracelet_price: 0,
      event_price_15_29: 0,
      event_price_30_plus: 0,
      opening_hours: {
        monday: { open: '10:00', close: '22:00' },
        tuesday: { open: '10:00', close: '22:00' },
        wednesday: { open: '10:00', close: '22:00' },
        thursday: { open: '10:00', close: '22:00' },
        friday: { open: '10:00', close: '22:00' },
        saturday: { open: '10:00', close: '22:00' },
        sunday: { open: '10:00', close: '22:00' },
      },
    }

    const settingsToInsert = createdBranches.map(branch => ({
      branch_id: branch.id,
      ...defaultSettings,
    }))

    const { error: settingsError } = await supabase
      .from('branch_settings')
      .insert(settingsToInsert)

    if (settingsError) {
      throw new Error(`Erreur création settings: ${settingsError.message}`)
    }

    console.log(`✅ Paramètres créés pour ${createdBranches.length} branches`)

    // 4. Créer les salles pour chaque branche
    console.log('\n🏠 Création des salles...')

    const rooms = [
      { slug: 'salle-1', name: 'Salle 1', name_en: 'Room 1', capacity: 20, sort_order: 1 },
      { slug: 'salle-2', name: 'Salle 2', name_en: 'Room 2', capacity: 30, sort_order: 2 },
      { slug: 'salle-3', name: 'Salle 3', name_en: 'Room 3', capacity: 40, sort_order: 3 },
      { slug: 'salle-4', name: 'Salle 4', name_en: 'Room 4', capacity: 50, sort_order: 4 },
    ]

    const roomsToInsert = createdBranches.flatMap(branch =>
      rooms.map(room => ({
        branch_id: branch.id,
        ...room,
        is_active: true,
      }))
    )

    const { data: createdRooms, error: roomsError } = await supabase
      .from('event_rooms')
      .insert(roomsToInsert)
      .select()

    if (roomsError) {
      throw new Error(`Erreur création salles: ${roomsError.message}`)
    }

    console.log(`✅ ${createdRooms?.length || 0} salles créées (${rooms.length} par branche)`)

    console.log('\n✅ Initialisation terminée avec succès !\n')
    console.log('📊 Résumé:')
    console.log(`   - Branches: ${createdBranches.length}`)
    console.log(`   - Paramètres: ${createdBranches.length}`)
    console.log(`   - Salles: ${createdRooms?.length || 0}\n`)
    console.log('🎉 Vous pouvez maintenant utiliser l\'application !\n')

  } catch (error: any) {
    console.error('\n❌ Erreur:', error.message)
    console.error(error)
    process.exit(1)
  }
}

initDefaultData()
