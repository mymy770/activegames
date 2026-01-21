/**
 * API Route pour clôturer une commande
 * POST: Clôturer la commande et créer une facture+reçu du montant CB prélevé
 *
 * Workflow simplifié:
 * - Pas de devis iCount à annuler (plus de création de devis)
 * - Création d'une facture+reçu simple avec le total des paiements CB
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
  cc_type?: string
  check_number?: string
  check_bank?: string
  check_date?: string
  transfer_reference?: string
}

/**
 * POST /api/orders/[id]/close
 * Clôturer une commande : créer une facture+reçu du montant prélevé par CB
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
    console.log('[CLOSE ORDER API] Received request for orderId:', id)

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
          type
        )
      `)
      .eq('id', id)
      .single()

    if (orderError || !order) {
      console.log('[CLOSE ORDER API] Order not found. Error:', orderError, 'ID was:', id)
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

    // Calculer les totaux par méthode de paiement
    const payments: Payment[] = order.payments || []
    const cardPayments = payments.filter((p: Payment) => p.payment_method === 'card')
    const cashPayments = payments.filter((p: Payment) => p.payment_method === 'cash')
    const totalCardAmount = cardPayments.reduce((sum: number, p: Payment) => sum + (p.amount || 0), 0)
    const totalCashAmount = cashPayments.reduce((sum: number, p: Payment) => sum + (p.amount || 0), 0)
    const totalPaidAmount = totalCardAmount + totalCashAmount

    // Récupérer le provider de paiement pour iCount
    const provider = await getPaymentProvider(order.branch_id)

    let icountInvrecId: number | undefined
    let icountInvrecUrl: string | undefined

    // Si on a des paiements, créer une facture+reçu
    if (totalPaidAmount > 0 && provider) {
      // Déterminer le type de jeu pour la description
      const bookingType = order.booking?.type || order.order_type || 'GAME'
      let gameDescription: string

      if (bookingType === 'EVENT') {
        gameDescription = 'אירוע פרטי - Active Games & Laser City'
      } else {
        // Pour les GAME, on peut avoir LASER, ACTIVE ou les deux
        gameDescription = 'משחקים - Active Games & Laser City'
      }

      // Préparer les paramètres de la facture+reçu
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      const invrecParams: any = {
        custom_client_id: order.contact_id,
        client_name: `${order.customer_first_name} ${order.customer_last_name || ''}`.trim(),
        email: order.customer_email,
        phone: order.customer_phone,
        items: [{
          description: gameDescription,
          quantity: 1,
          unitprice_incvat: totalPaidAmount,
        }],
        sanity_string: `close-${id}`.slice(0, 30),
        doc_title: `חשבונית ${order.request_reference}`,
        doc_lang: 'he',
      }

      // Ajouter les paiements CB avec l'objet cc natif iCount
      // On prend le dernier paiement CB comme référence pour les détails
      if (totalCardAmount > 0 && cardPayments.length > 0) {
        const lastCardPayment = cardPayments[cardPayments.length - 1]
        invrecParams.cc = {
          sum: totalCardAmount,
          card_type: lastCardPayment.cc_type || 'VISA',
          card_number: lastCardPayment.cc_last4 || '0000',
          confirmation_code: lastCardPayment.icount_confirmation_code || '',
          num_of_payments: 1,
        }

        // Si plusieurs paiements CB, ajouter les détails en commentaire
        if (cardPayments.length > 1) {
          const paymentDetails = cardPayments.map((p: Payment) => {
            const date = new Date(p.created_at).toLocaleDateString('he-IL')
            const confirmCode = p.icount_confirmation_code ? ` (${p.icount_confirmation_code})` : ''
            const last4 = p.cc_last4 ? ` ****${p.cc_last4}` : ''
            return `${date}: ₪${p.amount}${last4}${confirmCode}`
          }).join('\n')
          invrecParams.hwc = `פירוט תשלומי אשראי:\n${paymentDetails}`
        }
      }

      // Ajouter les paiements en espèces avec l'objet cash natif iCount
      if (totalCashAmount > 0) {
        invrecParams.cash = {
          sum: totalCashAmount,
        }
      }

      // Créer la facture+reçu dans iCount
      // Le client sera créé/mis à jour automatiquement par iCount avec custom_client_id
      const invrecResult = await provider.documents.createInvoiceReceipt(invrecParams)

      if (invrecResult.success && invrecResult.data) {
        icountInvrecId = invrecResult.data.docnum
        icountInvrecUrl = invrecResult.data.doc_url
        console.log('[CLOSE ORDER] InvRec created:', icountInvrecId)
      } else {
        console.error('[CLOSE ORDER] Failed to create invrec:', invrecResult.error)
        // On continue quand même - la clôture est plus importante que le document iCount
      }
    }

    // Mettre à jour la commande
    // Note: Si les colonnes closed_at, closed_by, icount_invrec_id n'existent pas,
    // on fait juste l'update du status qui est le minimum requis
    const updateData: Record<string, unknown> = {
      status: 'closed',
    }

    // Essayer d'ajouter les colonnes optionnelles (peuvent ne pas exister si migration non appliquée)
    try {
      updateData.closed_at = new Date().toISOString()
      updateData.closed_by = user.id
      if (icountInvrecId) {
        updateData.icount_invrec_id = icountInvrecId
        updateData.icount_invrec_url = icountInvrecUrl
      }
    } catch {
      // Colonnes peuvent ne pas exister
    }

    const { error: updateError } = await supabase
      .from('orders')
      .update(updateData)
      .eq('id', id)

    if (updateError) {
      console.error('[CLOSE ORDER] Failed to update order status:', updateError)
      // Si l'erreur est liée aux colonnes manquantes, essayer avec juste le status
      if (updateError.message?.includes('column')) {
        const { error: fallbackError } = await supabase
          .from('orders')
          .update({ status: 'closed' })
          .eq('id', id)

        if (fallbackError) {
          console.error('[CLOSE ORDER] Fallback update also failed:', fallbackError)
          return NextResponse.json(
            { success: false, error: 'Failed to update order status' },
            { status: 500 }
          )
        }
      } else {
        return NextResponse.json(
          { success: false, error: 'Failed to update order status' },
          { status: 500 }
        )
      }
    }

    console.log('[CLOSE ORDER] Order status updated to closed for:', id)

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
        totalCashAmount,
        totalPaidAmount,
        icountInvrecId,
      },
      ipAddress,
    })

    return NextResponse.json({
      success: true,
      message: 'Order closed successfully',
      data: {
        status: 'closed',
        totalCardAmount,
        totalCashAmount,
        totalPaidAmount,
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
