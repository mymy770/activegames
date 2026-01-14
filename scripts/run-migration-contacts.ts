/**
 * Script pour exécuter la migration SQL des tables contacts
 * Usage: npx tsx scripts/run-migration-contacts.ts
 */

import { createClient } from '@supabase/supabase-js'
import { readFileSync } from 'fs'
import { join } from 'path'

async function runMigration() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
  const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

  if (!supabaseUrl || !supabaseServiceKey) {
    console.error('❌ Erreur: Variables d\'environnement manquantes')
    console.error('   NEXT_PUBLIC_SUPABASE_URL:', supabaseUrl ? '✅' : '❌')
    console.error('   SUPABASE_SERVICE_ROLE_KEY ou NEXT_PUBLIC_SUPABASE_ANON_KEY:', supabaseServiceKey ? '✅' : '❌')
    console.error('\n   Assurez-vous d\'avoir ces variables dans votre .env.local')
    process.exit(1)
  }

  // Créer un client Supabase avec les droits admin
  const supabase = createClient(supabaseUrl, supabaseServiceKey)

  // Lire le fichier SQL
  const migrationPath = join(process.cwd(), 'supabase', 'migrations', '001_create_contacts_tables.sql')
  let sqlContent: string

  try {
    sqlContent = readFileSync(migrationPath, 'utf-8')
    console.log('✅ Fichier SQL chargé:', migrationPath)
  } catch (error) {
    console.error('❌ Erreur: Impossible de lire le fichier SQL')
    console.error('   Chemin:', migrationPath)
    console.error('   Erreur:', error)
    process.exit(1)
  }

  // Diviser le SQL en requêtes individuelles (séparées par ;)
  // On doit être prudent car certaines requêtes peuvent contenir des ; dans les strings
  // Pour simplifier, on exécute tout d'un coup (Supabase le gère)
  const statements = sqlContent
    .split(';')
    .map(s => s.trim())
    .filter(s => s.length > 0 && !s.startsWith('--'))

  console.log(`\n📋 ${statements.length} requêtes SQL détectées`)
  console.log('🚀 Exécution de la migration...\n')

  try {
    // Exécuter chaque requête
    for (let i = 0; i < statements.length; i++) {
      const statement = statements[i]
      
      // Ignorer les commentaires et les lignes vides
      if (statement.startsWith('--') || statement.length === 0) {
        continue
      }

      // Exécuter via RPC ou directement
      // Note: Supabase client ne supporte pas directement l'exécution SQL arbitraire
      // Il faut utiliser l'API REST ou le service admin
      console.log(`⏳ Exécution requête ${i + 1}/${statements.length}...`)
      
      // Pour l'instant, on va utiliser une approche différente :
      // Créer un endpoint RPC dans Supabase ou utiliser directement l'API REST
      // Mais la meilleure approche est d'utiliser le SQL Editor de Supabase
      
      // Pour l'instant, on affiche le SQL et on demande à l'utilisateur de l'exécuter
      console.log('\n⚠️  Note importante:')
      console.log('   Le client Supabase ne permet pas d\'exécuter du SQL arbitraire directement.')
      console.log('   Vous devez exécuter cette migration via:')
      console.log('   1. Le SQL Editor dans l\'interface Supabase (recommandé)')
      console.log('   2. Ou via Supabase CLI si installé: supabase db push')
      console.log('\n   Le fichier SQL se trouve ici:')
      console.log(`   ${migrationPath}\n`)
      
      break // On sort après la première itération
    }

    // Alternative: On peut essayer d'exécuter via l'API REST de Supabase
    // mais cela nécessite des permissions spéciales
    console.log('📝 Pour exécuter la migration:')
    console.log('   1. Ouvrez https://supabase.com/dashboard')
    console.log('   2. Allez dans SQL Editor')
    console.log('   3. Copiez-collez le contenu du fichier:')
    console.log(`      ${migrationPath}`)
    console.log('   4. Exécutez le SQL\n')

    // On peut aussi essayer via fetch si SUPABASE_SERVICE_ROLE_KEY est disponible
    if (process.env.SUPABASE_SERVICE_ROLE_KEY) {
      console.log('💡 Tentative d\'exécution via API REST...')
      
      try {
        // Supabase ne permet pas d'exécuter du SQL arbitraire via l'API REST standard
        // Il faut utiliser le SQL Editor ou Supabase CLI
        console.log('   ⚠️  L\'exécution automatique nécessite Supabase CLI ou le SQL Editor')
      } catch (error) {
        console.error('   ❌ Erreur:', error)
      }
    }

  } catch (error) {
    console.error('❌ Erreur lors de l\'exécution:', error)
    process.exit(1)
  }
}

// Exécuter
runMigration().catch(error => {
  console.error('❌ Erreur fatale:', error)
  process.exit(1)
})
