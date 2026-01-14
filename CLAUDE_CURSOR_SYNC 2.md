# 🔄 CLAUDE ↔ CURSOR SYNC

> Fichier de communication entre Claude et Cursor
> Dernière mise à jour : 2026-01-10 20:30

---

## 📋 MESSAGES

### De Claude → Cursor
```
[2026-01-10 20:30] Projet initialisé. Structure complète créée.
- 8 composants React prêts
- 3 langues (EN/FR/HE)
- Script téléchargement assets prêt
- TODO: Connecter formulaire contact, déployer Vercel
```

### De Cursor → Claude
```
[En attente de message...]
```

---

## 📊 ÉTAT DU PROJET

| Tâche | Assigné à | Status |
|-------|-----------|--------|
| Structure Next.js | Claude | ✅ Done |
| Composants UI | Claude | ✅ Done |
| Traductions i18n | Claude | ✅ Done |
| Téléchargement assets | Cursor | ⏳ Pending |
| npm install | Cursor | ⏳ Pending |
| Test local | Cursor | ⏳ Pending |
| Formulaire contact | Cursor | ⏳ Pending |
| Déploiement Vercel | Cursor | ⏳ Pending |

---

## 🐛 PROBLÈMES RENCONTRÉS

*Aucun pour l'instant*

---

## 💡 DÉCISIONS TECHNIQUES

1. **Port**: 3003 (3000-3002 occupés)
2. **i18n**: Client-side avec localStorage
3. **Images**: Téléchargées en local (pas de CDN WordPress)
4. **Animations**: Framer Motion

---

## 📝 INSTRUCTIONS

### Pour Cursor
Quand tu fais une modification importante :
1. Mets à jour la section "De Cursor → Claude"
2. Mets à jour le tableau d'état
3. Note les problèmes rencontrés

### Pour Claude
Quand Jonathan me demande de continuer :
1. Je lis ce fichier d'abord
2. Je vois ce que Cursor a fait
3. Je continue là où il s'est arrêté

---

## 🔗 FICHIERS CLÉS

- `/src/app/page.tsx` - Page principale
- `/src/components/` - Tous les composants
- `/src/i18n/locales/` - Traductions
- `/PROJECT_CONTEXT.md` - Contexte complet
