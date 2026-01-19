-- ============================================================================
-- VÉRIFICATION ET AJOUT DE LA COLONNE body_html
-- ============================================================================

-- Ajouter la colonne body_html si elle n'existe pas
ALTER TABLE email_logs ADD COLUMN IF NOT EXISTS body_html TEXT;

-- Vérifier le résultat
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'email_logs'
ORDER BY ordinal_position;
