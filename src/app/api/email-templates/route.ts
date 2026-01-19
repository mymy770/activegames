/**
 * API Route: /api/email-templates
 *
 * GET: Liste des templates d'emails
 * POST: Créer un nouveau template
 */

import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { verifyApiPermission } from '@/lib/permissions'
import type { EmailTemplate } from '@/lib/supabase/types'

// GET: Récupérer la liste des templates
export async function GET(request: NextRequest) {
  // Seuls les super_admin peuvent gérer les templates (via settings)
  const permCheck = await verifyApiPermission('settings', 'view')
  if (!permCheck.success) {
    return permCheck.errorResponse
  }

  const supabase = await createClient()
  const searchParams = request.nextUrl.searchParams

  const isActive = searchParams.get('is_active')
  const branchId = searchParams.get('branch_id')

  let query = supabase
    .from('email_templates')
    .select('*')
    .order('name', { ascending: true })

  if (isActive !== null) {
    query = query.eq('is_active', isActive === 'true')
  }

  if (branchId) {
    // Templates globaux (branch_id = null) + templates de la branche spécifique
    query = query.or(`branch_id.is.null,branch_id.eq.${branchId}`)
  }

  const { data: templates, error } = await query

  if (error) {
    console.error('Error fetching email templates:', error)
    return NextResponse.json(
      { success: false, error: 'Failed to fetch templates' },
      { status: 500 }
    )
  }

  return NextResponse.json({
    success: true,
    data: templates || []
  })
}

// POST: Créer un nouveau template
export async function POST(request: NextRequest) {
  const permCheck = await verifyApiPermission('settings', 'create')
  if (!permCheck.success) {
    return permCheck.errorResponse
  }

  const user = permCheck.user!
  const supabase = await createClient()

  try {
    const body = await request.json()
    const {
      code,
      name,
      description,
      subject_template,
      body_template,
      is_active = true,
      branch_id = null,
      available_variables = []
    } = body

    // Validation
    if (!code || !name || !subject_template || !body_template) {
      return NextResponse.json(
        { success: false, error: 'Missing required fields: code, name, subject_template, body_template' },
        { status: 400 }
      )
    }

    // Vérifier que le code n'existe pas déjà
    const { data: existing } = await supabase
      .from('email_templates')
      .select('id')
      .eq('code', code)
      .single()

    if (existing) {
      return NextResponse.json(
        { success: false, error: 'A template with this code already exists' },
        { status: 409 }
      )
    }

    // Créer le template
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const { data: template, error } = await (supabase as any)
      .from('email_templates')
      .insert({
        code,
        name,
        description: description || null,
        subject_template,
        body_template,
        is_active,
        is_system: false, // Les templates créés manuellement ne sont jamais système
        branch_id,
        available_variables,
        created_by: user.id
      })
      .select()
      .single()

    if (error) {
      console.error('Error creating email template:', error)
      return NextResponse.json(
        { success: false, error: 'Failed to create template' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      data: template
    }, { status: 201 })

  } catch (error) {
    console.error('Error in POST /api/email-templates:', error)
    return NextResponse.json(
      { success: false, error: 'Internal server error' },
      { status: 500 }
    )
  }
}
