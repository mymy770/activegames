# PHASE 4 : PAIEMENTS iCOUNT - AVANCEMENT

> Suivi d'implementation de la Phase 4
> Debut : 2026-01-19
> Derniere MAJ : 2026-01-19

---

## STATUT GLOBAL

| Etape | Description | Statut |
|-------|-------------|--------|
| 1 | Infrastructure & Tables | ⏳ A faire |
| 2 | Provider Abstraction Layer | ⏳ A faire |
| 3 | Page Settings Paiements | ⏳ A faire |
| 4 | Gestion des Produits | ⏳ A faire |
| 5 | Synchronisation Clients | ⏳ A faire |
| 6 | Paiements en ligne | ⏳ A faire |
| 7 | Webhooks Provider | ⏳ A faire |
| 8 | Paiements par Telephone | ⏳ A faire |
| 9 | Garantie Carte | ⏳ A faire |
| 10 | Paiements Caisse | ⏳ A faire |
| 11 | Factures | ⏳ A faire |
| 12 | Rapports | ⏳ A faire |

**Legende** : ✅ Termine | 🔄 En cours | ⏳ A faire | ❌ Bloque

---

## ETAPE 1 : Infrastructure & Tables

### Taches
- [ ] Migration SQL : Table `products`
- [ ] Migration SQL : Table `payments`
- [ ] Migration SQL : Table `payment_settings`
- [ ] Migration SQL : Table `card_tokens`
- [ ] Migration SQL : Table `invoices`
- [ ] Migration SQL : Colonnes `orders` (payment_status, total_amount, etc.)
- [ ] Migration SQL : Colonne `contacts.provider_client_id`
- [ ] Creer compte iCount TEST

### Notes
_A completer au fur et a mesure_

---

## ETAPE 2 : Provider Abstraction Layer

### Taches
- [ ] Interface `lib/payment-provider/types.ts`
- [ ] Implementation iCount : `client.ts` (auth/session)
- [ ] Implementation iCount : `clients.ts` (sync contacts)
- [ ] Implementation iCount : `products.ts` (sync produits)
- [ ] Implementation iCount : `billing.ts` (paiements)
- [ ] Implementation iCount : `paypage.ts` (liens paiement)
- [ ] Implementation iCount : `documents.ts` (factures)
- [ ] Implementation iCount : `cards.ts` (tokenisation)

### Notes
_A completer au fur et a mesure_

---

## ETAPE 3 : Page Settings Paiements

### Taches
- [ ] Composant `PaymentSettingsSection`
- [ ] Formulaire credentials (cid, user, pass)
- [ ] Bouton "Tester la connexion"
- [ ] Config mode depot (none/full/fixed/percent)
- [ ] Config regle confirmation
- [ ] Config garantie carte
- [ ] API route CRUD settings

### Notes
_A completer au fur et a mesure_

---

## ETAPE 4 : Gestion des Produits

### Taches
- [ ] Page `/admin/settings/products`
- [ ] Liste produits avec tri/filtre
- [ ] Modal creation/edition produit
- [ ] Suppression (desactivation)
- [ ] Sync auto vers iCount
- [ ] API routes CRUD produits

### Notes
_A completer au fur et a mesure_

---

## ETAPE 5 : Synchronisation Clients

### Taches
- [ ] Hook creation contact → sync iCount
- [ ] Hook modification contact → sync iCount
- [ ] Script batch contacts existants
- [ ] Stockage `provider_client_id`

### Notes
_A completer au fur et a mesure_

---

## ETAPE 6 : Paiements en ligne

### Taches
- [ ] Modification flow reservation
- [ ] Calcul montant selon deposit_mode
- [ ] Generation lien paiement iCount
- [ ] Redirection client
- [ ] Pages success/failed
- [ ] Gestion blocage temporaire (paid_only)
- [ ] CRON liberation slots expires

### Notes
_A completer au fur et a mesure_

---

## ETAPE 7 : Webhooks Provider

### Taches
- [ ] API route `POST /api/webhooks/icount`
- [ ] Validation origine
- [ ] Parsing payload
- [ ] Logique idempotente
- [ ] Update statut paiement
- [ ] Declenchement facture
- [ ] Email confirmation

### Notes
_A completer au fur et a mesure_

---

## ETAPE 8 : Paiements par Telephone

### Taches
- [ ] Modal paiement dans BookingModal
- [ ] Onglet "Nouvelle carte" (saisie)
- [ ] Onglet "Carte enregistree" (tokens)
- [ ] Choix type (full/deposit/garantie)
- [ ] Appel API charge/preauth
- [ ] Enregistrement paiement
- [ ] Option tokeniser carte

### Notes
_A completer au fur et a mesure_

---

## ETAPE 9 : Garantie Carte

### Taches
- [ ] Pre-autorisation via modal
- [ ] Enregistrement `is_guarantee = true`
- [ ] CRON liberation automatique
- [ ] Bouton "Debiter garantie"
- [ ] Appel `chargePreAuth()`

### Notes
_A completer au fur et a mesure_

---

## ETAPE 10 : Paiements Caisse

### Taches
- [ ] Bouton "Paye caisse" dans modal
- [ ] Enregistrement `method = 'cash_register'`
- [ ] Liberation garantie si existante

### Notes
_A completer au fur et a mesure_

---

## ETAPE 11 : Factures

### Taches
- [ ] Generation auto apres paiement
- [ ] Appel `createInvoice()`
- [ ] Stockage reference locale
- [ ] Affichage lien facture

### Notes
_A completer au fur et a mesure_

---

## ETAPE 12 : Rapports

### Taches
- [ ] Page `/admin/payments`
- [ ] Liste avec filtres
- [ ] Totaux par periode
- [ ] Distinction methodes
- [ ] Export CSV

### Notes
_A completer au fur et a mesure_

---

## JOURNAL DE BORD

### 2026-01-19
- Creation de la branche `payment` depuis `main` (commit `9f35c98`)
- Recuperation de la roadmap Phase 4
- Debut implementation propre, etape par etape

---

*Document mis a jour par Jeremy & Claude*
