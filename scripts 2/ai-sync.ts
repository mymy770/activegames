/**
 * AI SYNC - Communication Claude ↔ Cursor
 * 
 * Utilise Supabase pour synchroniser les messages entre Claude et Cursor.
 * 
 * Usage dans Cursor:
 *   import { sendMessage, getMessages } from './scripts/ai-sync'
 *   
 *   // Envoyer un message à Claude
 *   await sendMessage('cursor', 'npm install terminé, 0 erreurs')
 *   
 *   // Lire les messages de Claude
 *   const messages = await getMessages('claude')
 */

const SUPABASE_URL = 'https://mypstbvbekfwyaaewpfe.supabase.co'
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15cHN0YnZiZWtmd3lhYWV3cGZlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0MjQwNjIsImV4cCI6MjA1MjAwMDA2Mn0.Ej-S4GhHPzIYBqMqGYcLmkBbOouwChspncrPfJumZOE'

interface SyncMessage {
  id: number
  source: 'claude' | 'cursor'
  message: string
  context?: Record<string, any>
  project: string
  created_at: string
}

/**
 * Envoyer un message
 */
export async function sendMessage(
  source: 'claude' | 'cursor',
  message: string,
  context?: Record<string, any>
): Promise<SyncMessage | null> {
  try {
    const response = await fetch(`${SUPABASE_URL}/rest/v1/ai_sync`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'Prefer': 'return=representation'
      },
      body: JSON.stringify({
        source,
        message,
        context,
        project: 'active-games'
      })
    })
    
    const data = await response.json()
    return data[0] || null
  } catch (error) {
    console.error('AI Sync Error:', error)
    return null
  }
}

/**
 * Récupérer les messages
 */
export async function getMessages(
  source?: 'claude' | 'cursor',
  limit: number = 10
): Promise<SyncMessage[]> {
  try {
    let url = `${SUPABASE_URL}/rest/v1/ai_sync?project=eq.active-games&order=created_at.desc&limit=${limit}`
    
    if (source) {
      url += `&source=eq.${source}`
    }
    
    const response = await fetch(url, {
      headers: {
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      }
    })
    
    return await response.json()
  } catch (error) {
    console.error('AI Sync Error:', error)
    return []
  }
}

/**
 * Récupérer le dernier message de Claude
 */
export async function getLastClaudeMessage(): Promise<SyncMessage | null> {
  const messages = await getMessages('claude', 1)
  return messages[0] || null
}

/**
 * Récupérer le dernier message de Cursor
 */
export async function getLastCursorMessage(): Promise<SyncMessage | null> {
  const messages = await getMessages('cursor', 1)
  return messages[0] || null
}

// CLI pour test rapide
if (require.main === module) {
  const args = process.argv.slice(2)
  
  if (args[0] === 'read') {
    getMessages().then(messages => {
      console.log('\n📬 Messages AI Sync:\n')
      messages.forEach(m => {
        const icon = m.source === 'claude' ? '🤖' : '💻'
        console.log(`${icon} [${m.source.toUpperCase()}] ${m.created_at}`)
        console.log(`   ${m.message}\n`)
      })
    })
  } else if (args[0] === 'send' && args[1]) {
    sendMessage('cursor', args.slice(1).join(' ')).then(result => {
      if (result) {
        console.log('✅ Message envoyé!')
      } else {
        console.log('❌ Erreur envoi')
      }
    })
  } else {
    console.log(`
AI Sync - Communication Claude ↔ Cursor

Usage:
  node ai-sync.js read              # Lire les messages
  node ai-sync.js send <message>    # Envoyer un message en tant que Cursor
    `)
  }
}
