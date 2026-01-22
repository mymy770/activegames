# BACKUP AUTOMATIQUE ACTIVELASER

## 🎯 SOLUTION 1: Script Local (Simple)

### Créer un script de backup automatique

**Fichier: `scripts/backup-supabase.sh`**

```bash
#!/bin/bash

# Configuration
PROJECT_ID="zapwlcrjnabrfhoxfgqo"
BACKUP_DIR="/path/to/your/NAS/backups/supabase"
DATE=$(date +%Y%m%d_%H%M%S)

# Créer le dossier de backup
mkdir -p $BACKUP_DIR

# Export SQL via Supabase CLI
supabase db dump --project-id $PROJECT_ID > $BACKUP_DIR/backup_$DATE.sql

# Garder seulement les 30 derniers backups
ls -t $BACKUP_DIR/backup_*.sql | tail -n +31 | xargs rm -f

echo "✅ Backup créé: $BACKUP_DIR/backup_$DATE.sql"
```

### Automatiser avec Cron (Mac)

```bash
# Ouvrir le crontab
crontab -e

# Ajouter une ligne pour backup toutes les heures
0 * * * * /Users/jeremy/Desktop/claude/activelaser/scripts/backup-supabase.sh

# OU toutes les 6 heures
0 */6 * * * /Users/jeremy/Desktop/claude/activelaser/scripts/backup-supabase.sh

# OU tous les jours à 3h du matin
0 3 * * * /Users/jeremy/Desktop/claude/activelaser/scripts/backup-supabase.sh
```

---

## 🚀 SOLUTION 2: API Supabase Management (Plus avancé)

### Script Node.js pour backup automatique

**Fichier: `scripts/backup-api.js`**

```javascript
// Installation: npm install @supabase/supabase-js node-fetch

const fs = require('fs');
const path = require('path');

// Configuration
const SUPABASE_ACCESS_TOKEN = "ton-token-ici"; // À générer sur https://supabase.com/dashboard/account/tokens
const PROJECT_REF = "zapwlcrjnabrfhoxfgqo";
const BACKUP_DIR = "/path/to/your/NAS/backups/supabase";

async function createBackup() {
  try {
    // 1. Lister les backups disponibles
    const response = await fetch(
      `https://api.supabase.com/v1/projects/${PROJECT_REF}/database/backups`,
      {
        headers: {
          'Authorization': `Bearer ${SUPABASE_ACCESS_TOKEN}`,
        }
      }
    );

    const backups = await response.json();

    if (backups.length === 0) {
      console.log('❌ Aucun backup disponible');
      return;
    }

    // 2. Prendre le dernier backup
    const latestBackup = backups[0];

    // 3. Télécharger le backup (si backup quotidien, pas PITR)
    if (latestBackup.download_url) {
      const backupResponse = await fetch(latestBackup.download_url);
      const backupData = await backupResponse.text();

      // 4. Sauvegarder sur le NAS
      const timestamp = new Date().toISOString().replace(/:/g, '-').split('.')[0];
      const filename = `backup_${timestamp}.sql`;
      const filepath = path.join(BACKUP_DIR, filename);

      fs.writeFileSync(filepath, backupData);

      console.log(`✅ Backup sauvegardé: ${filepath}`);

      // 5. Nettoyer les vieux backups (garder 30 derniers)
      cleanOldBackups(BACKUP_DIR, 30);
    } else {
      console.log('⚠️ Backup PITR détecté - pas de téléchargement direct possible');
      console.log('Utilise plutôt pg_dump ou Supabase CLI');
    }

  } catch (error) {
    console.error('❌ Erreur lors du backup:', error);
  }
}

function cleanOldBackups(dir, keepCount) {
  const files = fs.readdirSync(dir)
    .filter(f => f.startsWith('backup_') && f.endsWith('.sql'))
    .map(f => ({
      name: f,
      time: fs.statSync(path.join(dir, f)).mtime.getTime()
    }))
    .sort((a, b) => b.time - a.time);

  // Supprimer les fichiers au-delà de keepCount
  files.slice(keepCount).forEach(file => {
    fs.unlinkSync(path.join(dir, file.name));
    console.log(`🗑️  Supprimé: ${file.name}`);
  });
}

// Exécuter le backup
createBackup();
```

### Automatiser avec Cron

```bash
# Toutes les heures
0 * * * * node /Users/jeremy/Desktop/claude/activelaser/scripts/backup-api.js

# Tous les jours à 2h du matin
0 2 * * * node /Users/jeremy/Desktop/claude/activelaser/scripts/backup-api.js
```

---

## 🔥 SOLUTION 3: Vercel Cron Job (RECOMMANDÉ)

### Créer une API route dans ton projet

**Fichier: `src/app/api/cron/backup/route.ts`**

```typescript
import { createClient } from '@supabase/supabase-js';
import { NextResponse } from 'next/server';

// Protection: seul Vercel Cron peut appeler cette route
export async function GET(request: Request) {
  // Vérifier que c'est bien Vercel Cron qui appelle
  const authHeader = request.headers.get('authorization');
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  try {
    const supabase = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );

    // 1. Exporter toutes les tables importantes
    const tables = [
      'contacts',
      'bookings',
      'orders',
      'payments',
      'email_logs',
      'branches',
      'products'
    ];

    const backupData: any = {
      timestamp: new Date().toISOString(),
      tables: {}
    };

    for (const table of tables) {
      const { data, error } = await supabase
        .from(table)
        .select('*');

      if (error) {
        console.error(`Erreur table ${table}:`, error);
        continue;
      }

      backupData.tables[table] = data;
    }

    // 2. Envoyer le backup quelque part (exemples ci-dessous)

    // Option A: Sauvegarder dans Supabase Storage
    const { error: uploadError } = await supabase
      .storage
      .from('backups')
      .upload(
        `backup_${Date.now()}.json`,
        JSON.stringify(backupData),
        { contentType: 'application/json' }
      );

    if (uploadError) {
      throw uploadError;
    }

    // Option B: Envoyer par email (avec Brevo)
    // const response = await fetch('https://api.brevo.com/v3/smtp/email', {
    //   method: 'POST',
    //   headers: {
    //     'api-key': process.env.BREVO_API_KEY!,
    //     'content-type': 'application/json'
    //   },
    //   body: JSON.stringify({
    //     sender: { email: 'backup@activegames.co.il' },
    //     to: [{ email: 'ton-email@gmail.com' }],
    //     subject: `Backup ActiveLaser ${new Date().toLocaleDateString()}`,
    //     attachment: [{
    //       content: Buffer.from(JSON.stringify(backupData)).toString('base64'),
    //       name: `backup_${Date.now()}.json`
    //     }]
    //   })
    // });

    // Option C: Webhook vers ton NAS/serveur
    // await fetch('https://ton-nas.com/api/backup', {
    //   method: 'POST',
    //   headers: { 'Content-Type': 'application/json' },
    //   body: JSON.stringify(backupData)
    // });

    return NextResponse.json({
      success: true,
      message: 'Backup créé avec succès',
      tablesCount: Object.keys(backupData.tables).length
    });

  } catch (error) {
    console.error('Erreur backup:', error);
    return NextResponse.json({
      error: 'Backup failed',
      details: error
    }, { status: 500 });
  }
}
```

### Configuration Vercel Cron

**Fichier: `vercel.json` (à la racine du projet)**

```json
{
  "crons": [
    {
      "path": "/api/cron/backup",
      "schedule": "0 */6 * * *"
    }
  ]
}
```

**Fréquences possibles:**
```
"0 * * * *"      → Toutes les heures
"0 */6 * * *"    → Toutes les 6 heures
"0 2 * * *"      → Tous les jours à 2h
"0 */12 * * *"   → Toutes les 12 heures
```

**Variables d'environnement Vercel:**
```bash
CRON_SECRET=ton-secret-ici-genere-un-mot-de-passe-fort
```

---

## 🎯 QUELLE SOLUTION CHOISIR ?

### Pour toi, je recommande:

**SOLUTION 3 (Vercel Cron) + Supabase Storage**

✅ **Avantages:**
- Gratuit (inclus dans Vercel)
- Automatique (aucune machine à laisser allumée)
- Fiable (tourne dans le cloud)
- Backup stocké sur Supabase Storage (sécurisé)
- Peut envoyer email de confirmation

**Configuration rapide:**

1. Créer le bucket `backups` dans Supabase Storage
2. Ajouter le fichier `src/app/api/cron/backup/route.ts`
3. Modifier `vercel.json`
4. Push sur GitHub
5. Ajouter `CRON_SECRET` dans Vercel
6. ✅ Done !

---

## 📊 COMPARAISON

| Solution | Gratuit | Auto | Machine allumée | Complexité |
|----------|---------|------|-----------------|------------|
| Script Local | ✅ | ✅ | ⚠️ Oui | Facile |
| API Node.js | ✅ | ✅ | ⚠️ Oui | Moyen |
| **Vercel Cron** | ✅ | ✅ | ✅ Non | Facile |

---

## 🔐 BACKUP STORAGE OPTIONS

### Option A: Supabase Storage
- Stocké avec tes données
- Facile d'accès via dashboard
- Gratuit jusqu'à 100GB

### Option B: Email automatique
- Tu reçois le backup par email
- Limite: taille email (~25MB)
- Bon pour petites bases

### Option C: Ton NAS
- Besoin d'exposer une API sur ton NAS
- Plus complexe mais contrôle total
- Stockage illimité

---

**Tu veux que je t'aide à mettre en place quelle solution ?**
