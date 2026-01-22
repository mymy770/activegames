# RAPPORT DE SAUVEGARDE - ACTIVELASER (VERSION SIMPLE)

## ✅ QUESTION 1: Si je save Supabase tous les jours, je peux récupérer clients/commandes/agenda ?

**RÉPONSE: OUI**

Supabase contient:
- ✅ Tous les clients
- ✅ Toutes les commandes
- ✅ Tous les paiements
- ✅ Tout l'agenda (réservations)
- ✅ Historique emails
- ✅ Logs d'activité

---

## 📁 QUESTION 2: Images/Vidéos - Où sont-elles EXACTEMENT ?

### Localisation ACTUELLE

**Sur ta machine locale (dev):**
```
/Users/jeremy/Desktop/claude/activelaser/public/
├── images/ (4 images, ~3 MB)
└── videos/ (13 vidéos, ~160 MB)
```

**Sur GitHub:**
- ✅ OUI - Ces fichiers sont dans le repo Git
- ⚠️ SAUF si tu as ajouté `public/` dans `.gitignore` (à vérifier)

**Sur Vercel (production):**
- ✅ OUI - Vercel déploie tout ce qui est sur GitHub
- Les fichiers `/public` deviennent accessibles sur ton site

**Sur Supabase:**
- ❌ NON - Aucune image/vidéo n'est sur Supabase Storage
- Le code n'utilise PAS Supabase Storage

### Donc concrètement:

```
Images/Vidéos
├── Local (dev): /activelaser/public/ ✅
├── GitHub: Oui (dans le repo) ✅
├── Vercel: Oui (déployé automatiquement) ✅
└── Supabase: Non ❌
```

---

## 💾 PLAN DE BACKUP COMPLET

### 1. SUPABASE (Données)
**Fréquence:** Tous les jours

**Méthode A - Dashboard Supabase:**
1. https://supabase.com/dashboard
2. Ton projet → Database → Backups
3. Télécharger le backup

**Méthode B - Export SQL:**
```bash
supabase db dump --project-id zapwlcrjnabrfhoxfgqo > backup_$(date +%Y%m%d).sql
```

**Contient:**
- Clients, commandes, agenda, paiements, emails, logs

---

### 2. GITHUB (Code + Images/Vidéos)
**Fréquence:** À chaque modification

```bash
git add .
git commit -m "backup"
git push origin main
```

**Contient:**
- Code source
- Fichiers `/public` (images/vidéos)
- Migrations SQL

---

### 3. VERCEL (Variables d'environnement)
**Fréquence:** Après chaque changement de config

Les variables d'environnement sont sur Vercel Dashboard:
1. https://vercel.com
2. Ton projet → Settings → Environment Variables

**Contient:**
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`
- `BREVO_API_KEY`
- `ANTHROPIC_API_KEY`

**⚠️ IMPORTANT:** Faire une capture d'écran ou copier dans un fichier sécurisé

---

## 🔄 RESTAURATION COMPLÈTE

### Scénario: Tout recréer ailleurs

**Étape 1 - Base de données:**
1. Créer nouveau projet Supabase
2. Importer le backup SQL

**Étape 2 - Code + Images:**
```bash
git clone https://github.com/TON-REPO/activelaser.git
cd activelaser
npm install
```
→ Les images/vidéos sont déjà dans `/public` via Git

**Étape 3 - Déploiement:**
1. Créer nouveau projet Vercel
2. Connecter le repo GitHub
3. Ajouter les variables d'environnement
4. Déployer

**Résultat:** Tout est restauré

---

## 📊 TABLEAU RÉCAPITULATIF

| Type de donnée | Supabase | GitHub | Vercel | Backup nécessaire |
|----------------|----------|--------|--------|-------------------|
| Clients/Commandes | ✅ | ❌ | ❌ | Export Supabase |
| Agenda (réservations) | ✅ | ❌ | ❌ | Export Supabase |
| Images/Vidéos | ❌ | ✅ | ✅ | Git push |
| Code source | ❌ | ✅ | ✅ | Git push |
| Migrations SQL | ❌ | ✅ | ✅ | Git push |
| Variables env | ❌ | ❌ | ✅ | Screenshot Vercel |

---

## ⚡ CHECKLIST BACKUP RAPIDE

### Tous les jours:
```bash
# 1. Backup Supabase (automatique si activé)
# Ou manuel via dashboard

# 2. Push code sur GitHub
cd /activelaser
git add .
git commit -m "daily backup"
git push
```

### Une fois par mois:
- [ ] Export manuel Supabase → Télécharger le fichier SQL
- [ ] Screenshot des variables Vercel
- [ ] Vérifier que GitHub a bien les vidéos

---

## 🎯 RÉPONSE FINALE À TES QUESTIONS

### Q: Supabase = clients + commandes + agenda ?
**R: OUI** ✅

### Q: Images/vidéos sur Supabase ?
**R: NON** ❌

### Q: Images/vidéos où alors ?
**R: GitHub + Vercel (pas Supabase)** ✅

### Q: Si GitHub + Supabase sauvegardés, je peux tout recréer ?
**R: OUI** ✅ (+ les variables d'environnement Vercel)

---

## 🔐 LES 3 BACKUPS ESSENTIELS

1. **Supabase** → Données (clients, commandes, agenda)
2. **GitHub** → Code + Images/Vidéos
3. **Vercel variables** → Clés API (screenshot)

**Avec ces 3 = tu peux recréer le projet à 100%**

---

**Date:** 22 janvier 2026
