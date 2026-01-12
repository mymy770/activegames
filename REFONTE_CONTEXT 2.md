# 🎯 REFONTE ACTIVE GAMES - Contexte Complet

> **Créé par Claude le 10/01/2026**
> **Pour que Cursor comprenne les modifications**

---

## 📋 LA DEMANDE DE JONATHAN

Jonathan veut adapter le site Active Games pour un **franchisé** à Rishon LeZion (Israël), pas pour le franchiseur (Dubai).

**Site actuel** (franchiseur) : https://activegamesworld.com
**Référence franchisé** : https://activegames.co.il

---

## 🔍 ANALYSE : Franchiseur vs Franchisé

| Aspect | Franchiseur (avant) | Franchisé (après) |
|--------|---------------------|-------------------|
| **Cible** | B2B (vendre des franchises) | B2C (attirer des clients) |
| **Langues** | 9 langues | HE + EN seulement |
| **Jeux** | 9 jeux (avec Control) | 8 jeux (sans Control) |
| **Sections** | Why Choose Us, Franchise, ROI... | Concept, Prix, Packages |
| **Contact** | Dubai +971 | Rishon LeZion 03 551-2277 |
| **Message** | "Investissez dans une franchise" | "Venez jouer chez nous" |

---

## 🎨 PROBLÈME DESIGN IDENTIFIÉ

Sur le site actuel, les cartes de jeux ont le **texte PAR-DESSUS la vidéo** (overlay).

Sur le site franchisé (activegames.co.il), le **texte est EN DESSOUS de la vidéo**.

```
AVANT (franchiseur) :          APRÈS (franchisé) :
┌─────────────────┐            ┌─────────────────┐
│                 │            │                 │
│   [VIDÉO]       │            │   [VIDÉO]       │
│   Titre ────────│            │                 │
│   Description   │            ├─────────────────┤
│                 │            │ Titre           │
└─────────────────┘            │ Description     │
                               │ Plus d'infos →  │
                               └─────────────────┘
```

---

## 📁 CE QUE J'AI MODIFIÉ

### 1. GamesSection.tsx
- Nouveau layout : texte EN DESSOUS des vidéos
- Grille 4 colonnes (au lieu de 3)
- Filtré pour exclure "Control" (8 jeux)
- Vidéos autoplay (pas seulement au hover)

### 2. ConceptSection.tsx (NOUVEAU)
- Explique le concept du jeu
- 6 icônes : 6 joueurs, 60 min, bracelet, 8 salles, modes, stratégie
- Paragraphes explicatifs traduits de activegames.co.il

### 3. PricingSection.tsx (NOUVEAU)
- Prix : 100₪/heure/personne
- Packages événements :
  - 15+ participants : 130₪/personne
  - 30+ participants : 120₪/personne
- Inclus : salle privée, pizza, boissons...

### 4. Header.tsx
- Nouveau menu : Concept → Games → Pricing → Contact
- Seulement 2 langues (HE/EN)

### 5. ContactSection.tsx
- Adresse : Aliyat HaNoar 1, Rishon LeZion
- Téléphone : 03 551-2277
- Email : contact@activegames.co.il
- Mention "Powered by Laser City"

### 6. Footer.tsx
- Liste des 8 jeux
- Lien Laser City
- Navigation mise à jour

### 7. Traductions (en.json, he.json)
- Tout le contenu adapté pour franchisé
- Supprimé : franchise, ROI, why choose us
- Ajouté : concept, pricing, infos locales

### 8. i18n/index.ts
- Seulement HE + EN (supprimé FR et autres)
- Hébreu par défaut

### 9. page.tsx
- Nouvelle structure :
  ```
  Hero → Concept → Games → Pricing → Contact
  ```
- Supprimé : WhyChooseUsSection, FranchiseSection

---

## 🗂️ SECTIONS SUPPRIMÉES

- **WhyChooseUsSection** : Arguments pour franchisés (20 ans d'expérience, support, ROI...)
- **FranchiseSection** : Offre de franchise (territoires, investissement...)

Ces sections n'ont pas de sens pour un client qui veut juste jouer !

---

## 💾 BACKUP

Sauvegarde créée dans :
```
/Users/john/JARVIS/active-games-backup-20260110/
```

---

## ✅ À VÉRIFIER PAR CURSOR

1. `npm run dev:3003` → Le site démarre sans erreur ?
2. Les cartes jeux → Texte bien EN DESSOUS des vidéos ?
3. Section Concept → 6 icônes + paragraphes ?
4. Section Pricing → Prix 100₪ + 2 packages ?
5. Header → 4 liens (Concept, Games, Pricing, Contact) ?
6. Switch langue → HE ↔ EN fonctionne ?
7. Hébreu → RTL correct ?
8. Contact → Infos Rishon LeZion ?

---

## 🚀 SI TOUT EST OK

```bash
git add .
git commit -m "Refonte site franchisé Rishon LeZion"
git push
```

Vercel déploie automatiquement.

---

## ❓ SI ERREURS

1. Lire les erreurs dans le terminal
2. Mettre à jour AI_SYNC.md avec les erreurs
3. Claude corrigera dans la prochaine conversation

