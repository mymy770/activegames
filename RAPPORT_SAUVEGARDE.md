# RAPPORT DE SAUVEGARDE - ACTIVELASER

## 🎯 RÉSUMÉ RAPIDE

**Base de données:** Supabase PostgreSQL
**Fichiers médias:** Dossier `/public` du projet
**Configuration:** Fichier `.env.local`
**Projet:** Next.js hébergé sur Vercel

---

## 📊 DONNÉES SUPABASE (BASE PRINCIPALE)

### 🔗 Connexion
- **URL:** https://zapwlcrjnabrfhoxfgqo.supabase.co
- **Projet ID:** zapwlcrjnabrfhoxfgqo
- **Clé publique:** Dans `.env.local`
- **Clé service:** Dans `.env.local` (⚠️ SECRET)

### 📋 TABLES (23 au total)

#### Tables Clients & Réservations
- `contacts` - Tous les clients (nom, téléphone, email, notes)
- `bookings` - Réservations de jeux
- `booking_contacts` - Lien clients ↔ réservations
- `booking_slots` - Créneaux horaires réservés
- `orders` - Commandes et paiements
- `game_sessions` - Sessions de jeu laser

#### Tables Paiements
- `payments` - Historique paiements
- `payment_credentials` - Identifiants Cardcom/iCount

#### Tables Configuration
- `branches` - Sites (Haifa, Tel Aviv, etc.)
- `branch_settings` - Paramètres par site
- `laser_rooms` - Salles laser game
- `event_rooms` - Salles événements

#### Tables Produits (iCount)
- `icount_products` - Produits synchronisés
- `icount_event_formulas` - Formules événements
- `icount_rooms` - Salles synchronisées

#### Tables Emails
- `email_logs` - Historique emails envoyés
- `email_templates` - Modèles d'emails
- `email_settings` - Configuration emails

#### Tables Utilisateurs
- `profiles` - Profils utilisateurs (lié à Supabase Auth)
- `roles` - Rôles (admin, agent, etc.)
- `role_permissions` - Permissions par rôle
- `user_branches` - Accès utilisateur par site

#### Tables Système
- `activity_logs` - Journal d'activité (qui a fait quoi)

---

## 🖼️ FICHIERS MÉDIAS

### Localisation: `/activelaser/public/`

#### Images
```
/public/images/
├── logo.png
├── logo-activegames.png
├── logo_laser_city.png
├── contact-image.png
└── games/ (images des jeux)
```

#### Vidéos
```
/public/videos/
├── arena.mp4
├── basketball.mp4
├── climb.mp4
├── climbing.mp4
├── control.mp4
├── flash.mp4
├── grid.mp4
├── hide.mp4
├── laser.mp4
├── push.mp4
└── autres vidéos promotionnelles
```

**⚠️ Important:** Ces fichiers sont dans le code source, versionnés avec Git.

---

## ⚙️ CONFIGURATION SYSTÈME

### Fichier `.env.local`
```
NEXT_PUBLIC_SUPABASE_URL=...
NEXT_PUBLIC_SUPABASE_ANON_KEY=...
SUPABASE_SERVICE_ROLE_KEY=... (⚠️ SECRET)
BREVO_API_KEY=... (emails)
ANTHROPIC_API_KEY=... (IA Clara)
```

**Localisation:** `/activelaser/.env.local`
**⚠️ Ce fichier contient des secrets - ne jamais le partager**

---

## 💾 PLAN DE BACKUP

### 1. BASE DE DONNÉES (PRIORITÉ 1)

#### Option A: Export Supabase Dashboard
1. Aller sur https://supabase.com/dashboard
2. Projet "zapwlcrjnabrfhoxfgqo"
3. Database → Backups
4. Télécharger le backup complet

#### Option B: Export SQL manuel
```bash
# Installer Supabase CLI
npm install -g supabase

# Se connecter
supabase login

# Exporter le schéma
supabase db dump --project-id zapwlcrjnabrfhoxfgqo > backup_schema.sql

# Exporter les données
supabase db dump --data-only --project-id zapwlcrjnabrfhoxfgqo > backup_data.sql
```

#### ✅ Fichier déjà créé
Vous avez déjà un export: `/data/SQL/activelaser_sql.txt` (schéma complet)

### 2. FICHIERS MÉDIAS (PRIORITÉ 2)

#### Backup simple
```bash
# Copier tout le dossier public
cp -r /activelaser/public /backup/public_$(date +%Y%m%d)
```

#### Taille approximative
- Images: ~5-10 MB
- Vidéos: ~100-200 MB
**Total: ~200-300 MB**

### 3. CODE SOURCE (PRIORITÉ 3)

#### Option A: Archive ZIP
```bash
cd /activelaser
zip -r ../activelaser_backup_$(date +%Y%m%d).zip . -x "node_modules/*" ".next/*"
```

#### Option B: Git
Si vous avez un repo GitHub:
```bash
git push origin main
```

**✅ Vous avez déjà:** `/data/GITHUB/activelaser-main.zip`

### 4. MIGRATIONS SQL (PRIORITÉ 1)

**Localisation:** `/activelaser/supabase/migrations/`

Ces fichiers sont CRITIQUES - ils contiennent toute la structure de la base.

**Backup:**
```bash
cp -r /activelaser/supabase/migrations /backup/migrations_$(date +%Y%m%d)
```

---

## 🔄 RESTAURATION COMPLÈTE

### Scénario: Recréer le projet ailleurs

#### Étape 1: Nouveau projet Supabase
1. Créer un projet sur https://supabase.com
2. Noter le nouvel URL et les clés

#### Étape 2: Restaurer la base
```bash
# Appliquer toutes les migrations
cd /activelaser/supabase/migrations
for file in *.sql; do
  psql "postgresql://postgres:[PASSWORD]@[HOST]:5432/postgres" -f "$file"
done
```

Ou via Supabase CLI:
```bash
supabase db push
```

#### Étape 3: Restaurer les données
```bash
# Import du fichier backup_data.sql
psql "postgresql://..." -f backup_data.sql
```

#### Étape 4: Nouveau projet Next.js
```bash
# Copier le code
cp -r /activelaser /nouveau-projet

# Installer
cd /nouveau-projet
npm install

# Configurer .env.local avec les nouvelles clés Supabase
```

#### Étape 5: Restaurer les médias
```bash
# Les fichiers public sont déjà dans le code source
# Rien à faire si vous avez copié le projet
```

---

## 📦 CHECKLIST BACKUP COMPLET

### Mensuel (minimum)
- [ ] Export base Supabase (via dashboard)
- [ ] Copie dossier `/public`
- [ ] Copie dossier `/supabase/migrations`
- [ ] Backup fichier `.env.local` (dans un endroit sûr)
- [ ] Vérifier que le code est sur GitHub

### Avant changement majeur
- [ ] Export SQL de toutes les tables
- [ ] Screenshot dashboard Supabase
- [ ] Backup complet du projet

### Stockage recommandé
- **Cloud:** Google Drive, Dropbox
- **Local:** Disque dur externe
- **GitHub:** Code source (sans .env.local)

---

## 🔐 SERVICES EXTERNES

### Supabase
- Base de données PostgreSQL
- Authentification utilisateurs
- Storage (si utilisé pour images futures)

### Brevo (anciennement Sendinblue)
- Envoi emails transactionnels
- **Clé API:** Dans `.env.local`

### iCount
- Synchronisation produits/clients
- Génération factures
- **Identifiants:** Dans table `payment_credentials`

### Cardcom
- Paiements en ligne
- **Identifiants:** Dans table `payment_credentials`

### Anthropic (Claude)
- Assistant IA Clara
- **Clé API:** Dans `.env.local`

### Vercel
- Hébergement du site Next.js
- Déploiement automatique

---

## 🎯 COMMANDE BACKUP RAPIDE

```bash
#!/bin/bash
# backup_activelaser.sh

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backup/activelaser_$DATE"

mkdir -p $BACKUP_DIR

# 1. Migrations SQL
cp -r /activelaser/supabase/migrations $BACKUP_DIR/

# 2. Fichiers public
cp -r /activelaser/public $BACKUP_DIR/

# 3. Configuration (sans secrets)
cp /activelaser/package.json $BACKUP_DIR/
cp /activelaser/next.config.ts $BACKUP_DIR/
cp /activelaser/tailwind.config.ts $BACKUP_DIR/

# 4. Code source (sans node_modules)
zip -r $BACKUP_DIR/code.zip /activelaser -x "*/node_modules/*" "*/.next/*"

echo "✅ Backup créé dans: $BACKUP_DIR"
```

---

## ⚠️ POINTS D'ATTENTION

1. **Ne JAMAIS commiter `.env.local` sur GitHub**
2. **Les clés API sont sensibles** - les stocker de façon sécurisée
3. **Tester la restauration** au moins une fois
4. **Supabase fait des backups automatiques** (vérifier la rétention)
5. **Les vidéos sont volumineuses** - prévoir l'espace nécessaire

---

## 📞 EN CAS DE PROBLÈME

### Perte d'accès Supabase
- Contacter support Supabase
- Avoir le Project ID: zapwlcrjnabrfhoxfgqo

### Perte de données
- Restaurer depuis le dernier backup
- Utiliser les backups automatiques Supabase (jusqu'à 7 jours)

### Corruption de la base
- Créer nouveau projet Supabase
- Rejouer les migrations
- Importer les données du backup

---

**Date du rapport:** 22 janvier 2026
**Projet:** ActiveLaser - Active Games
**Version:** 1.0.0
