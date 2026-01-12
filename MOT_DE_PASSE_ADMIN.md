# Mot de passe Admin

## Mot de passe actuel
**`dev-admin-secret-token-12345`**

## Comment se connecter

1. Aller sur : http://localhost:3000/admin/login
2. Entrer le mot de passe : `dev-admin-secret-token-12345`
3. Cliquer sur "Login"

## Si le mot de passe ne fonctionne pas

1. **Vérifier que le serveur est redémarré** :
   ```bash
   # Arrêter le serveur (Ctrl+C)
   # Puis redémarrer
   npm run dev
   ```

2. **Vérifier le fichier .env** :
   ```bash
   cat .env
   ```
   Doit contenir :
   ```
   DATABASE_URL="file:./dev.db"
   ADMIN_TOKEN="dev-admin-secret-token-12345"
   ```

3. **Si toujours pas de résultat** :
   - Vérifier la console du navigateur (F12) pour les erreurs
   - Vérifier les logs du serveur pour les erreurs

## Note
Le mot de passe est la valeur de `ADMIN_TOKEN` dans le fichier `.env`.
