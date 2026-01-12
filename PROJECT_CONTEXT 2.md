# PROJECT CONTEXT - Active Games World

> **CURSOR : LIS CE FICHIER EN PREMIER !**
> Créé par Claude le 10/01/2026.

---

## 🚀 DÉMARRAGE RAPIDE (1 commande)

```bash
cd /Users/john/JARVIS/active-games-copie && npm install && npm run setup
```

Cela va :
1. Installer les dépendances
2. Télécharger toutes les images et vidéos
3. Lancer le serveur sur **http://localhost:3003**

---

## 🎯 Objectif du Projet

Copie fidèle du site WordPress/Elementor [activegamesworld.com](https://activegamesworld.com) en stack moderne Next.js.

## 📊 État Actuel

### ✅ FAIT par Claude (100% complet)

| Élément | Status |
|---------|--------|
| Structure Next.js 15 | ✅ |
| Tous les composants (8) | ✅ |
| Traductions EN/FR/HE | ✅ |
| Support RTL (hébreu) | ✅ |
| Effets néon CSS | ✅ |
| Animations Framer Motion | ✅ |
| Script téléchargement assets | ✅ |
| 9 jeux avec données | ✅ |

### ⏳ À FAIRE par Cursor

1. **Formulaire de contact** → Connecter à Resend/SendGrid ou API route
2. **Vidéos autoplay** → Intégrer dans les cartes de jeux  
3. **Déploiement Vercel** → `vercel deploy`
4. **SEO** → Meta tags dynamiques par langue

---

## 📁 Structure

```
active-games-copie/
├── public/
│   ├── images/          ← Logo, contact, games (après download)
│   └── videos/          ← Vidéos des 9 jeux (après download)
├── src/
│   ├── app/
│   │   ├── globals.css  ← Styles néon
│   │   ├── layout.tsx
│   │   └── page.tsx     ← Page principale
│   ├── components/      ← 8 composants
│   ├── data/games.ts    ← Données + URLs originales
│   └── i18n/            ← 3 langues
├── scripts/
│   └── download-assets.js ← Télécharge images/vidéos
└── package.json
```

---

## 🔗 Connexions MCP Disponibles

| Service | Project ID |
|---------|------------|
| Supabase Active Games | `mypstbvbekfwyaaewpfe` |
| Vercel | Connecté |
| Filesystem | `/Users/john/JARVIS` |

---

## 🎨 Design System

### Couleurs
```css
--primary: #00f0ff    /* Cyan néon */
--secondary: #ff00ff  /* Magenta néon */
--dark: #0a0a0a       /* Fond noir */
```

### Classes CSS utiles
- `.neon-text` → Texte lumineux cyan
- `.neon-border` → Bordure lumineuse
- `.glow-button` → Bouton avec effet glow
- `.gradient-text` → Texte dégradé cyan→magenta
- `.game-card` → Carte de jeu avec hover effect

---

## 📞 Contact Business

- **WhatsApp**: +971 585 682 770
- **Email**: contact@activegamesworld.com

---

## ⚠️ Notes Importantes

1. Le port 3003 est utilisé car 3000-3002 sont pris
2. Les assets doivent être téléchargés avant le premier `npm run dev`
3. Le site original WordPress reste en production

---

**Prêt à bosser ! 🚀**
