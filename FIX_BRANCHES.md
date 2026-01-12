# Fix: Branches ne se chargent pas

## Problème
Les branches ne s'affichent pas dans `/en/booking` - le message "Loading branches..." reste affiché.

## Cause probable
La server action `getBranchesWithSettings` ne retourne pas les données correctement ou il y a une erreur Prisma.

## Solution rapide

1. **Vérifier la console du navigateur** :
   - Ouvrir http://localhost:3000/en/booking
   - Ouvrir DevTools (F12) → Console
   - Vérifier les logs `🔍 Branches result:` et `✅ Branches loaded:`

2. **Vérifier les logs serveur** :
   ```bash
   tail -f /tmp/test3.log | grep -i "error\|branch"
   ```

3. **Test direct de la server action** :
   - Créer un fichier de test temporaire pour vérifier que `getBranchesWithSettings()` fonctionne

## Branches en base
Les branches existent bien :
- `branch-herzliya|Herzliya`
- `branch-telaviv|Tel Aviv`

## Prochaines étapes
Si les logs montrent une erreur Prisma, il faudra vérifier la configuration de Prisma Client.
