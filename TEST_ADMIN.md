# Test Admin - Guide Rapide

## 1. Prérequis

1. **Seed la base de données** (si pas déjà fait) :
   ```bash
   # Via Prisma Studio : Exécuter manual-seed.sql
   # Ou via SQLite directement :
   sqlite3 dev.db < prisma/manual-seed.sql
   ```

2. **Démarrer le serveur** :
   ```bash
   npm run dev
   ```

3. **Configurer le token admin** (déjà dans .env) :
   ```
   ADMIN_TOKEN="dev-admin-secret-token-12345"
   ```

## 2. Test Flow Complet

### Étape 1 : Créer une réservation

1. Ouvrir : `http://localhost:3000/en/booking`
2. Sélectionner :
   - Branch: Herzliya
   - Type: GAME
   - Date: Aujourd'hui ou demain
   - Heure: 17:00 (ou n'importe quelle heure disponible)
   - Participants: 10
   - Customer: Test User, +1234567890
3. Confirmer la réservation
4. Noter le `booking.id` depuis la page de confirmation

### Étape 2 : Vérifier dans Admin

1. Ouvrir : `http://localhost:3000/admin/bookings`
   - **Important** : Ajouter le header `x-admin-token: dev-admin-secret-token-12345`
   - Via DevTools Network tab : Ajouter custom header
   - Ou via curl :
     ```bash
     curl -H "x-admin-token: dev-admin-secret-token-12345" http://localhost:3000/admin/bookings
     ```

2. Vérifier que la réservation apparaît dans la liste
3. Cliquer sur l'icône "View" pour voir les détails

### Étape 3 : Annuler la réservation

1. Dans `/admin/bookings`, cliquer sur le bouton "Cancel" (icône Ban rouge)
2. Confirmer l'annulation
3. Vérifier que le status passe à "CANCELLED"

### Étape 4 : Vérifier capacité libérée

1. Retourner sur `/en/booking`
2. Sélectionner la même branch, type, date et heure
3. Vérifier que le slot est maintenant disponible (devrait l'être après annulation)

## 3. Test Settings

1. Ouvrir : `http://localhost:3000/admin/settings` (avec header x-admin-token)
2. Sélectionner une branch
3. Modifier un paramètre (ex: Max Concurrent Players: 80 → 90)
4. Cliquer "Save Settings"
5. Vérifier le message de succès
6. Recharger la page et vérifier que les changements persistent

## 4. Notes

- **Auth**: Toutes les routes `/admin/*` nécessitent le header `x-admin-token`
- **Middleware**: Le middleware bloque les requêtes sans token valide
- **Capacité**: L'annulation libère immédiatement les slots (recalcul via status CONFIRMED uniquement)
