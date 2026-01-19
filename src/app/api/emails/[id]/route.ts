/**
 * API Route: /api/emails/[id]
 *
 * GET: Récupérer un email spécifique
 * DELETE: Supprimer un email du log
 */

import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { verifyApiPermission } from '@/lib/permissions'

// GET: Récupérer un email spécifique
export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const permCheck = await verifyApiPermission('orders', 'view')
  if (!permCheck.success) {
    return permCheck.errorResponse
  }

  const user = permCheck.user!
  const { id } = await params
  const supabase = await createClient()

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const { data: email, error } = await (supabase as any)
    .from('email_logs')
    .select('*')
    .eq('id', id)
    .single()

  if (error || !email) {
    return NextResponse.json(
      { success: false, error: 'Email not found' },
      { status: 404 }
    )
  }

  // Vérifier l'accès à la branche
  if (user.role !== 'super_admin' && email.branch_id && !user.branchIds.includes(email.branch_id as string)) {
    return NextResponse.json(
      { success: false, error: 'Access denied' },
      { status: 403 }
    )
  }

  return NextResponse.json({
    success: true,
    data: email
  })
}

// DELETE: Supprimer un email du log
export async function DELETE(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const permCheck = await verifyApiPermission('orders', 'delete')
  if (!permCheck.success) {
    return permCheck.errorResponse
  }

  const user = permCheck.user!
  const { id } = await params
  const supabase = await createClient()

  // Vérifier que l'email existe et que l'utilisateur y a accès
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const { data: emailToDelete, error: fetchError } = await (supabase as any)
    .from('email_logs')
    .select('branch_id')
    .eq('id', id)
    .single()

  if (fetchError || !emailToDelete) {
    return NextResponse.json(
      { success: false, error: 'Email not found' },
      { status: 404 }
    )
  }

  // Vérifier l'accès à la branche
  if (user.role !== 'super_admin' && emailToDelete.branch_id && !user.branchIds.includes(emailToDelete.branch_id as string)) {
    return NextResponse.json(
      { success: false, error: 'Access denied' },
      { status: 403 }
    )
  }

  // Supprimer
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const { error: deleteError } = await (supabase as any)
    .from('email_logs')
    .delete()
    .eq('id', id)

  if (deleteError) {
    console.error('Error deleting email log:', deleteError)
    return NextResponse.json(
      { success: false, error: 'Failed to delete email' },
      { status: 500 }
    )
  }

  return NextResponse.json({
    success: true,
    message: 'Email log deleted'
  })
}
