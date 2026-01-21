/**
 * API Route: /api/orders/[id]/send-invoice
 *
 * POST: Envoyer la facture iCount par email au client
 */

import { NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { verifyApiPermission } from '@/lib/permissions'
import { sendEmail } from '@/lib/email-sender'
import type { Order, Branch } from '@/lib/supabase/types'

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

  // Récupérer la commande avec la branche
  const { data: order, error: orderError } = await supabase
    .from('orders')
    .select(`
      *,
      branch:branches(*)
    `)
    .eq('id', orderId)
    .single<Order & { branch: Branch | null }>()

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
      { success: false, error: 'No email address for this order', messageKey: 'admin.invoice.errors.no_email' },
      { status: 400 }
    )
  }

  // Vérifier que la commande est fermée et a une facture
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const orderAny = order as any
  if (order.status !== 'closed') {
    return NextResponse.json(
      { success: false, error: 'Order must be closed to send invoice', messageKey: 'admin.invoice.errors.not_closed' },
      { status: 400 }
    )
  }

  if (!orderAny.icount_invrec_url) {
    return NextResponse.json(
      { success: false, error: 'No invoice available for this order', messageKey: 'admin.invoice.errors.no_invoice' },
      { status: 400 }
    )
  }

  try {
    const invoiceUrl = orderAny.icount_invrec_url as string
    const customerName = `${order.customer_first_name || ''} ${order.customer_last_name || ''}`.trim() || 'לקוח יקר'
    const orderRef = order.request_reference || ''
    const branchName = order.branch?.name || 'Active Games'
    const branchPhone = order.branch?.phone || ''
    const branchAddress = order.branch?.address || ''
    const currentYear = new Date().getFullYear()
    const baseUrl = process.env.NEXT_PUBLIC_APP_URL || 'https://activegames.co.il'
    const logoActivegamesUrl = `${baseUrl}/images/logo-activegames.png`
    const logoLasercityUrl = `${baseUrl}/images/logo_laser_city.png`

    // Récupérer la langue préférée du contact si disponible
    let locale: 'he' | 'fr' | 'en' = 'he'
    if (order.contact_id) {
      const { data: contactData } = await supabase
        .from('contacts')
        .select('preferred_locale')
        .eq('id', order.contact_id)
        .single<{ preferred_locale: string | null }>()
      if (contactData?.preferred_locale) {
        locale = contactData.preferred_locale as 'he' | 'fr' | 'en'
      }
    }

    // Construire l'email selon la langue avec le design Active Games
    let subject: string
    let htmlContent: string

    // Template de base avec le branding Active Games (couleurs: fond #1a1a2e, carte #252540, accent #00f0ff)
    const generateInvoiceEmail = (
      lang: 'he' | 'fr' | 'en',
      texts: {
        title: string
        greeting: string
        thankYou: string
        invoiceText: string
        viewInvoice: string
        questions: string
        regards: string
        footerThank: string
        footerRights: string
      }
    ) => {
      const isRTL = lang === 'he'
      return `<!DOCTYPE html>
<html lang="${lang}"${isRTL ? ' dir="rtl"' : ''}>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${texts.title}</title>
</head>
<body style="margin: 0; padding: 0; background-color: #1a1a2e; font-family: Segoe UI, Tahoma, Geneva, Verdana, sans-serif;${isRTL ? ' direction: rtl;' : ''}">
  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: #1a1a2e;">
    <tr>
      <td align="center" style="padding: 40px 20px;">
        <table role="presentation" width="600" cellspacing="0" cellpadding="0" style="background-color: #252540; border-radius: 16px; overflow: hidden; border: 2px solid rgba(0, 240, 255, 0.3); box-shadow: 0 0 30px rgba(0, 240, 255, 0.2);">

          <!-- Header with logos -->
          <tr>
            <td style="background: linear-gradient(135deg, #1a1a2e 0%, #252540 100%); padding: 30px; text-align: center; border-bottom: 1px solid rgba(0, 240, 255, 0.2);">
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
                <tr>
                  <td style="text-align: center;">
                    <img src="${logoActivegamesUrl}" alt="ActiveGames" style="max-height: 50px; margin: 0 15px;" />
                    <img src="${logoLasercityUrl}" alt="Laser City" style="max-height: 50px; margin: 0 15px;" />
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Main content -->
          <tr>
            <td style="padding: 40px 30px;">
              <!-- Invoice icon -->
              <div style="text-align: center; margin-bottom: 25px;">
                <div style="display: inline-block; background-color: rgba(0, 240, 255, 0.15); border-radius: 50%; width: 80px; height: 80px; line-height: 80px;">
                  <span style="font-size: 40px; color: #00f0ff;">📄</span>
                </div>
              </div>

              <h1 style="color: #00f0ff; font-size: 28px; margin: 0 0 10px 0; text-align: center; font-weight: bold; letter-spacing: 2px;">
                ${texts.title}
              </h1>

              <p style="color: #a0a0b0; font-size: 16px; line-height: 1.6; margin: 0 0 30px 0; text-align: center;">
                ${texts.greeting.replace('{name}', customerName)}
              </p>

              <!-- Order reference -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom: 25px;">
                <tr>
                  <td style="background-color: rgba(0, 240, 255, 0.1); border: 1px solid rgba(0, 240, 255, 0.3); border-radius: 12px; padding: 20px; text-align: center;">
                    <p style="color: #a0a0b0; font-size: 14px; margin: 0 0 8px 0;">${texts.invoiceText}</p>
                    <p style="color: #00f0ff; font-size: 28px; font-weight: bold; margin: 0; letter-spacing: 3px;">${orderRef}</p>
                  </td>
                </tr>
              </table>

              <!-- Thank you message -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 25px; text-align: center;">
                    <p style="color: #ffffff; font-size: 16px; margin: 0; line-height: 1.6;">
                      ${texts.thankYou.replace('{branch}', branchName)}
                    </p>
                  </td>
                </tr>
              </table>

              <!-- View Invoice Button -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom: 25px;">
                <tr>
                  <td style="text-align: center; padding: 10px 0;">
                    <a href="${invoiceUrl}" target="_blank" style="display: inline-block; background: linear-gradient(135deg, #00f0ff 0%, #00c4cc 100%); color: #1a1a2e; padding: 16px 40px; border-radius: 12px; text-decoration: none; font-weight: bold; font-size: 16px; letter-spacing: 1px; box-shadow: 0 4px 15px rgba(0, 240, 255, 0.4);">
                      ${texts.viewInvoice}
                    </a>
                  </td>
                </tr>
              </table>

              <!-- Branch info -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(0, 240, 255, 0.08); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 20px;">
                    <p style="color: #00f0ff; font-size: 16px; font-weight: bold; margin: 0 0 10px 0;">
                      📍 ${branchName}
                    </p>
                    ${branchAddress ? `<p style="color: #ffffff; margin: 0 0 10px 0; line-height: 1.5;">${branchAddress}</p>` : ''}
                    ${branchPhone ? `<p style="color: #00f0ff; margin: 0;">📞 ${branchPhone}</p>` : ''}
                  </td>
                </tr>
              </table>

              <!-- Contact note -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2);">
                <tr>
                  <td style="padding: 20px; text-align: center;">
                    <p style="color: #a0a0b0; font-size: 14px; margin: 0;">
                      ${texts.questions}
                    </p>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Footer -->
          <tr>
            <td style="background-color: #1a1a2e; padding: 25px 30px; text-align: center; border-top: 1px solid rgba(0, 240, 255, 0.2);">
              <p style="color: #a0a0b0; margin: 0 0 10px 0; font-size: 14px;">
                ${texts.footerThank}
              </p>
              <p style="color: #606070; margin: 0; font-size: 12px;">
                © ${currentYear} ActiveGames. ${texts.footerRights}
              </p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>`
    }

    if (locale === 'he') {
      subject = `חשבונית עבור הזמנה ${orderRef} - ${branchName}`
      htmlContent = generateInvoiceEmail('he', {
        title: 'החשבונית שלך',
        greeting: 'שלום {name},',
        thankYou: 'תודה שביקרתם אצלנו ב-{branch}!',
        invoiceText: 'חשבונית להזמנה מספר',
        viewInvoice: 'צפייה בחשבונית',
        questions: 'לשאלות או בירורים, אנחנו כאן לשירותכם.',
        regards: 'בברכה',
        footerThank: 'תודה שבחרתם ב-ActiveGames!',
        footerRights: 'כל הזכויות שמורות.',
      })
    } else if (locale === 'fr') {
      subject = `Facture pour la commande ${orderRef} - ${branchName}`
      htmlContent = generateInvoiceEmail('fr', {
        title: 'Votre Facture',
        greeting: 'Bonjour {name},',
        thankYou: 'Merci de votre visite chez {branch} !',
        invoiceText: 'Facture pour la commande',
        viewInvoice: 'Voir la facture',
        questions: 'Pour toute question, n\'hésitez pas à nous contacter.',
        regards: 'Cordialement',
        footerThank: 'Merci d\'avoir choisi ActiveGames !',
        footerRights: 'Tous droits réservés.',
      })
    } else {
      subject = `Invoice for order ${orderRef} - ${branchName}`
      htmlContent = generateInvoiceEmail('en', {
        title: 'Your Invoice',
        greeting: 'Hello {name},',
        thankYou: 'Thank you for visiting {branch}!',
        invoiceText: 'Invoice for order',
        viewInvoice: 'View Invoice',
        questions: 'If you have any questions, please don\'t hesitate to contact us.',
        regards: 'Best regards',
        footerThank: 'Thank you for choosing ActiveGames!',
        footerRights: 'All rights reserved.',
      })
    }

    // Envoyer l'email
    const result = await sendEmail({
      to: order.customer_email,
      toName: customerName,
      subject,
      html: htmlContent,
      templateCode: 'invoice_email',
      entityType: 'order',
      entityId: orderId,
      branchId: order.branch_id || undefined,
      triggeredBy: user.id,
      metadata: {
        invoiceUrl,
        orderRef,
        locale,
      },
    })

    if (!result.success) {
      return NextResponse.json(
        { success: false, error: result.error || 'Failed to send email', messageKey: 'admin.invoice.errors.send_failed' },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      message: 'Invoice sent successfully',
      messageKey: 'admin.invoice.success',
      emailLogId: result.emailLogId,
    })
  } catch (error) {
    console.error('Error sending invoice email:', error)
    return NextResponse.json(
      { success: false, error: 'Internal server error', messageKey: 'errors.internalError' },
      { status: 500 }
    )
  }
}
