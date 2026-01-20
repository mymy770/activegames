/**
 * API Route: /api/orders/[id]/resend-email
 *
 * POST: Renvoyer l'email de confirmation pour une commande
 */

import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { verifyApiPermission } from '@/lib/permissions'
import { sendBookingConfirmationEmail } from '@/lib/email-sender'
import type { Order, Booking, Branch } from '@/lib/supabase/types'

export async function POST(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const permCheck = await verifyApiPermission('orders', 'edit')
  if (!permCheck.success) {
    return permCheck.errorResponse
  }

  const user = permCheck.user!
  const { id: orderId } = await params
  const supabase = await createClient()

  // Récupérer la commande avec la réservation et la branche
  const { data: order, error: orderError } = await supabase
    .from('orders')
    .select(`
      *,
      booking:bookings(*),
      branch:branches(*)
    `)
    .eq('id', orderId)
    .single<Order & { booking: Booking | null; branch: Branch | null }>()

  if (orderError || !order) {
    return NextResponse.json(
      { success: false, error: 'Order not found' },
      { status: 404 }
    )
  }

  // Vérifier l'accès à la branche
  if (user.role !== 'super_admin' && !user.branchIds.includes(order.branch_id!)) {
    return NextResponse.json(
      { success: false, error: 'Access denied' },
      { status: 403 }
    )
  }

  // Vérifier que la commande a un email
  if (!order.customer_email) {
    return NextResponse.json(
      { success: false, error: 'No email address for this order' },
      { status: 400 }
    )
  }

  // Vérifier que la commande a une réservation associée
  if (!order.booking) {
    return NextResponse.json(
      { success: false, error: 'No booking associated with this order' },
      { status: 400 }
    )
  }

  // Vérifier que la commande n'est pas annulée
  if (order.status === 'cancelled') {
    return NextResponse.json(
      { success: false, error: 'Cannot send email for cancelled order' },
      { status: 400 }
    )
  }

  try {
    // Préparer les données du booking pour l'envoi
    const booking = order.booking as Booking
    const branch = order.branch as Branch

    // Récupérer la langue préférée du contact si disponible
    let contactLocale: 'he' | 'fr' | 'en' = 'he'
    if (order.contact_id) {
      const { data: contactData } = await supabase
        .from('contacts')
        .select('preferred_locale')
        .eq('id', order.contact_id)
        .single<{ preferred_locale: string | null }>()
      if (contactData?.preferred_locale) {
        contactLocale = contactData.preferred_locale as 'he' | 'fr' | 'en'
      }
    }

    // Envoyer l'email avec le cgvToken si c'est une commande admin
    const result = await sendBookingConfirmationEmail({
      booking,
      branch,
      triggeredBy: user.id,
      locale: contactLocale,
      cgvToken: order.source === 'admin_agenda' ? order.cgv_token : undefined,
    })

    if (!result.success) {
      return NextResponse.json(
        { success: false, error: result.error || 'Failed to send email' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      message: 'Email sent successfully',
      emailLogId: result.emailLogId,
    })
  } catch (error) {
    console.error('Error sending confirmation email:', error)
    return NextResponse.json(
      { success: false, error: 'Internal server error' },
      { status: 500 }
    )
  }
}
