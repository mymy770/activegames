-- Ajouter colonne body_html pour stocker le contenu complet de l'email
ALTER TABLE email_logs ADD COLUMN IF NOT EXISTS body_html TEXT;
