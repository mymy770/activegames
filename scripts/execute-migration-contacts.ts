/**
 * Script pour exécuter la migration SQL via l'API REST de Supabase
 * 
 * ⚠️ IMPORTANT: Nécessite SUPABASE_SERVICE_ROLE_KEY (pas ANON_KEY)
 * Cette clé a les permissions pour exécuter du SQL
 * 
 * Usage: 
 *   SUPABASE_SERVICE_ROLE_KEY=your_key npx tsx scripts/execute-migration-contacts.ts
 */

import { readFileSync } from 'fs'
import { join } from 'path'

async function executeMigration() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
  const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

  if (!supabaseUrl) {
    console.error('❌ Erreur: NEXT_PUBLIC_SUPABASE_URL manquante')
    process.exit(1)
  }

  if (!supabaseServiceKey) {
    console.error('❌ Erreur: SUPABASE_SERVICE_ROLE_KEY manquante')
    console.error('\n   Cette clé est nécessaire pour exécuter du SQL.')
    console.error('   Vous pouvez la trouver dans:')
    console.error('   https://supabase.com/dashboard/project/_/settings/api')
    console.error('   (section "service_role" key - gardez-la SECRÈTE!)\n')
    console.error('   Usage:')
    console.error('   SUPABASE_SERVICE_ROLE_KEY=your_key npx tsx scripts/execute-migration-contacts.ts\n')
    process.exit(1)
  }

  // Lire le fichier SQL
  const migrationPath = join(process.cwd(), 'supabase', 'migrations', '001_create_contacts_tables.sql')
  let sqlContent: string

  try {
    sqlContent = readFileSync(migrationPath, 'utf-8')
    console.log('✅ Fichier SQL chargé\n')
  } catch (error) {
    console.error('❌ Erreur: Impossible de lire le fichier SQL:', migrationPath)
    process.exit(1)
  }

  // Supabase Management API pour exécuter du SQL
  // Endpoint: POST /rest/v1/rpc/exec_sql (si la fonction existe)
  // OU utiliser l'API PostgREST directement

  console.log('🚀 Tentative d\'exécution via Supabase Management API...\n')

  try {
    // Méthode 1: Utiliser l'endpoint /rest/v1/rpc si une fonction RPC existe
    // Mais cette fonction n'existe pas par défaut dans Supabase
    
    // Méthode 2: Utiliser l'API Management (nécessite un token spécial)
    // https://supabase.com/docs/reference/api/introduction
    
    // La meilleure méthode: Utiliser Supabase CLI ou le SQL Editor
    // Mais on peut essayer via fetch avec le service_role_key
    
    console.log('⚠️  Exécution automatique non disponible via cette méthode.')
    console.log('\n📋 OPTIONS DISPONIBLES:\n')
    
    console.log('1️⃣  VIA SQL EDITOR (Recommandé - le plus simple):')
    console.log('   • Ouvrez https://supabase.com/dashboard')
    console.log('   • Sélectionnez votre projet')
    console.log('   • Allez dans "SQL Editor" (menu de gauche)')
    console.log('   • Cliquez "New query"')
    console.log('   • Copiez-collez le contenu du fichier:')
    console.log(`      ${migrationPath}`)
    console.log('   • Cliquez "Run" (ou Cmd/Ctrl + Enter)\n')

    console.log('2️⃣  VIA SUPABASE CLI (si installé):')
    console.log('   • npm install -g supabase')
    console.log('   • supabase link --project-ref your-project-ref')
    console.log(`   • supabase db push --file ${migrationPath}\n`)

    console.log('3️⃣  VIA SCRIPT NODE.JS AVEC PERMISSIONS ADMIN:')
    console.log('   • Les clients Supabase standard ne permettent pas d\'exécuter du SQL arbitraire')
    console.log('   • Il faut utiliser Supabase CLI ou l\'interface web\n')

    console.log('📄 CONTENU DU SQL À EXÉCUTER:')
    console.log('─'.repeat(60))
    console.log(sqlContent)
    console.log('─'.repeat(60))
    console.log()

  } catch (error) {
    console.error('❌ Erreur:', error)
    process.exit(1)
  }
}

executeMigration().catch(error => {
  console.error('❌ Erreur fatale:', error)
  process.exit(1)
})
