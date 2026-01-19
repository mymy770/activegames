/**
 * API Route: /api/email-templates/[id]
 *
 * GET: Récupérer un template spécifique
 * PUT: Modifier un template
 * DELETE: Supprimer un template (sauf templates système)
 */

import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { verifyApiPermission } from '@/lib/permissions'
import type { EmailTemplate } from '@/lib/supabase/types'

// GET: Récupérer un template spécifique
export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const permCheck = await verifyApiPermission('settings', 'view')
  if (!permCheck.success) {
    return permCheck.errorResponse
  }

  const { id } = await params
  const supabase = await createClient()

  const { data: template, error } = await supabase
    .from('email_templates')
    .select('*')
    .eq('id', id)
    .single<EmailTemplate>()

  if (error || !template) {
    return NextResponse.json(
      { success: false, error: 'Template not found' },
      { status: 404 }
    )
  }

  return NextResponse.json({
    success: true,
    data: template
  })
}

// PUT: Modifier un template
export async function PUT(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const permCheck = await verifyApiPermission('settings', 'edit')
  if (!permCheck.success) {
    return permCheck.errorResponse
  }

  const { id } = await params
  const supabase = await createClient()

  // Vérifier que le template existe
  const { data: existing, error: fetchError } = await supabase
    .from('email_templates')
    .select('*')
    .eq('id', id)
    .single<EmailTemplate>()

  if (fetchError || !existing) {
    return NextResponse.json(
      { success: false, error: 'Template not found' },
      { status: 404 }
    )
  }

  try {
    const body = await request.json()
    const {
      name,
      description,
      subject_template,
      body_template,
      is_active,
      branch_id,
      available_variables
    } = body

    // Construire l'objet de mise à jour
    const updateData: Record<string, unknown> = {}

    if (name !== undefined) updateData.name = name
    if (description !== undefined) updateData.description = description
    if (subject_template !== undefined) updateData.subject_template = subject_template
    if (body_template !== undefined) updateData.body_template = body_template
    if (is_active !== undefined) updateData.is_active = is_active
    if (available_variables !== undefined) updateData.available_variables = available_variables

    // branch_id ne peut pas être modifié pour les templates système
    if (branch_id !== undefined && !existing.is_system) {
      updateData.branch_id = branch_id
    }

    // code ne peut pas être modifié
    // is_system ne peut pas être modifié

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const { data: template, error } = await (supabase as any)
      .from('email_templates')
      .update(updateData)
      .eq('id', id)
      .select()
      .single()

    if (error) {
      console.error('Error updating email template:', error)
      return NextResponse.json(
        { success: false, error: 'Failed to update template' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      data: template
    })

  } catch (error) {
    console.error('Error in PUT /api/email-templates/[id]:', error)
    return NextResponse.json(
      { success: false, error: 'Internal server error' },
      { status: 500 }
    )
  }
}

// DELETE: Supprimer un template
export async function DELETE(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const permCheck = await verifyApiPermission('settings', 'delete')
  if (!permCheck.success) {
    return permCheck.errorResponse
  }

  const { id } = await params
  const supabase = await createClient()

  // Vérifier que le template existe et n'est pas un template système
  const { data: existing, error: fetchError } = await supabase
    .from('email_templates')
    .select('is_system')
    .eq('id', id)
    .single<{ is_system: boolean }>()

  if (fetchError || !existing) {
    return NextResponse.json(
      { success: false, error: 'Template not found' },
      { status: 404 }
    )
  }

  if (existing.is_system) {
    return NextResponse.json(
      { success: false, error: 'Cannot delete system templates' },
      { status: 403 }
    )
  }

  // Supprimer
  const { error: deleteError } = await supabase
    .from('email_templates')
    .delete()
    .eq('id', id)

  if (deleteError) {
    console.error('Error deleting email template:', deleteError)
    return NextResponse.json(
      { success: false, error: 'Failed to delete template' },
      { status: 500 }
    )
  }

  return NextResponse.json({
    success: true,
    message: 'Template deleted'
  })
}
