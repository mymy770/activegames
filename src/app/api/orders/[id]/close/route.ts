/**
 * API Route pour clôturer une commande
 * POST: Clôturer la commande (annuler l'offre iCount + créer invrec du montant CB prélevé)
 */

import { NextRequest, NextResponse } from 'next/server'
import { createServiceRoleClient } from '@/lib/supabase/service-role'
import { verifyApiPermission } from '@/lib/permissions'
import { logOrderAction, getClientIpFromHeaders } from '@/lib/activity-logger'
import { getPaymentProvider } from '@/lib/payment-provider'
import type { UserRole } from '@/lib/supabase/types'

interface Payment {
  id: string
  amount: number
  payment_method: 'card' | 'cash' | 'transfer' | 'check'
  payment_type: string
  created_at: string
  icount_confirmation_code?: string
  cc_last4?: string
}

/**
 * POST /api/orders/[id]/close
 * Clôturer une commande : annuler l'offre iCount et créer une facture+reçu du montant prélevé
 */
export async function POST(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { success, user, errorResponse } = await verifyApiPermission('orders', 'edit')
    if (!success || !user) {
      return errorResponse
    }

    const { id } = await params
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const supabase = createServiceRoleClient() as any
    const ipAddress = getClientIpFromHeaders(request.headers)

    // Récupérer la commande avec les paiements et le booking
    const { data: order, error: orderError } = await supabase
      .from('orders')
      .select(`
        *,
        payments(*),
        booking:bookings(
          id,
          reference_code,
          game_type,
          icount_offer_id
        )
      `)
      .eq('id', id)
      .single()

    if (orderError || !order) {
      return NextResponse.json(
        { success: false, error: 'Order not found' },
        { status: 404 }
      )
    }

    // Vérifier que la commande n'est pas déjà clôturée ou annulée
    if (order.status === 'closed') {
      return NextResponse.json(
        { success: false, error: 'Order already closed' },
        { status: 400 }
      )
    }

    if (order.status === 'cancelled') {
      return NextResponse.json(
        { success: false, error: 'Cannot close a cancelled order' },
        { status: 400 }
      )
    }

    // Vérifier l'accès à la branche
    if (user.role !== 'super_admin' && order.branch_id) {
      if (!user.branchIds.includes(order.branch_id)) {
        return NextResponse.json(
          { success: false, error: 'Branch access denied' },
          { status: 403 }
        )
      }
    }

    // Calculer le total des paiements CB prélevés
    const payments: Payment[] = order.payments || []
    const cardPayments = payments.filter((p: Payment) => p.payment_method === 'card')
    const totalCardAmount = cardPayments.reduce((sum: number, p: Payment) => sum + (p.amount || 0), 0)

    // Récupérer le provider de paiement pour iCount
    const provider = await getPaymentProvider(order.branch_id)

    let icountInvrecId: number | undefined
    let icountInvrecUrl: string | undefined

    // Si on a prélevé de l'argent par CB, créer une facture+reçu
    if (totalCardAmount > 0 && provider) {
      // Déterminer le type de jeu pour la description
      const gameType = order.booking?.game_type || 'LASER'
      const gameDescription = gameType === 'ACTIVE'
        ? 'Jeux Active Games'
        : 'Jeux Laser City'

      // Construire la description avec les détails des paiements
      const paymentDetails = cardPayments.map((p: Payment) => {
        const date = new Date(p.created_at).toLocaleDateString('he-IL')
        const confirmCode = p.icount_confirmation_code ? ` (${p.icount_confirmation_code})` : ''
        const last4 = p.cc_last4 ? ` ****${p.cc_last4}` : ''
        return `${date}: ₪${p.amount}${last4}${confirmCode}`
      }).join('\n')

      const hwcContent = `פירוט תשלומים בכרטיס אשראי:\n${paymentDetails}`

      // Créer la facture+reçu dans iCount
      const invrecResult = await provider.documents.createInvoiceReceipt({
        custom_client_id: order.contact_id,
        client_name: `${order.customer_first_name} ${order.customer_last_name || ''}`.trim(),
        email: order.customer_email,
        items: [{
          description: gameDescription,
          quantity: 1,
          unitprice_incvat: totalCardAmount,
        }],
        sanity_string: `close-${id}`.slice(0, 30),
        doc_title: `חשבונית ${order.request_reference}`,
        hwc: hwcContent,
        doc_lang: 'he',
      })

      if (invrecResult.success && invrecResult.data) {
        icountInvrecId = invrecResult.data.docnum
        icountInvrecUrl = invrecResult.data.doc_url
        console.log('[CLOSE ORDER] InvRec created:', icountInvrecId)
      } else {
        console.error('[CLOSE ORDER] Failed to create invrec:', invrecResult.error)
        // On continue quand même - la clôture est plus importante que le document iCount
      }
    }

    // Annuler l'offre iCount si elle existe
    const offerId = order.booking?.icount_offer_id
    if (offerId && provider) {
      try {
        const cancelResult = await provider.documents.cancelDocument('offer', offerId, 'Commande clôturée')
        if (cancelResult.success) {
          console.log('[CLOSE ORDER] Offer cancelled:', offerId)
        } else {
          console.error('[CLOSE ORDER] Failed to cancel offer:', cancelResult.error)
        }
      } catch (cancelError) {
        console.error('[CLOSE ORDER] Exception cancelling offer:', cancelError)
      }
    }

    // Mettre à jour la commande
    const updateData: Record<string, unknown> = {
      status: 'closed',
      closed_at: new Date().toISOString(),
      closed_by: user.id,
    }

    if (icountInvrecId) {
      updateData.icount_invrec_id = icountInvrecId
      updateData.icount_invrec_url = icountInvrecUrl
    }

    await supabase
      .from('orders')
      .update(updateData)
      .eq('id', id)

    // Logger l'action
    await logOrderAction({
      userId: user.id,
      userRole: user.role as UserRole,
      userName: `${user.profile.first_name} ${user.profile.last_name}`,
      action: 'updated',
      orderId: id,
      orderRef: order.request_reference,
      branchId: order.branch_id,
      details: {
        orderClosed: true,
        totalCardAmount,
        icountInvrecId,
        offerCancelled: !!offerId,
      },
      ipAddress,
    })

    return NextResponse.json({
      success: true,
      message: 'Order closed successfully',
      data: {
        status: 'closed',
        totalCardAmount,
        icountInvrecId,
        icountInvrecUrl,
      },
    })

  } catch (error) {
    console.error('Error closing order:', error)
    return NextResponse.json(
      { success: false, error: 'Internal server error' },
      { status: 500 }
    )
  }
}
