# Back Office - Réservations

## Accès

**URL :** http://localhost:3000/admin

**Mot de passe :** `admin123` (configurable dans `.env` via `ADMIN_PASSWORD`)

## Fonctionnalités

### Page Admin
- ✅ Liste de toutes les réservations validées
- ✅ Filtres :
  - Statut (Toutes / Confirmées / Annulées)
  - Branch (Toutes / Rishon LeZion / Petah Tikva)
  - Type (Tous / Game / Event)
  - Recherche (nom, téléphone, email, numéro de réservation)
- ✅ Statistiques : Total / Confirmées / Annulées
- ✅ Actions : Annuler une réservation (bouton 🚫)

### Stockage
- Les réservations sont stockées dans `data/reservations.json`
- Format JSON simple, facile à lire/modifier
- Le fichier est automatiquement créé au premier enregistrement

### API Routes
- `GET /api/reservations` - Liste toutes les réservations
- `POST /api/reservations` - Crée une nouvelle réservation
- `PATCH /api/reservations/[id]` - Met à jour le statut d'une réservation

### Authentification
- Page de login simple avec mot de passe
- Stockage de l'authentification dans `localStorage` (session navigateur)
- Mot de passe configurable dans `.env` : `ADMIN_PASSWORD=admin123`

## Configuration

Dans `.env` :
```
ADMIN_PASSWORD=admin123
```

**⚠️ Important :** Changez le mot de passe en production !

## Structure des données

Chaque réservation contient :
- `id` : Identifiant unique
- `reservationNumber` : Numéro de réservation (AG-YYYYMMDD-HHMMSS)
- `branch` : Branch (Rishon LeZion ou Petah Tikva)
- `type` : Type (game ou event)
- `players` : Nombre de participants
- `date` : Date (format YYYY-MM-DD)
- `time` : Heure (format HH:MM)
- `firstName` : Prénom
- `lastName` : Nom
- `phone` : Téléphone
- `email` : Email (optionnel)
- `specialRequest` : Demande spéciale (optionnel)
- `eventType` : Type d'événement (optionnel, pour events)
- `eventAge` : Âge (optionnel, pour events)
- `status` : Statut (confirmed ou cancelled)
- `createdAt` : Date de création (ISO)

## Test

1. **Créer une réservation :**
   - Aller sur http://localhost:3000/reservation
   - Remplir le formulaire et confirmer
   - La réservation est sauvegardée automatiquement

2. **Voir les réservations :**
   - Aller sur http://localhost:3000/admin
   - Se connecter avec le mot de passe : `admin123`
   - Voir la liste de toutes les réservations

## Migration future

Si vous voulez migrer vers une vraie base de données plus tard :
1. Remplacez `src/lib/reservations.ts` pour utiliser Prisma/MySQL/PostgreSQL
2. Gardez la même interface (fonctions `getAllReservations`, `saveReservation`, etc.)
3. Les API routes et la page admin n'ont pas besoin de changement
