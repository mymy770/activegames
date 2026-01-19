-- Migration: Email System Tables
-- Date: 2024-01-18
-- Description: Creates tables for email logs and email templates with multi-language support

-- =====================================================
-- 1. EMAIL_LOGS TABLE
-- Tracks all sent emails with their status
-- =====================================================

CREATE TABLE IF NOT EXISTS email_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  recipient_email TEXT NOT NULL,
  recipient_name TEXT,
  template_id UUID,
  template_code TEXT,
  subject TEXT NOT NULL,
  body_preview TEXT,
  entity_type TEXT CHECK (entity_type IN ('booking', 'order', 'contact')),
  entity_id UUID,
  branch_id UUID REFERENCES branches(id),
  attachments JSONB DEFAULT '[]'::jsonb,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'sent', 'delivered', 'failed', 'bounced')),
  error_message TEXT,
  metadata JSONB DEFAULT '{}'::jsonb,
  sent_at TIMESTAMP WITH TIME ZONE,
  triggered_by UUID REFERENCES users(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for email_logs
CREATE INDEX IF NOT EXISTS idx_email_logs_status ON email_logs(status);
CREATE INDEX IF NOT EXISTS idx_email_logs_branch ON email_logs(branch_id);
CREATE INDEX IF NOT EXISTS idx_email_logs_entity ON email_logs(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_email_logs_created ON email_logs(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_email_logs_recipient ON email_logs(recipient_email);

-- =====================================================
-- 2. EMAIL_TEMPLATES TABLE
-- Stores reusable email templates with variables
-- =====================================================

CREATE TABLE IF NOT EXISTS email_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  subject_template TEXT NOT NULL,
  body_template TEXT NOT NULL,
  is_active BOOLEAN DEFAULT true,
  is_system BOOLEAN DEFAULT false,
  branch_id UUID REFERENCES branches(id),
  available_variables JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_by UUID REFERENCES users(id)
);

-- Indexes for email_templates
CREATE INDEX IF NOT EXISTS idx_email_templates_code ON email_templates(code);
CREATE INDEX IF NOT EXISTS idx_email_templates_active ON email_templates(is_active);
CREATE INDEX IF NOT EXISTS idx_email_templates_branch ON email_templates(branch_id);

-- =====================================================
-- 3. UPDATED_AT TRIGGERS
-- Auto-update updated_at on row changes
-- =====================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for email_logs
DROP TRIGGER IF EXISTS update_email_logs_updated_at ON email_logs;
CREATE TRIGGER update_email_logs_updated_at
  BEFORE UPDATE ON email_logs
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Trigger for email_templates
DROP TRIGGER IF EXISTS update_email_templates_updated_at ON email_templates;
CREATE TRIGGER update_email_templates_updated_at
  BEFORE UPDATE ON email_templates
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- 4. RLS POLICIES
-- Row Level Security for both tables
-- =====================================================

-- Enable RLS
ALTER TABLE email_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE email_templates ENABLE ROW LEVEL SECURITY;

-- email_logs policies
DROP POLICY IF EXISTS email_logs_select_policy ON email_logs;
DROP POLICY IF EXISTS email_logs_insert_policy ON email_logs;
DROP POLICY IF EXISTS email_logs_update_policy ON email_logs;
DROP POLICY IF EXISTS email_logs_delete_policy ON email_logs;

CREATE POLICY "email_logs_select_policy" ON email_logs
  FOR SELECT
  USING (true);

CREATE POLICY "email_logs_insert_policy" ON email_logs
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "email_logs_update_policy" ON email_logs
  FOR UPDATE
  USING (true);

CREATE POLICY "email_logs_delete_policy" ON email_logs
  FOR DELETE
  USING (true);

-- email_templates policies
DROP POLICY IF EXISTS email_templates_select_policy ON email_templates;
DROP POLICY IF EXISTS email_templates_insert_policy ON email_templates;
DROP POLICY IF EXISTS email_templates_update_policy ON email_templates;
DROP POLICY IF EXISTS email_templates_delete_policy ON email_templates;

CREATE POLICY "email_templates_select_policy" ON email_templates
  FOR SELECT
  USING (true);

CREATE POLICY "email_templates_insert_policy" ON email_templates
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "email_templates_update_policy" ON email_templates
  FOR UPDATE
  USING (true);

CREATE POLICY "email_templates_delete_policy" ON email_templates
  FOR DELETE
  USING (is_system = false);

-- =====================================================
-- 5. DELETE OLD TEMPLATE AND INSERT NEW MULTI-LANGUAGE TEMPLATES
-- =====================================================

-- Delete old template
DELETE FROM email_templates WHERE code = 'booking_confirmation';

-- =====================================================
-- FRENCH TEMPLATE (Default)
-- =====================================================
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, is_system, available_variables)
VALUES (
  'booking_confirmation_fr',
  'Confirmation de réservation (FR)',
  'Email envoyé automatiquement lors de la confirmation d''une réservation - Version française',
  'Réservation Confirmée - Réf. {{booking_reference}}',
  '<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Confirmation de réservation</title>
</head>
<body style="margin: 0; padding: 0; background-color: #1a1a2e; font-family: Segoe UI, Tahoma, Geneva, Verdana, sans-serif;">
  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: #1a1a2e;">
    <tr>
      <td align="center" style="padding: 40px 20px;">
        <table role="presentation" width="600" cellspacing="0" cellpadding="0" style="background-color: #252540; border-radius: 16px; overflow: hidden; border: 2px solid rgba(0, 240, 255, 0.3); box-shadow: 0 0 30px rgba(0, 240, 255, 0.2);">

          <!-- Header with logos -->
          <tr>
            <td style="background: linear-gradient(135deg, #1a1a2e 0%, #252540 100%); padding: 30px; text-align: center; border-bottom: 1px solid rgba(0, 240, 255, 0.2);">
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
                <tr>
                  <td style="text-align: center;">
                    <img src="{{logo_activegames_url}}" alt="ActiveGames" style="max-height: 50px; margin: 0 15px;" />
                    <img src="{{logo_lasercity_url}}" alt="Laser City" style="max-height: 50px; margin: 0 15px;" />
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Main content -->
          <tr>
            <td style="padding: 40px 30px;">
              <!-- Success icon -->
              <div style="text-align: center; margin-bottom: 25px;">
                <div style="display: inline-block; background-color: rgba(0, 240, 255, 0.15); border-radius: 50%; width: 80px; height: 80px; line-height: 80px;">
                  <span style="font-size: 40px; color: #00f0ff;">✓</span>
                </div>
              </div>

              <h1 style="color: #00f0ff; font-size: 28px; margin: 0 0 10px 0; text-align: center; font-weight: bold; letter-spacing: 2px;">
                RÉSERVATION CONFIRMÉE !
              </h1>

              <p style="color: #a0a0b0; font-size: 16px; line-height: 1.6; margin: 0 0 30px 0; text-align: center;">
                Merci pour votre réservation
              </p>

              <!-- Reference number -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom: 25px;">
                <tr>
                  <td style="background-color: rgba(0, 240, 255, 0.1); border: 1px solid rgba(0, 240, 255, 0.3); border-radius: 12px; padding: 20px; text-align: center;">
                    <p style="color: #a0a0b0; font-size: 14px; margin: 0 0 8px 0;">Numéro de réservation</p>
                    <p style="color: #00f0ff; font-size: 28px; font-weight: bold; margin: 0; letter-spacing: 3px;">{{booking_reference}}</p>
                  </td>
                </tr>
              </table>

              <!-- Booking details card -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 25px;">
                    <h2 style="color: #00f0ff; font-size: 18px; margin: 0 0 20px 0; font-weight: bold;">
                      Récapitulatif
                    </h2>

                    <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Lieu</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{branch_name}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Type</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{booking_type}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Participants</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{participants}} personnes</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Date</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{booking_date}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0;">Heure</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; text-align: right;">{{booking_time}}</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>

              <!-- Client info -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 20px;">
                    <p style="color: #a0a0b0; margin: 0 0 5px 0; font-size: 14px;">Réservé au nom de</p>
                    <p style="color: #ffffff; font-weight: bold; margin: 0; font-size: 16px;">{{client_name}}</p>
                  </td>
                </tr>
              </table>

              <!-- Branch address -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(0, 240, 255, 0.08); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 20px;">
                    <p style="color: #00f0ff; font-size: 16px; font-weight: bold; margin: 0 0 10px 0;">
                      📍 Adresse
                    </p>
                    <p style="color: #ffffff; margin: 0 0 10px 0; line-height: 1.5;">
                      {{branch_address}}
                    </p>
                    <p style="color: #00f0ff; margin: 0;">
                      📞 {{branch_phone}}
                    </p>
                  </td>
                </tr>
              </table>

              <!-- Important notes -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(245, 158, 11, 0.1); border-radius: 12px; border: 1px solid rgba(245, 158, 11, 0.3);">
                <tr>
                  <td style="padding: 20px;">
                    <p style="color: #fbbf24; font-size: 14px; font-weight: bold; margin: 0 0 12px 0;">⚠️ Informations importantes</p>
                    <ul style="color: #d4d4d8; margin: 0; padding-left: 20px; font-size: 14px; line-height: 1.8;">
                      <li>Arrivez 15 minutes avant l''heure prévue</li>
                      <li>Portez des vêtements confortables</li>
                      <li>Chaussures fermées obligatoires</li>
                    </ul>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Footer -->
          <tr>
            <td style="background-color: #1a1a2e; padding: 25px 30px; text-align: center; border-top: 1px solid rgba(0, 240, 255, 0.2);">
              <p style="color: #a0a0b0; margin: 0 0 10px 0; font-size: 14px;">
                Merci d''avoir choisi ActiveGames !
              </p>
              <p style="color: #606070; margin: 0; font-size: 12px;">
                © {{current_year}} ActiveGames. Tous droits réservés.
              </p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>',
  true,
  true,
  '["booking_reference", "booking_date", "booking_time", "participants", "booking_type", "branch_name", "branch_address", "branch_phone", "client_name", "client_email", "logo_activegames_url", "logo_lasercity_url", "current_year"]'::jsonb
)
ON CONFLICT (code) DO UPDATE SET
  body_template = EXCLUDED.body_template,
  subject_template = EXCLUDED.subject_template,
  name = EXCLUDED.name,
  updated_at = NOW();

-- =====================================================
-- ENGLISH TEMPLATE
-- =====================================================
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, is_system, available_variables)
VALUES (
  'booking_confirmation_en',
  'Booking Confirmation (EN)',
  'Email sent automatically when a booking is confirmed - English version',
  'Booking Confirmed - Ref. {{booking_reference}}',
  '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Booking Confirmation</title>
</head>
<body style="margin: 0; padding: 0; background-color: #1a1a2e; font-family: Segoe UI, Tahoma, Geneva, Verdana, sans-serif;">
  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: #1a1a2e;">
    <tr>
      <td align="center" style="padding: 40px 20px;">
        <table role="presentation" width="600" cellspacing="0" cellpadding="0" style="background-color: #252540; border-radius: 16px; overflow: hidden; border: 2px solid rgba(0, 240, 255, 0.3); box-shadow: 0 0 30px rgba(0, 240, 255, 0.2);">

          <!-- Header with logos -->
          <tr>
            <td style="background: linear-gradient(135deg, #1a1a2e 0%, #252540 100%); padding: 30px; text-align: center; border-bottom: 1px solid rgba(0, 240, 255, 0.2);">
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
                <tr>
                  <td style="text-align: center;">
                    <img src="{{logo_activegames_url}}" alt="ActiveGames" style="max-height: 50px; margin: 0 15px;" />
                    <img src="{{logo_lasercity_url}}" alt="Laser City" style="max-height: 50px; margin: 0 15px;" />
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Main content -->
          <tr>
            <td style="padding: 40px 30px;">
              <!-- Success icon -->
              <div style="text-align: center; margin-bottom: 25px;">
                <div style="display: inline-block; background-color: rgba(0, 240, 255, 0.15); border-radius: 50%; width: 80px; height: 80px; line-height: 80px;">
                  <span style="font-size: 40px; color: #00f0ff;">✓</span>
                </div>
              </div>

              <h1 style="color: #00f0ff; font-size: 28px; margin: 0 0 10px 0; text-align: center; font-weight: bold; letter-spacing: 2px;">
                BOOKING CONFIRMED!
              </h1>

              <p style="color: #a0a0b0; font-size: 16px; line-height: 1.6; margin: 0 0 30px 0; text-align: center;">
                Thank you for your reservation
              </p>

              <!-- Reference number -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom: 25px;">
                <tr>
                  <td style="background-color: rgba(0, 240, 255, 0.1); border: 1px solid rgba(0, 240, 255, 0.3); border-radius: 12px; padding: 20px; text-align: center;">
                    <p style="color: #a0a0b0; font-size: 14px; margin: 0 0 8px 0;">Booking Number</p>
                    <p style="color: #00f0ff; font-size: 28px; font-weight: bold; margin: 0; letter-spacing: 3px;">{{booking_reference}}</p>
                  </td>
                </tr>
              </table>

              <!-- Booking details card -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 25px;">
                    <h2 style="color: #00f0ff; font-size: 18px; margin: 0 0 20px 0; font-weight: bold;">
                      Summary
                    </h2>

                    <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Location</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{branch_name}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Type</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{booking_type}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Participants</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{participants}} people</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">Date</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: right;">{{booking_date}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0;">Time</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; text-align: right;">{{booking_time}}</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>

              <!-- Client info -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 20px;">
                    <p style="color: #a0a0b0; margin: 0 0 5px 0; font-size: 14px;">Reserved for</p>
                    <p style="color: #ffffff; font-weight: bold; margin: 0; font-size: 16px;">{{client_name}}</p>
                  </td>
                </tr>
              </table>

              <!-- Branch address -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(0, 240, 255, 0.08); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 20px;">
                    <p style="color: #00f0ff; font-size: 16px; font-weight: bold; margin: 0 0 10px 0;">
                      📍 Address
                    </p>
                    <p style="color: #ffffff; margin: 0 0 10px 0; line-height: 1.5;">
                      {{branch_address}}
                    </p>
                    <p style="color: #00f0ff; margin: 0;">
                      📞 {{branch_phone}}
                    </p>
                  </td>
                </tr>
              </table>

              <!-- Important notes -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(245, 158, 11, 0.1); border-radius: 12px; border: 1px solid rgba(245, 158, 11, 0.3);">
                <tr>
                  <td style="padding: 20px;">
                    <p style="color: #fbbf24; font-size: 14px; font-weight: bold; margin: 0 0 12px 0;">⚠️ Important Information</p>
                    <ul style="color: #d4d4d8; margin: 0; padding-left: 20px; font-size: 14px; line-height: 1.8;">
                      <li>Please arrive 15 minutes before your scheduled time</li>
                      <li>Wear comfortable clothing</li>
                      <li>Closed-toe shoes required</li>
                    </ul>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Footer -->
          <tr>
            <td style="background-color: #1a1a2e; padding: 25px 30px; text-align: center; border-top: 1px solid rgba(0, 240, 255, 0.2);">
              <p style="color: #a0a0b0; margin: 0 0 10px 0; font-size: 14px;">
                Thank you for choosing ActiveGames!
              </p>
              <p style="color: #606070; margin: 0; font-size: 12px;">
                © {{current_year}} ActiveGames. All rights reserved.
              </p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>',
  true,
  true,
  '["booking_reference", "booking_date", "booking_time", "participants", "booking_type", "branch_name", "branch_address", "branch_phone", "client_name", "client_email", "logo_activegames_url", "logo_lasercity_url", "current_year"]'::jsonb
)
ON CONFLICT (code) DO UPDATE SET
  body_template = EXCLUDED.body_template,
  subject_template = EXCLUDED.subject_template,
  name = EXCLUDED.name,
  updated_at = NOW();

-- =====================================================
-- HEBREW TEMPLATE
-- =====================================================
INSERT INTO email_templates (code, name, description, subject_template, body_template, is_active, is_system, available_variables)
VALUES (
  'booking_confirmation_he',
  'אישור הזמנה (HE)',
  'מייל שנשלח אוטומטית כשהזמנה מאושרת - גרסה עברית',
  'ההזמנה אושרה - מס'' {{booking_reference}}',
  '<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>אישור הזמנה</title>
</head>
<body style="margin: 0; padding: 0; background-color: #1a1a2e; font-family: Segoe UI, Tahoma, Geneva, Verdana, sans-serif; direction: rtl;">
  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: #1a1a2e;">
    <tr>
      <td align="center" style="padding: 40px 20px;">
        <table role="presentation" width="600" cellspacing="0" cellpadding="0" style="background-color: #252540; border-radius: 16px; overflow: hidden; border: 2px solid rgba(0, 240, 255, 0.3); box-shadow: 0 0 30px rgba(0, 240, 255, 0.2);">

          <!-- Header with logos -->
          <tr>
            <td style="background: linear-gradient(135deg, #1a1a2e 0%, #252540 100%); padding: 30px; text-align: center; border-bottom: 1px solid rgba(0, 240, 255, 0.2);">
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
                <tr>
                  <td style="text-align: center;">
                    <img src="{{logo_activegames_url}}" alt="ActiveGames" style="max-height: 50px; margin: 0 15px;" />
                    <img src="{{logo_lasercity_url}}" alt="Laser City" style="max-height: 50px; margin: 0 15px;" />
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Main content -->
          <tr>
            <td style="padding: 40px 30px;">
              <!-- Success icon -->
              <div style="text-align: center; margin-bottom: 25px;">
                <div style="display: inline-block; background-color: rgba(0, 240, 255, 0.15); border-radius: 50%; width: 80px; height: 80px; line-height: 80px;">
                  <span style="font-size: 40px; color: #00f0ff;">✓</span>
                </div>
              </div>

              <h1 style="color: #00f0ff; font-size: 28px; margin: 0 0 10px 0; text-align: center; font-weight: bold; letter-spacing: 2px;">
                ההזמנה אושרה!
              </h1>

              <p style="color: #a0a0b0; font-size: 16px; line-height: 1.6; margin: 0 0 30px 0; text-align: center;">
                תודה על ההזמנה שלך
              </p>

              <!-- Reference number -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="margin-bottom: 25px;">
                <tr>
                  <td style="background-color: rgba(0, 240, 255, 0.1); border: 1px solid rgba(0, 240, 255, 0.3); border-radius: 12px; padding: 20px; text-align: center;">
                    <p style="color: #a0a0b0; font-size: 14px; margin: 0 0 8px 0;">מספר הזמנה</p>
                    <p style="color: #00f0ff; font-size: 28px; font-weight: bold; margin: 0; letter-spacing: 3px;">{{booking_reference}}</p>
                  </td>
                </tr>
              </table>

              <!-- Booking details card -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 25px;">
                    <h2 style="color: #00f0ff; font-size: 18px; margin: 0 0 20px 0; font-weight: bold;">
                      פרטי ההזמנה
                    </h2>

                    <table role="presentation" width="100%" cellspacing="0" cellpadding="0">
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">מיקום</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{branch_name}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">סוג</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{booking_type}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">משתתפים</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{participants}} אנשים</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1);">תאריך</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.1); text-align: left;">{{booking_date}}</td>
                      </tr>
                      <tr>
                        <td style="color: #a0a0b0; padding: 10px 0;">שעה</td>
                        <td style="color: #ffffff; font-weight: bold; padding: 10px 0; text-align: left;">{{booking_time}}</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>

              <!-- Client info -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(30, 30, 50, 0.5); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 20px;">
                    <p style="color: #a0a0b0; margin: 0 0 5px 0; font-size: 14px;">הוזמן על שם</p>
                    <p style="color: #ffffff; font-weight: bold; margin: 0; font-size: 16px;">{{client_name}}</p>
                  </td>
                </tr>
              </table>

              <!-- Branch address -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(0, 240, 255, 0.08); border-radius: 12px; border: 1px solid rgba(0, 240, 255, 0.2); margin-bottom: 25px;">
                <tr>
                  <td style="padding: 20px;">
                    <p style="color: #00f0ff; font-size: 16px; font-weight: bold; margin: 0 0 10px 0;">
                      📍 כתובת
                    </p>
                    <p style="color: #ffffff; margin: 0 0 10px 0; line-height: 1.5;">
                      {{branch_address}}
                    </p>
                    <p style="color: #00f0ff; margin: 0;">
                      📞 {{branch_phone}}
                    </p>
                  </td>
                </tr>
              </table>

              <!-- Important notes -->
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background-color: rgba(245, 158, 11, 0.1); border-radius: 12px; border: 1px solid rgba(245, 158, 11, 0.3);">
                <tr>
                  <td style="padding: 20px;">
                    <p style="color: #fbbf24; font-size: 14px; font-weight: bold; margin: 0 0 12px 0;">⚠️ מידע חשוב</p>
                    <ul style="color: #d4d4d8; margin: 0; padding-right: 20px; font-size: 14px; line-height: 1.8;">
                      <li>נא להגיע 15 דקות לפני הזמן המתוכנן</li>
                      <li>לבשו בגדים נוחים</li>
                      <li>נעליים סגורות חובה</li>
                    </ul>
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <!-- Footer -->
          <tr>
            <td style="background-color: #1a1a2e; padding: 25px 30px; text-align: center; border-top: 1px solid rgba(0, 240, 255, 0.2);">
              <p style="color: #a0a0b0; margin: 0 0 10px 0; font-size: 14px;">
                תודה שבחרתם ב-ActiveGames!
              </p>
              <p style="color: #606070; margin: 0; font-size: 12px;">
                © {{current_year}} ActiveGames. כל הזכויות שמורות.
              </p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>',
  true,
  true,
  '["booking_reference", "booking_date", "booking_time", "participants", "booking_type", "branch_name", "branch_address", "branch_phone", "client_name", "client_email", "logo_activegames_url", "logo_lasercity_url", "current_year"]'::jsonb
)
ON CONFLICT (code) DO UPDATE SET
  body_template = EXCLUDED.body_template,
  subject_template = EXCLUDED.subject_template,
  name = EXCLUDED.name,
  updated_at = NOW();

-- =====================================================
-- Done!
-- =====================================================
