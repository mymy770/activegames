-- Migration: Ajouter preferred_locale aux contacts
-- Cette colonne permet de stocker la langue préférée du contact pour les communications

-- Ajouter la colonne preferred_locale à la table contacts
-- Valeurs possibles: 'he' (hébreu - défaut), 'fr' (français), 'en' (anglais)
ALTER TABLE contacts
ADD COLUMN IF NOT EXISTS preferred_locale VARCHAR(5) DEFAULT 'he' NOT NULL;

-- Ajouter un commentaire pour documentation
COMMENT ON COLUMN contacts.preferred_locale IS 'Langue préférée du contact pour les emails et communications (he, fr, en)';

-- Index pour faciliter les requêtes par langue si nécessaire
CREATE INDEX IF NOT EXISTS idx_contacts_preferred_locale ON contacts(preferred_locale);
