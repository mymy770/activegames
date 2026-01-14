# Active Games World - Copie Next.js

Copie fidèle du site [activegamesworld.com](https://activegamesworld.com) en Next.js 15 / React 19 / Tailwind CSS.

## 🚀 Stack Technique

- **Framework**: Next.js 15 (App Router)
- **UI**: React 19
- **Styling**: Tailwind CSS 3.4
- **Animations**: Framer Motion
- **Icons**: Lucide React
- **Langues**: EN, FR, HE (avec support RTL)

## 📁 Structure du Projet

```
active-games-copie/
├── public/
│   ├── images/
│   │   ├── logo.png
│   │   ├── contact-image.png
│   │   └── games/          # Thumbnails et images popup
│   └── videos/             # Vidéos des jeux
├── src/
│   ├── app/
│   │   ├── globals.css     # Styles globaux + effets néon
│   │   ├── layout.tsx      # Layout principal
│   │   └── page.tsx        # Page d'accueil
│   ├── components/
│   │   ├── Header.tsx      # Navigation + sélecteur de langue
│   │   ├── HeroSection.tsx # Section héro
│   │   ├── GamesSection.tsx # Grille des 9 jeux
│   │   ├── WhyChooseUsSection.tsx
│   │   ├── FranchiseSection.tsx
│   │   ├── ContactSection.tsx
│   │   ├── Footer.tsx
│   │   └── WhatsAppButton.tsx
│   ├── data/
│   │   └── games.ts        # Données des jeux + URLs originales
│   └── i18n/
│       ├── index.ts        # Configuration i18n
│       └── locales/
│           ├── en.json     # Anglais
│           ├── fr.json     # Français
│           └── he.json     # Hébreu (RTL)
└── download-assets.sh      # Script pour télécharger les assets
```

## 🛠️ Installation

### 1. Télécharger les assets (images & vidéos)

```bash
chmod +x download-assets.sh
./download-assets.sh
```

### 2. Installer les dépendances

```bash
npm install
```

### 3. Lancer le serveur de développement

```bash
npm run dev
```

Ouvrir [http://localhost:3000](http://localhost:3000)

## 🎯 TODO pour Cursor

- [ ] Connecter le formulaire de contact (API route ou service externe)
- [ ] Optimiser les images avec next/image (télécharger en local)
- [ ] Ajouter les vidéos en autoplay dans les cartes de jeux
- [ ] Configurer le déploiement Vercel
- [ ] Ajouter les meta tags SEO dynamiques par langue
- [ ] Connecter Supabase si nécessaire (analytics, formulaires)

## 🌐 Langues Supportées

| Langue | Code | Direction |
|--------|------|-----------|
| English | en | LTR |
| Français | fr | LTR |
| עברית | he | RTL |

## 📞 Contact Original

- WhatsApp: +971 585 682 770
- Email: contact@activegamesworld.com

---

**Créé par Claude** | Prêt pour Cursor 🚀
