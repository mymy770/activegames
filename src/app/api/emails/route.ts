/**
 * API Route: /api/emails
 *
 * GET: Liste des emails envoyés (avec filtres et pagination)
 * POST: Envoyer un nouvel email manuellement
 */

import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { verifyApiPermission } from '@/lib/permissions'
import { sendBookingConfirmationEmail } from '@/lib/email-sender'
import type { EmailLog, Branch, Booking } from '@/lib/supabase/types'

// GET: Récupérer la liste des emails
export async function GET(request: NextRequest) {
  // Vérifier les permissions - on utilise 'orders' car les emails sont liés aux commandes
  const permCheck = await verifyApiPermission('orders', 'view')
  if (!permCheck.success) {
    return permCheck.errorResponse
  }

  const user = permCheck.user!
  const supabase = await createClient()
  const searchParams = request.nextUrl.searchParams

  // Paramètres de pagination
  const page = parseInt(searchParams.get('page') || '1')
  const limit = parseInt(searchParams.get('limit') || '20')
  const offset = (page - 1) * limit

  // Paramètres de filtre
  const status = searchParams.get('status')
  const branchId = searchParams.get('branch_id')
  const entityType = searchParams.get('entity_type')
  const search = searchParams.get('search')
  const dateFrom = searchParams.get('date_from')
  const dateTo = searchParams.get('date_to')

  // Construire la requête
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  let query = (supabase as any)
    .from('email_logs')
    .select('*', { count: 'exact' })
    .order('created_at', { ascending: false })

  // Filtrer par branches autorisées si pas super_admin
  if (user.role !== 'super_admin') {
    if (user.branchIds.length === 0) {
      return NextResponse.json({
        success: true,
        data: [],
        pagination: { total: 0, page, limit, totalPages: 0 }
      })
    }
    query = query.in('branch_id', user.branchIds)
  }

  // Appliquer les filtres
  if (status) {
    query = query.eq('status', status)
  }

  if (branchId) {
    query = query.eq('branch_id', branchId)
  }

  if (entityType) {
    query = query.eq('entity_type', entityType)
  }

  if (dateFrom) {
    query = query.gte('created_at', dateFrom)
  }

  if (dateTo) {
    query = query.lte('created_at', dateTo)
  }

  if (search) {
    query = query.or(`recipient_email.ilike.%${search}%,recipient_name.ilike.%${search}%,subject.ilike.%${search}%`)
  }

  // Pagination
  query = query.range(offset, offset + limit - 1)

  const { data: emails, error, count } = await query

  if (error) {
    console.error('Error fetching emails:', error)
    return NextResponse.json(
      { success: false, error: 'Failed to fetch emails' },
      { status: 500 }
    )
  }

  return NextResponse.json({
    success: true,
    data: emails || [],
    pagination: {
      total: count || 0,
      page,
      limit,
      totalPages: Math.ceil((count || 0) / limit)
    }
  })
}

// POST: Envoyer un email manuellement (depuis l'admin)
export async function POST(request: NextRequest) {
  // Vérifier les permissions
  const permCheck = await verifyApiPermission('orders', 'create')
  if (!permCheck.success) {
    return permCheck.errorResponse
  }

  const user = permCheck.user!
  const supabase = await createClient()

  try {
    const body = await request.json()
    const { action, bookingId, emailLogId } = body

    // Action: renvoyer un email
    if (action === 'resend' && emailLogId) {
      const { resendEmail } = await import('@/lib/email-sender')
      const result = await resendEmail(emailLogId, user.id)

      if (result.success) {
        return NextResponse.json({
          success: true,
          message: 'Email resent successfully',
          emailLogId: result.newEmailLogId
        })
      } else {
        return NextResponse.json(
          { success: false, error: result.error || 'Failed to resend email' },
          { status: 500 }
        )
      }
    }

    // Action: envoyer confirmation pour un booking
    if (action === 'send_confirmation' && bookingId) {
      // Récupérer le booking avec sa branche
      const { data: booking, error: bookingError } = await supabase
        .from('bookings')
        .select('*')
        .eq('id', bookingId)
        .single<Booking>()

      if (bookingError || !booking) {
        return NextResponse.json(
          { success: false, error: 'Booking not found' },
          { status: 404 }
        )
      }

      // Vérifier l'accès à la branche
      if (user.role !== 'super_admin' && booking.branch_id && !user.branchIds.includes(booking.branch_id)) {
        return NextResponse.json(
          { success: false, error: 'Access denied to this branch' },
          { status: 403 }
        )
      }

      // Récupérer la branche
      const { data: branch, error: branchError } = await supabase
        .from('branches')
        .select('*')
        .eq('id', booking.branch_id!)
        .single<Branch>()

      if (branchError || !branch) {
        return NextResponse.json(
          { success: false, error: 'Branch not found' },
          { status: 404 }
        )
      }

      // Récupérer la langue préférée du contact si disponible
      let contactLocale: 'he' | 'fr' | 'en' = 'he'
      if (booking.primary_contact_id) {
        const { data: contactData } = await supabase
          .from('contacts')
          .select('preferred_locale')
          .eq('id', booking.primary_contact_id)
          .single<{ preferred_locale: string | null }>()
        if (contactData?.preferred_locale) {
          contactLocale = contactData.preferred_locale as 'he' | 'fr' | 'en'
        }
      }

      // Envoyer l'email de confirmation
      const result = await sendBookingConfirmationEmail({
        booking,
        branch,
        triggeredBy: user.id,
        locale: contactLocale
      })

      if (result.success) {
        return NextResponse.json({
          success: true,
          message: 'Confirmation email sent successfully',
          emailLogId: result.emailLogId
        })
      } else {
        return NextResponse.json(
          { success: false, error: result.error || 'Failed to send email' },
          { status: 500 }
        )
      }
    }

    return NextResponse.json(
      { success: false, error: 'Invalid action' },
      { status: 400 }
    )

  } catch (error) {
    console.error('Error in POST /api/emails:', error)
    return NextResponse.json(
      { success: false, error: 'Internal server error' },
      { status: 500 }
    )
  }
}
