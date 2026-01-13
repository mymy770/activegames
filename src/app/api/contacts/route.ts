import { NextRequest, NextResponse } from 'next/server'
import { getAllContacts, saveContact, findContactByPhoneOrEmail, updateContact } from '@/lib/contacts'

/**
 * GET /api/contacts
 * Retourne tous les contacts (CRM)
 */
export async function GET() {
  try {
    const contacts = await getAllContacts()

    // Trier par date de création (plus récent en premier)
    contacts.sort(
      (a, b) =>
        new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
    )

    return NextResponse.json({ success: true, contacts })
  } catch (error) {
    console.error('Error fetching contacts:', error)
    return NextResponse.json(
      { success: false, error: 'Failed to fetch contacts' },
      { status: 500 }
    )
  }
}

/**
 * POST /api/contacts
 * Crée un nouveau contact ou met à jour un contact existant
 * Si contactId est fourni, met à jour ce contact
 * Sinon, cherche par téléphone/email, et met à jour si trouvé, crée sinon
 */
export async function POST(request: NextRequest) {
  try {
    const body = await request.json()

    const contactId = typeof body.contactId === 'string' ? body.contactId.trim() || null : null
    const phone = (body.phone || '').toString().trim() || null
    const firstName =
      typeof body.firstName === 'string' ? body.firstName.trim() || null : null
    const lastName =
      typeof body.lastName === 'string' ? body.lastName.trim() || null : null
    const email =
      typeof body.email === 'string' ? body.email.trim() || null : null
    const notes =
      typeof body.notes === 'string' ? body.notes.trim() || null : null
    const branch =
      typeof body.branch === 'string' ? body.branch.trim() || null : null
    const source =
      (typeof body.source === 'string' && body.source.trim()) ||
      'admin_agenda'

    // Au moins prénom OU nom requis
    if (!firstName && !lastName) {
      return NextResponse.json(
        { success: false, error: 'First name or last name is required' },
        { status: 400 }
      )
    }

    let contact

    // Si contactId est fourni, mettre à jour ce contact
    if (contactId) {
      contact = await updateContact(contactId, {
        firstName,
        lastName,
        phone: phone || undefined,
        email,
        notes,
        branch,
        source,
      })
      return NextResponse.json({ success: true, contact, updated: true })
    }

    // Sinon, chercher un contact existant par téléphone ou email
    const existingContact = await findContactByPhoneOrEmail(phone, email)
    
    if (existingContact) {
      // Mettre à jour le contact existant
      contact = await updateContact(existingContact.id, {
        firstName: firstName || existingContact.firstName,
        lastName: lastName || existingContact.lastName,
        phone: phone || existingContact.phone,
        email: email || existingContact.email,
        notes: notes || existingContact.notes,
        branch: branch || existingContact.branch,
        source,
      })
      return NextResponse.json({ success: true, contact, updated: true })
    }

    // Aucun contact trouvé, créer un nouveau
    // Pour créer, on a besoin d'au moins un téléphone OU un email
    if (!phone && !email) {
      return NextResponse.json(
        { success: false, error: 'Phone or email is required to create a new contact' },
        { status: 400 }
      )
    }

    contact = await saveContact({
      firstName,
      lastName,
      phone: phone || '',
      email,
      notes,
      branch,
      source,
    })

    return NextResponse.json({ success: true, contact, updated: false }, { status: 201 })
  } catch (error) {
    console.error('Error creating/updating contact:', error)
    return NextResponse.json(
      { success: false, error: 'Failed to create/update contact' },
      { status: 500 }
    )
  }
}

