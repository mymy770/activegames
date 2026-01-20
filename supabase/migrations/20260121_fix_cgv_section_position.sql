-- Migration pour corriger la position de {{cgv_section}} dans les templates email
-- Le CGV doit être placé juste après le numéro de réservation ({{booking_reference}}),
-- pas après le devis ({{offer_section}})

-- Étape 1: Retirer {{cgv_section}} de sa position actuelle (après {{offer_section}})
UPDATE email_templates
SET body_template = REPLACE(
  body_template,
  '{{offer_section}}{{cgv_section}}',
  '{{offer_section}}'
)
WHERE code LIKE 'booking_confirmation_%'
  AND body_template LIKE '%{{offer_section}}{{cgv_section}}%';

-- Étape 2: Retirer {{cgv_section}} s'il est après {{booking_reference}} (au cas où déjà là)
UPDATE email_templates
SET body_template = REPLACE(
  body_template,
  '{{booking_reference}}{{cgv_section}}',
  '{{booking_reference}}'
)
WHERE code LIKE 'booking_confirmation_%'
  AND body_template LIKE '%{{booking_reference}}{{cgv_section}}%';

-- Étape 3: Ajouter {{cgv_section}} juste après {{booking_reference}}
-- (avant le récapitulatif de la réservation)
UPDATE email_templates
SET body_template = REPLACE(
  body_template,
  '{{booking_reference}}',
  '{{booking_reference}}{{cgv_section}}'
)
WHERE code LIKE 'booking_confirmation_%'
  AND body_template LIKE '%{{booking_reference}}%'
  AND body_template NOT LIKE '%{{cgv_section}}%';
