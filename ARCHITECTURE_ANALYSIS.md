# Analyse Complète de l'Architecture - Active Games

## Vue d'ensemble

Application Next.js 15 pour la gestion de réservations d'un centre de jeux interactifs.

## Architecture Générale

### Stack Technique
- **Framework** : Next.js 15 (App Router)
- **UI** : React 19 + TypeScript
- **Styling** : Tailwind CSS
- **Stockage** : Fichier JSON (`data/reservations.json`) pour les réservations
- **State Management** : React hooks (useState, useEffect)

## Structure des Modules

### 1. Pages Principales

#### `/src/app/page.tsx`
- Page d'accueil marketing (site public)
- Composants : Hero, Games, Pricing, Contact, etc.

#### `/src/app/admin/page.tsx` 
- **Interface admin complète** (~3500 lignes)
- Vue tableau et vue agenda
- Gestion des rendez-vous (création, édition, suppression)
- Visualisation des slots (14 colonnes) et salles (4 colonnes)

#### `/src/app/reservation/page.tsx`
- Formulaire public de réservation
- Workflow multi-étapes

### 2. Système de Scheduler (`/src/lib/scheduler/`)

#### Architecture du Scheduler

Le scheduler est le cœur du système de réservations. Il gère :
- **Slots de jeu** : 14 slots disponibles (1 slot = 6 personnes)
- **Salles d'événements** : 4 salles (capacité configurable, défaut 20 personnes)

#### Constantes Clés

```typescript
TOTAL_SLOTS = 14           // Nombre de slots disponibles
SLOTS_PER_PERSON = 6       // Personnes par slot
TOTAL_ROOMS = 4            // Nombre de salles
Capacité max slots = 84    // 14 * 6 personnes
```

#### Types de Réservations

**GAME (Jeu privé)**
- Durée : 60 minutes
- Utilise : Uniquement les slots de jeu
- Ne bloque pas de salle

**EVENT (Événement avec salle)**
- Durée totale : 120 minutes (configurable)
- Durée jeu : 60 minutes (centré)
- Utilise : Une salle (120 min) + Slots de jeu (60 min centré)
- Bloque : Salle d'anniversaire + Zone de jeu

#### Fichiers du Scheduler

**`types.ts`**
- Définitions de types : `Booking`, `Conflict`, `Allocation`, etc.
- Types de conflits : `FULL`, `NO_ROOM`, `NEED_SURBOOK_CONFIRM`, `NEED_ROOM_OVERCAP_CONFIRM`, etc.

**`state.ts`**
- `buildOccupancyState()` : Construit l'état d'occupation des slots et salles
- `buildGameSlotsState()` : État des slots de jeu
- `buildEventRoomsState()` : État des salles d'événements
- `areSlotsFree()` : Vérifie si des slots sont libres

**`time.ts`**
- Gestion du temps (granularité 15 minutes)
- `calculateCenteredGameTime()` : Calcule le temps de jeu centré pour EVENT
- `rangeToKeys()` : Génère les TimeKeys pour un intervalle

**`engine.ts`** (Fichier principal - ~1000 lignes)
- `calculateSlotsNeeded(participants)` : `Math.ceil(participants / 6)`
- `findContiguousSlots()` : Trouve des slots contigus
- `allocateLeftToRight()` : Alloue des slots de gauche à droite avec déplacement automatique
- `placeGameBooking()` : Place un booking GAME
- `reorganizeAllBookingsForDate()` : **Fonction principale** - Réorganise tous les bookings d'une date

**`adapters.ts`**
- `toBooking()` : Convertit `SimpleAppointment` (UI) → `Booking` (scheduler)
- `fromBooking()` : Convertit `Booking` (scheduler) → `SimpleAppointment` (UI)
- `toRoomConfigs()` : Convertit les capacités des salles

**`exceptions.ts`**
- Gestion des exceptions (surbooking, room overcap)
- `getConflictDetails()` : Extrait les détails d'un conflit

### 3. Logique de Réservation

#### Flux de Création d'un Rendez-vous

1. **Utilisateur remplit le formulaire** (page admin)
   - Date, heure, type (GAME/EVENT), participants, etc.

2. **Conversion en Booking**
   ```typescript
   const booking = toBooking(simpleAppointment)
   ```

3. **Appel au Scheduler**
   ```typescript
   const result = reorganizeAllBookingsForDate(
     existingBookings,
     newBooking,
     date,
     roomConfigs,
     allowSplit,
     allowSurbook,
     allowRoomOvercap
   )
   ```

4. **Traitement du Résultat**
   - Si `success = true` : Appliquer les allocations
   - Si `conflict` : Afficher popup de confirmation (surbooking, room overcap)

#### Fonction `reorganizeAllBookingsForDate()`

**Logique pour EVENT :**
1. Essayer `allocateLeftToRight()` pour les slots de jeu
2. Si succès → Chercher une salle disponible
3. Si échec → Appeler `placeGameBooking()` puis chercher une salle

**Logique pour GAME :**
1. Appeler `allocateLeftToRight()`
2. Si échec → Appeler `placeGameBooking()`

#### Calcul des Slots Nécessaires

```typescript
function calculateSlotsNeeded(participants: number): number {
  if (participants <= 0) return 1
  return Math.ceil(participants / 6)
}

// Exemples :
// 6 personnes = 1 slot
// 7 personnes = 2 slots (Math.ceil(7/6) = 2)
// 12 personnes = 2 slots
// 100 personnes = 17 slots (Math.ceil(100/6) = 17)
```

#### Gestion des Conflits

**Types de conflits :**
- `FULL` : Tous les slots occupés
- `NO_ROOM` : Aucune salle disponible
- `NEED_SURBOOK_CONFIRM` : Pas assez de slots, besoin de confirmation
- `NEED_ROOM_OVERCAP_CONFIRM` : Capacité de salle dépassée

**Détails du conflit :**
```typescript
{
  availableSlots: number,    // Nombre de slots disponibles
  neededSlots: number,       // Nombre de slots nécessaires
  maxParticipants: number    // availableSlots * 6
}
```

### 4. Interface Admin

#### Vue Agenda

**Structure :**
- Lignes : Horaires (15 min de granularité)
- Colonnes : 14 slots + 4 salles = 18 colonnes
- Slots : Colonnes 1-14
- Salles : Colonnes 15-18

**Visualisation :**
- GAME : Affiché dans les colonnes de slots
- EVENT : Affiché dans une colonne de salle + slots de jeu (60 min centré)

#### Gestion des Rendez-vous

**Création :**
- Formulaire modal
- Champs : Date, heure, type, participants, client, etc.
- Sauvegarde via `saveAppointment()`

**Édition :**
- Modification des champs
- Réorganisation automatique via scheduler

**Suppression :**
- Confirmation requise
- Réorganisation automatique

### 5. Stockage des Données

#### Réservations (`/src/lib/reservations.ts`)
- Fichier JSON : `data/reservations.json`
- Fonctions : `getAllReservations()`, `saveReservation()`, `updateReservationStatus()`

#### Structure Reservation
```typescript
{
  id: string
  branch: string
  type: 'game' | 'event'
  players: number
  date: string (YYYY-MM-DD)
  time: string (HH:MM)
  firstName, lastName, phone, email
  eventType?: string
  status: 'confirmed' | 'cancelled'
  reservationNumber: string
  createdAt: string
}
```

### 6. API Routes

#### `/api/reservations`
- `GET` : Liste toutes les réservations
- `POST` : Crée une nouvelle réservation
- `PATCH /api/reservations/[id]` : Met à jour le statut

#### `/api/admin/login`
- Authentification admin

## Problèmes Identifiés

### Bug 1 : Premier événement sur journée vide

**Symptôme :**
- Premier événement sur une journée complètement vide
- Système affiche un conflit (ex: "20 slots nécessaires, 4 disponibles")
- Même avec 100 personnes, le système affiche un conflit

**Cause probable :**
- `allocateLeftToRight()` retourne `null` même quand il ne devrait pas
- `placeGameBooking()` est appelé et génère un conflit incorrect
- Le système ne vérifie pas correctement que la journée est vide

### Bug 2 : Calculs incorrects après remplissage

**Symptôme :**
- Une fois qu'une journée contient des événements
- Les calculs de slots deviennent incorrects
- Messages de conflit apparaissent pour chaque nouveau rendez-vous
- Les chiffres varient (25 slots nécessaires, 8 disponibles)

**Cause probable :**
- Le state `overlapInfo` n'est pas réinitialisé correctement
- Les calculs de `availableSlots` sont incorrects
- `buildOccupancyState()` ne reflète pas correctement l'état réel

## Points Clés à Retenir

1. **Slots vs Salles** : Deux systèmes distincts
   - Slots : Zone de jeu (14 slots, 6 personnes/slot)
   - Salles : Salles d'anniversaire (4 salles, capacité configurable)

2. **GAME vs EVENT** :
   - GAME : Utilise uniquement les slots
   - EVENT : Utilise une salle + slots (60 min centré)

3. **Réorganisation** :
   - `reorganizeAllBookingsForDate()` traite tous les bookings d'une date
   - Réorganisation dans l'ordre chronologique
   - Déplacement automatique si nécessaire

4. **Surbooking** :
   - Possible si confirmation utilisateur
   - Calcule `excessParticipants`
   - Marqué dans le booking (`surbooked: true`)

5. **Temps de jeu centré (EVENT)** :
   - Durée totale : 120 min (exemple)
   - Temps de jeu : 60 min centré
   - Calcul : `gameStart = eventStart + (120 - 60) / 2`
