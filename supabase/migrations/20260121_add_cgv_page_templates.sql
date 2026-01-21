-- Migration pour ajouter les templates de la page CGV validation
-- Ces templates contrôlent l'apparence de la page /cgv/[token] que le client voit
-- quand il clique sur le lien de validation CGV dans son email

-- Templates pour les réservations de JEU (GAME)
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, created_at, updated_at)
VALUES
(
  'cgv_page_game_he',
  'CGV Page - Jeu (Hebrew)',
  'Template de la page de validation CGV pour les jeux en Hébreu',
  '',
  '<!-- Template CGV Page Game Hebrew - Géré dynamiquement par le code React -->',
  true,
  NOW(),
  NOW()
),
(
  'cgv_page_game_en',
  'CGV Page - Game (English)',
  'Template de la page de validation CGV pour les jeux en Anglais',
  '',
  '<!-- Template CGV Page Game English - Géré dynamiquement par le code React -->',
  true,
  NOW(),
  NOW()
),
(
  'cgv_page_game_fr',
  'CGV Page - Jeu (French)',
  'Template de la page de validation CGV pour les jeux en Français',
  '',
  '<!-- Template CGV Page Game French - Géré dynamiquement par le code React -->',
  true,
  NOW(),
  NOW()
)
ON CONFLICT (code) DO NOTHING;

-- Templates pour les réservations d'ÉVÉNEMENT (EVENT)
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, created_at, updated_at)
VALUES
(
  'cgv_page_event_he',
  'CGV Page - Événement (Hebrew)',
  'Template de la page de validation CGV pour les événements en Hébreu',
  '',
  '<!-- Template CGV Page Event Hebrew - Géré dynamiquement par le code React -->',
  true,
  NOW(),
  NOW()
),
(
  'cgv_page_event_en',
  'CGV Page - Event (English)',
  'Template de la page de validation CGV pour les événements en Anglais',
  '',
  '<!-- Template CGV Page Event English - Géré dynamiquement par le code React -->',
  true,
  NOW(),
  NOW()
),
(
  'cgv_page_event_fr',
  'CGV Page - Événement (French)',
  'Template de la page de validation CGV pour les événements en Français',
  '',
  '<!-- Template CGV Page Event French - Géré dynamiquement par le code React -->',
  true,
  NOW(),
  NOW()
)
ON CONFLICT (code) DO NOTHING;
