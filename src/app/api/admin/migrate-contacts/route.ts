import { NextRequest, NextResponse } from 'next/server'
import { readFileSync } from 'fs'
import { join } from 'path'

/**
 * POST /api/admin/migrate-contacts
 * Exécute la migration SQL pour créer les tables contacts
 * ⚠️ ROUTE ADMIN UNIQUEMENT - À protéger en production
 */
export async function POST(request: NextRequest) {
  try {
    // Vérifier que c'est bien une requête admin (optionnel, à renforcer en prod)
    // Pour l'instant, on autorise si la clé est fournie
    const authHeader = request.headers.get('authorization')
    const expectedToken = process.env.ADMIN_MIGRATION_TOKEN || 'dev-admin-secret-token-12345'

    if (authHeader !== `Bearer ${expectedToken}`) {
      return NextResponse.json(
        { success: false, error: 'Unauthorized' },
        { status: 401 }
      )
    }

    // Lire le fichier SQL
    const migrationPath = join(process.cwd(), 'supabase', 'migrations', '001_create_contacts_tables.sql')
    let sqlContent: string

    try {
      sqlContent = readFileSync(migrationPath, 'utf-8')
    } catch (error) {
      return NextResponse.json(
        { success: false, error: 'Migration file not found' },
        { status: 404 }
      )
    }

    // IMPORTANT: On ne peut pas exécuter du SQL arbitraire via Supabase Client
    // Il faut utiliser Supabase CLI ou le SQL Editor
    // Ce endpoint sert juste à retourner le SQL

    return NextResponse.json({
      success: true,
      message: 'Migration SQL ready',
      sql: sqlContent,
      instructions: [
        '1. Copiez le SQL ci-dessus',
        '2. Allez sur https://supabase.com/dashboard',
        '3. Ouvrez SQL Editor',
        '4. Collez et exécutez le SQL',
        'OU utilisez Supabase CLI: npx supabase db push (si configuré)',
      ],
    })
  } catch (error) {
    console.error('Error in migration endpoint:', error)
    return NextResponse.json(
      { success: false, error: 'Internal server error' },
      { status: 500 }
    )
  }
}
