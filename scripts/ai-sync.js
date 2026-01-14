/**
 * AI SYNC - Communication Claude ↔ Cursor
 * 
 * Configuration par projet - ANON KEYS RÉELLES
 */

const PROJECT_CONFIG = {
  'active-games': {
    supabaseUrl: 'https://mypstbvbekfwyaaewpfe.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15cHN0YnZiZWtmd3lhYWV3cGZlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc5NTk2NjIsImV4cCI6MjA4MzUzNTY2Mn0.i0_ja9bcxmqVhka-CRq_Jb54KCaTGHTetatLnbLnfeM'
  },
  'k-prestige': {
    supabaseUrl: 'https://htemxbrbxazzatmjerij.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh0ZW14YnJieGF6emF0bWplcmlqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc4MDI0MjQsImV4cCI6MjA4MzM3ODQyNH0.6RiC65zsSb9INtYpRC7PLurvoHmbb_LX3NkPBM4wodw'
  },
  'mz-energy': {
    supabaseUrl: 'https://ihwjpzxhthhomuipehon.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlod2pwenhodGhob211aXBlaG9uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc3MDI4ODcsImV4cCI6MjA4MzI3ODg4N30.YM6d43hQyIf4hhdu1JORci1UuphaogoWM3KA5wEZW8k'
  }
}

// ═══════════════════════════════════════════════════════════════
// ⚠️ MODIFIER CETTE LIGNE SELON LE PROJET
const CURRENT_PROJECT = 'active-games'
// ═══════════════════════════════════════════════════════════════

const config = PROJECT_CONFIG[CURRENT_PROJECT]
const SUPABASE_URL = config.supabaseUrl
const SUPABASE_ANON_KEY = config.anonKey

/**
 * Envoyer un message
 */
async function sendMessage(source, message, context) {
  try {
    const response = await fetch(`${SUPABASE_URL}/rest/v1/ai_sync`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      },
      body: JSON.stringify({
        source,
        message,
        context,
        project: CURRENT_PROJECT
      })
    })
    return response.ok
  } catch (error) {
    console.error('❌ Erreur:', error)
    return false
  }
}

/**
 * Récupérer les messages
 */
async function getMessages(limit = 10) {
  try {
    const url = `${SUPABASE_URL}/rest/v1/ai_sync?project=eq.${CURRENT_PROJECT}&order=created_at.desc&limit=${limit}`
    
    const response = await fetch(url, {
      headers: {
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
      }
    })
    
    return await response.json()
  } catch (error) {
    console.error('❌ Erreur:', error)
    return []
  }
}

// ═══════════════════════════════════════════════════════════════
// CLI
// ═══════════════════════════════════════════════════════════════

const args = process.argv.slice(2)
const command = args[0]

if (command === 'read') {
  getMessages().then(messages => {
    console.log(`\n🔄 AI SYNC - ${CURRENT_PROJECT.toUpperCase()}`)
    console.log('═'.repeat(50) + '\n')
    
    if (messages.length === 0) {
      console.log('📭 Aucun message\n')
    } else {
      messages.reverse().forEach(m => {
        const icon = m.source === 'claude' ? '🤖 CLAUDE' : '💻 CURSOR'
        const time = new Date(m.created_at).toLocaleString('fr-FR')
        console.log(`${icon} │ ${time}`)
        console.log(`       │ ${m.message}`)
        console.log('')
      })
    }
  })
} else if (command === 'send') {
  const message = args.slice(1).join(' ')
  if (!message) {
    console.log('❌ Message requis!')
    console.log('   Usage: npm run sync:send "votre message"')
    process.exit(1)
  }
  sendMessage('cursor', message).then(ok => {
    if (ok) {
      console.log('✅ Message envoyé à Claude!')
      console.log(`   "${message}"`)
    } else {
      console.log('❌ Erreur lors de l\'envoi')
    }
  })
} else {
  console.log(`
🔄 AI SYNC - Communication Claude ↔ Cursor
${'═'.repeat(50)}

📁 Projet actuel: ${CURRENT_PROJECT}
🗄️  Supabase: ${SUPABASE_URL}

📋 Commandes disponibles:

  npm run sync:read              Lire tous les messages
  npm run sync:send "message"    Envoyer un message à Claude

📝 Exemples:

  npm run sync:send "Build OK, 0 erreurs"
  npm run sync:send "Déployé sur Vercel: https://..."
  npm run sync:send "Bug trouvé: le header ne s'affiche pas"

`)
}
