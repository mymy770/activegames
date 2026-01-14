# Fix Test E2E - Problème PrismaClient + DATABASE_URL

## Problème

Le script `test-e2e.ts` échoue car :
1. `prisma.ts` est importé via `booking.service.ts` avant que `DATABASE_URL` soit défini
2. Prisma 7.2.0 nécessite `DATABASE_URL` défini AVANT la création de `PrismaClient`
3. Même avec `import 'dotenv/config'`, le chargement n'est pas garanti avant l'import de `prisma.ts`

## Solution

**Option 1: Utiliser le test manuel (RECOMMANDÉ)**

Le test manuel via `TEST_E2E_MANUAL.md` est plus fiable car :
- Il teste l'interface utilisateur complète
- Il teste le flow réel (via navigateur)
- Il n'a pas de problème de chargement de variables d'environnement

**Option 2: Seed la base de données puis tester manuellement**

1. Seed la base de données :
   ```bash
   sqlite3 dev.db < prisma/manual-seed.sql
   # OU via Prisma Studio
   npx prisma studio
   ```

2. Tester via l'interface :
   - Ouvrir `/en/booking`
   - Créer une réservation GAME
   - Créer une réservation EVENT
   - Vérifier dans `/admin/bookings`
   - Annuler et vérifier slot libéré
   - Modifier settings et tester blocage

## Command pour test manuel

```bash
# 1. Seed la base (si pas déjà fait)
sqlite3 dev.db < prisma/manual-seed.sql

# 2. Démarrer le serveur
npm run dev

# 3. Suivre TEST_E2E_MANUAL.md
```

## Status

- ❌ `npm run test:e2e` : Échoue (problème PrismaClient + DATABASE_URL)
- ✅ Test manuel : Recommandé (voir TEST_E2E_MANUAL.md)
