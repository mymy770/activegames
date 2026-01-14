# 🎮 ACTIVE GAMES - CONTEXTE PROJET

> **Fichier à lire en premier** pour toute nouvelle conversation Claude
> **Chemin** : `/Users/john/JARVIS/active-games/PROJET_CONTEXT.md`
> **Dernière mise à jour** : 10 janvier 2026 - 22:30

---

## 🎯 RÉSUMÉ RAPIDE

| Info | Valeur |
|------|--------|
| **Projet** | Migration site WordPress → Next.js 15 |
| **Site original** | https://activegamesworld.com/ |
| **URL Production** | https://active-games-nine.vercel.app |
| **GitHub** | https://github.com/skytoone55/active-games |
| **Status** | ✅ DÉPLOYÉ ET FONCTIONNEL |

---

## 📁 STRUCTURE DU PROJET

```
/Users/john/JARVIS/active-games/          ← PROJET ACTIF
/Users/john/JARVIS/active-games-project/  ← Backup ancien site
```

### Fichiers importants

| Fichier | Rôle |
|---------|------|
| `PROJET_CONTEXT.md` | Ce fichier - contexte pour Claude |
| `AI_SYNC.md` | Communication Claude ↔ Cursor |
| `.cursorrules` | Instructions pour Cursor |
| `/Users/john/JARVIS/MEMOIRE_COMPLETE_JARVIS.md` | Mémoire globale (toutes les clés) |

---

## 🛠️ STACK TECHNIQUE

- **Framework** : Next.js 15.5.9
- **React** : 19
- **TypeScript** : Oui
- **CSS** : Tailwind + effets néon custom
- **Animations** : Framer Motion
- **i18n** : 3 langues (EN, FR, HE avec RTL)
- **Déploiement** : Vercel (auto-deploy via GitHub)

---

## 🌍 LANGUES

| Code | Langue | Direction |
|------|--------|-----------|
| `en` | Anglais | LTR |
| `fr` | Français | LTR |
| `he` | Hébreu | RTL |

Les traductions sont dans `/src/i18n/locales/`

---

## 🎨 DESIGN

- **Thème** : Dark avec effets néon (vert/cyan/violet)
- **Vidéos** : 
  - Hero : `grid.mp4` en background
  - Cartes jeux : Vidéo au hover
  - Modal : Vidéo autoplay
- **Effets** : Glow néon, animations Framer Motion

### Couleurs principales

```css
--neon-green: #00ff88
--neon-cyan: #00f5ff  
--neon-purple: #b366ff
--dark-bg: #0a0a0a
```

---

## 📦 COMPOSANTS (8)

| Composant | Description |
|-----------|-------------|
| `Header.tsx` | Navigation + sélecteur langue |
| `HeroSection.tsx` | Vidéo background + titre |
| `GamesSection.tsx` | Grille 9 jeux + modal vidéo |
| `WhyChooseUsSection.tsx` | 4 points forts |
| `FranchiseSection.tsx` | Section franchise |
| `ContactSection.tsx` | Formulaire contact |
| `Footer.tsx` | Pied de page |
| `WhatsAppButton.tsx` | Bouton flottant |

---

## 🎮 JEUX (9)

1. Human Pinball
2. Robo Soccer
3. Wrecking Ball
4. Sticky Wall
5. Football Darts
6. Wipe Out
7. Climbing Wall
8. Football Pool
9. Ninja Course

Données dans `/src/data/games.ts`

---

## 🔄 WORKFLOW DÉPLOIEMENT

```
1. Claude modifie le code (filesystem MCP)
2. Claude fait git push (GitHub MCP)
3. Vercel déploie automatiquement
4. Site en production en ~1 minute
```

**Pas besoin de Cursor pour déployer !**

---

## ✅ CE QUI EST FAIT

- [x] Structure Next.js 15 complète
- [x] 8 composants React
- [x] i18n 3 langues (EN/FR/HE)
- [x] Support RTL pour l'hébreu
- [x] Effets néon CSS
- [x] Vidéos Hero + hover cartes + modal
- [x] Responsive design
- [x] Déploiement Vercel
- [x] GitHub auto-deploy configuré

---

## ⏳ TODO

- [ ] Formulaire contact fonctionnel (backend)
- [ ] SEO meta tags
- [ ] Analytics (Google Analytics ou Plausible)
- [ ] Page mentions légales
- [ ] Optimisation images (WebP)
- [ ] Sitemap.xml

---

## 🔑 ACCÈS RAPIDES

### Supabase (Active Games)

```bash
NEXT_PUBLIC_SUPABASE_URL=https://mypstbvbekfwyaaewpfe.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15cHN0YnZiZWtmd3lhYWV3cGZlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc5NTk2NjIsImV4cCI6MjA4MzUzNTY2Mn0.i0_ja9bcxmqVhka-CRq_Jb54KCaTGHTetatLnbLnfeM
```

### Contact

- **Email** : contact@activegamesworld.com
- **WhatsApp** : +971 585 682 770

---

## 📝 COMMANDES UTILES

```bash
# Développement local
cd /Users/john/JARVIS/active-games
npm run dev        # Lance sur localhost:3000

# Build
npm run build

# Git (si GitHub MCP ne marche pas)
git add .
git commit -m "message"
git push origin main
```

---

## 🚨 POINTS D'ATTENTION

1. **Port** : Utiliser 3003 si 3000-3002 sont occupés (`npm run dev -- -p 3003`)
2. **RTL** : Toujours tester l'hébreu (direction texte inversée)
3. **Vidéos** : Fichiers lourds dans `/public/videos/`
4. **GitHub** : Auto-deploy = chaque push va en production !

---

## 💬 POUR CLAUDE - INSTRUCTIONS

Quand Jonathan te parle de ce projet :

1. **Lis ce fichier** pour avoir le contexte
2. **Lis `AI_SYNC.md`** pour voir les dernières actions
3. **Tu as accès** aux fichiers via filesystem MCP
4. **Tu peux push** via GitHub MCP (après config)
5. **Mémoire globale** dans `/Users/john/JARVIS/MEMOIRE_COMPLETE_JARVIS.md`

### MCP disponibles

- `filesystem` → Lire/écrire fichiers dans /Users/john/JARVIS
- `github` → Push, commits, branches
- `supabase-jarvis` → Base de données Active Games
- `Vercel` → Voir déploiements

---

**Créé par Claude le 10/01/2026**
