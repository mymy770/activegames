# Guide de Test End-to-End Manuel

## Prérequis

1. **Base de données seedée** :
   ```bash
   # Via Prisma Studio ou SQLite
   sqlite3 dev.db < prisma/manual-seed.sql
   ```

2. **Serveur démarré** :
   ```bash
   npm run dev
   ```

3. **Script automatisé (optionnel)** :
   ```bash
   npm run test:e2e
   ```

## Tests Manuels

### Test 1: Créer réservation GAME

1. Ouvrir : `http://localhost:3000/en/booking`
2. Sélectionner :
   - **Branch**: Herzliya (ou la première disponible)
   - **Type**: GAME
   - **Date**: Aujourd'hui ou demain
   - **Time**: 17:00 (ou n'importe quelle heure disponible)
   - **Participants**: 5
   - **Customer Info**:
     - First Name: Test
     - Last Name: Game
     - Phone: +33612345678
     - Email: test.game@example.com (optionnel)
3. Confirmer la réservation
4. Noter le **Booking ID** depuis la page de confirmation

**Vérifier** :
- ✅ Page de confirmation affiche le bon ID
- ✅ Type: GAME
- ✅ Date/Time corrects
- ✅ Participants: 5

---

### Test 2: Créer réservation EVENT

1. Retourner sur : `http://localhost:3000/en/booking`
2. Sélectionner :
   - **Branch**: Même que GAME
   - **Type**: EVENT
   - **Date**: Même jour, 2h après le GAME (ex: 19:00)
   - **Time**: 19:00
   - **Participants**: 20 (minimum 15)
   - **Event Type**: Birthday (ou autre)
   - **Age**: 25 (optionnel pour birthday)
   - **Customer Info**:
     - First Name: Test
     - Last Name: Event
     - Phone: +33612345679
3. Confirmer la réservation
4. Noter le **Booking ID**

**Vérifier** :
- ✅ Type: EVENT
- ✅ Participants: 20 (≥ 15)
- ✅ Event Type et Age affichés (si applicable)

---

### Test 3: Vérifier dans Admin

1. Ouvrir : `http://localhost:3000/admin/bookings`
2. **Login** si nécessaire :
   - Password: `dev-admin-secret-token-12345` (valeur de `ADMIN_TOKEN`)

**Vérifier les deux réservations** :
- ✅ **GAME** apparaît dans la liste avec :
  - Branch: Herzliya
  - Type: GAME (badge bleu)
  - Date/Time: 17:00
  - Participants: 5
  - Status: CONFIRMED (badge vert)
- ✅ **EVENT** apparaît dans la liste avec :
  - Branch: Herzliya
  - Type: EVENT (badge violet)
  - Date/Time: 19:00
  - Participants: 20
  - Status: CONFIRMED

3. **Cliquer sur l'icône "View" (œil)** pour la réservation GAME
4. **Vérifier dans le modal** :
   - ✅ Booking ID complet
   - ✅ Branch, Type, Date/Time, Participants
   - ✅ Customer: Test Game, +33612345678
   - ✅ Status: CONFIRMED

---

### Test 4: Annuler réservation et vérifier slot libéré

1. Dans `/admin/bookings`, trouver la réservation **GAME** (17:00)
2. **Cliquer sur le bouton "Cancel"** (icône ban rouge) ou dans le modal
3. **Confirmer** l'annulation
4. **Vérifier** :
   - ✅ Status passe à "CANCELLED" (badge rouge)
   - ✅ Réservation disparaît du filtre "Status: CONFIRMED" (si filtre actif)

5. **Retourner sur** : `http://localhost:3000/en/booking`
6. Sélectionner :
   - **Branch**: Même que la réservation annulée
   - **Type**: GAME
   - **Date**: Même jour
   - **Time**: 17:00 (heure de la réservation annulée)

**Vérifier** :
- ✅ Le slot **17:00 est maintenant disponible** (devrait apparaître en vert/disponible)
- ✅ On peut créer une nouvelle réservation pour 17:00

---

### Test 5: Modifier settings et vérifier blocage

1. Ouvrir : `http://localhost:3000/admin/settings`
2. **Sélectionner la branch** : Herzliya
3. **Modifier** :
   - **Max Concurrent Players**: `80` → `10`
4. **Cliquer "Save Settings"**
5. **Vérifier** :
   - ✅ Message de succès "Settings saved successfully!"
   - ✅ Le champ affiche bien `10` après rechargement

6. **Retourner sur** : `http://localhost:3000/en/booking`
7. Sélectionner :
   - **Branch**: Herzliya
   - **Type**: GAME
   - **Date**: Même jour que les réservations précédentes
   - **Time**: 19:00 (même heure que EVENT avec 20 participants)
   - **Participants**: `11` (11 + 20 = 31 > 10, devrait bloquer)

**Vérifier** :
- ❌ Le slot **19:00 devrait être indisponible** (grisé/Full) car :
  - EVENT existant: 20 participants
  - Nouveau GAME: 11 participants
  - Total: 31 > 10 (max)
- ✅ Si on essaie quand même de confirmer, on devrait avoir une erreur de capacité

8. **Essayer avec 5 participants** (5 + 20 = 25 > 10, toujours bloqué)
9. **Annuler l'EVENT de 20** via admin
10. **Réessayer avec 11 participants** → devrait fonctionner (11 < 10? Non... attendez, si max=10, alors 11 seul devrait bloquer)

**Correction du test** :
- Annuler l'EVENT de 20
- Essayer GAME de 11 participants seul → devrait bloquer (11 > 10)
- Essayer GAME de 8 participants → devrait fonctionner (8 < 10)

11. **Restaurer settings** :
    - Retourner sur `/admin/settings`
    - **Max Concurrent Players**: `10` → `80`
    - **Save Settings**

---

## Résumé des Vérifications

### ✅ Checklist complète :

- [ ] Réservation GAME créée et visible dans admin
- [ ] Réservation EVENT créée et visible dans admin
- [ ] Tous les champs corrects dans admin (branch, type, date, participants)
- [ ] Annulation libère le slot (disponible dans booking)
- [ ] Modification maxConcurrentPlayers fonctionne
- [ ] Blocage de capacité fonctionne (> max)

---

## Test Automatisé (Alternative)

Si vous préférez un test automatisé :

```bash
npm run test:e2e
```

Ce script teste :
1. Création réservation GAME
2. Création réservation EVENT
3. Vérification dans admin (via query DB)
4. Annulation et vérification slot libéré
5. Modification settings et test blocage capacité

**Note** : Le script nettoie automatiquement les réservations de test.
