-- Migration pour ajouter {{cgv_section}} aux templates email de confirmation de réservation
-- Cette variable permet d'afficher le lien de validation CGV pour les commandes créées par l'admin

-- Le {{cgv_section}} doit être placé juste après {{offer_section}} dans le template
-- Le code génère le HTML approprié seulement si un cgvToken est présent (commandes admin)

-- Note: Cette migration modifie les templates existants pour ajouter la variable {{cgv_section}}
-- Si le template n'a pas été personnalisé, cette variable sera simplement vide pour les réservations normales

-- Mise à jour du template booking_confirmation_fr
UPDATE email_templates
SET body_template = REPLACE(
  body_template,
  '{{offer_section}}',
  '{{offer_section}}{{cgv_section}}'
)
WHERE code = 'booking_confirmation_fr'
  AND body_template LIKE '%{{offer_section}}%'
  AND body_template NOT LIKE '%{{cgv_section}}%';

-- Mise à jour du template booking_confirmation_en
UPDATE email_templates
SET body_template = REPLACE(
  body_template,
  '{{offer_section}}',
  '{{offer_section}}{{cgv_section}}'
)
WHERE code = 'booking_confirmation_en'
  AND body_template LIKE '%{{offer_section}}%'
  AND body_template NOT LIKE '%{{cgv_section}}%';

-- Mise à jour du template booking_confirmation_he
UPDATE email_templates
SET body_template = REPLACE(
  body_template,
  '{{offer_section}}',
  '{{offer_section}}{{cgv_section}}'
)
WHERE code = 'booking_confirmation_he'
  AND body_template LIKE '%{{offer_section}}%'
  AND body_template NOT LIKE '%{{cgv_section}}%';

-- Si les templates n'ont pas {{offer_section}}, on ajoute {{cgv_section}} après le bloc booking_reference
-- C'est un fallback au cas où les templates auraient été modifiés différemment
UPDATE email_templates
SET body_template = REPLACE(
  body_template,
  '{{booking_reference}}',
  '{{booking_reference}}{{cgv_section}}'
)
WHERE code LIKE 'booking_confirmation_%'
  AND body_template NOT LIKE '%{{cgv_section}}%'
  AND body_template LIKE '%{{booking_reference}}%';
