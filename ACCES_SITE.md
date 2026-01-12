# 🚀 Guide d'accès au site et à l'admin

## 1. Démarrer le serveur

```bash
cd /Users/jeremy/Desktop/cursor/activegames
npm run dev
```

Le serveur démarre sur **http://localhost:3000**

---

## 2. Accès au site public

### Page d'accueil
- **Français** : http://localhost:3000/fr
- **Anglais** : http://localhost:3000/en
- **Hébreu** : http://localhost:3000/he

### Réservation (Booking)
- **Français** : http://localhost:3000/fr/booking
- **Anglais** : http://localhost:3000/en/booking
- **Hébreu** : http://localhost:3000/he/booking

### Confirmation de réservation
- Après avoir créé une réservation, redirection vers :
  - http://localhost:3000/en/booking/confirmation?id=BOOKING_ID

---

## 3. Accès à l'admin / Backoffice

### Login Admin
**URL** : http://localhost:3000/admin/login

**Mot de passe** : `dev-admin-secret-token-12345`
*(valeur de `ADMIN_TOKEN` dans `.env`)*

### Pages Admin

Une fois connecté, vous avez accès à :

1. **Liste des réservations**
   - URL : http://localhost:3000/admin/bookings
   - Fonctionnalités :
     - Voir toutes les réservations
     - Filtrer par branch, date, type, status
     - Voir les détails d'une réservation
     - Annuler une réservation

2. **Paramètres (Settings)**
   - URL : http://localhost:3000/admin/settings
   - Fonctionnalités :
     - Modifier les paramètres par branch
     - Max Concurrent Players
     - Durées (Game, Event, Buffers)
     - Min Event Participants

### Logout
- Bouton "Logout" en haut à droite des pages admin
- Redirige vers `/admin/login`

---

## 4. Flow complet d'utilisation

### Créer une réservation (utilisateur)
1. Aller sur http://localhost:3000/en/booking
2. Choisir Branch → Type → Date/Heure → Participants
3. Remplir les infos client
4. Confirmer
5. Voir la page de confirmation avec le Booking ID

### Vérifier dans l'admin
1. Aller sur http://localhost:3000/admin/login
2. Entrer le mot de passe : `dev-admin-secret-token-12345`
3. Voir la liste des réservations sur http://localhost:3000/admin/bookings
4. Cliquer sur "View" pour voir les détails
5. Cliquer sur "Cancel" pour annuler une réservation

### Modifier les settings
1. Aller sur http://localhost:3000/admin/settings
2. Sélectionner une branch
3. Modifier les paramètres (ex: Max Concurrent Players)
4. Cliquer "Save Settings"

---

## 5. Notes importantes

- **Cookie d'authentification** : Une fois connecté, le cookie `admin_token` est valide 7 jours
- **Redirection automatique** : Si vous essayez d'accéder à `/admin/*` sans être connecté, redirection vers `/admin/login`
- **Base de données** : Assurez-vous que `dev.db` existe et est seedée (voir `prisma/manual-seed.sql`)

---

## 6. Dépannage

### Le serveur ne démarre pas
```bash
# Vérifier que les dépendances sont installées
npm install

# Vérifier que la base de données existe
ls -la dev.db
```

### Erreur "Unauthorized" sur /admin
- Vérifier que vous êtes connecté (cookie `admin_token`)
- Se reconnecter via `/admin/login`

### Pas de branches disponibles
- Seed la base de données :
```bash
sqlite3 dev.db < prisma/manual-seed.sql
```
