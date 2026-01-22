# ✅ SUPABASE CLI INSTALLÉ !

Version: 2.72.7

---

## 📝 PROCHAINE ÉTAPE: Créer un token d'accès

### 1. Va sur:
https://supabase.com/dashboard/account/tokens

### 2. Clique sur "Generate New Token"

### 3. Donne un nom au token:
```
ActiveLaser Backup CLI
```

### 4. Copie le token (il ressemble à ça):
```
sbp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 5. Dans le Terminal, exécute:
```bash
export SUPABASE_ACCESS_TOKEN="ton-token-ici"
```

OU ajoute-le dans ton `.zshrc` pour le garder permanent:
```bash
echo 'export SUPABASE_ACCESS_TOKEN="ton-token-ici"' >> ~/.zshrc
source ~/.zshrc
```

---

## 🚀 ENSUITE: Faire ton premier backup

### Créer le dossier de backup:
```bash
mkdir -p ~/Desktop/claude/activelaser/backups
cd ~/Desktop/claude/activelaser/backups
```

### Exporter la base de données:
```bash
supabase db dump --project-id zapwlcrjnabrfhoxfgqo > backup_$(date +%Y%m%d_%H%M%S).sql
```

### Le fichier sera créé ici:
```
~/Desktop/claude/activelaser/backups/backup_20260122_123456.sql
```

---

## ⏰ AUTOMATISER (après le premier test)

### Script de backup automatique:

**Créer le fichier:** `~/Desktop/claude/activelaser/scripts/backup-supabase.sh`

```bash
#!/bin/bash

# Configuration
PROJECT_ID="zapwlcrjnabrfhoxfgqo"
BACKUP_DIR="$HOME/Desktop/claude/activelaser/backups"
DATE=$(date +%Y%m%d_%H%M%S)

# Créer le dossier si nécessaire
mkdir -p $BACKUP_DIR

# Export
supabase db dump --project-id $PROJECT_ID > $BACKUP_DIR/backup_$DATE.sql

# Garder seulement les 30 derniers
ls -t $BACKUP_DIR/backup_*.sql | tail -n +31 | xargs rm -f 2>/dev/null

echo "✅ Backup créé: backup_$DATE.sql"
```

### Rendre le script exécutable:
```bash
chmod +x ~/Desktop/claude/activelaser/scripts/backup-supabase.sh
```

### Tester le script:
```bash
~/Desktop/claude/activelaser/scripts/backup-supabase.sh
```

### Automatiser avec cron (tous les jours à 3h):
```bash
crontab -e
```

Ajouter cette ligne:
```
0 3 * * * ~/Desktop/claude/activelaser/scripts/backup-supabase.sh
```

---

## 📊 FRÉQUENCES POSSIBLES

```bash
# Toutes les heures
0 * * * * ~/Desktop/claude/activelaser/scripts/backup-supabase.sh

# Toutes les 6 heures
0 */6 * * * ~/Desktop/claude/activelaser/scripts/backup-supabase.sh

# Tous les jours à 3h
0 3 * * * ~/Desktop/claude/activelaser/scripts/backup-supabase.sh

# Tous les jours à minuit
0 0 * * * ~/Desktop/claude/activelaser/scripts/backup-supabase.sh
```

---

## ✅ CHECKLIST

- [x] Supabase CLI installé (version 2.72.7)
- [ ] Token d'accès créé
- [ ] Token configuré dans le Terminal
- [ ] Premier backup testé
- [ ] Script de backup créé
- [ ] Cron configuré (optionnel)

---

**🎯 Prochaine action: Créer le token sur https://supabase.com/dashboard/account/tokens**
