-- ============================================================================
-- INDEX DE PERFORMANCE POUR ACCÉLÉRER LES REQUÊTES
-- ============================================================================

-- Index sur bookings pour les requêtes par branche et date
CREATE INDEX IF NOT EXISTS idx_bookings_branch_date
ON bookings(branch_id, start_datetime);

CREATE INDEX IF NOT EXISTS idx_bookings_branch_status
ON bookings(branch_id, status);

-- Index sur booking_slots pour les jointures
CREATE INDEX IF NOT EXISTS idx_booking_slots_booking_id
ON booking_slots(booking_id);

-- Index sur game_sessions pour les jointures
CREATE INDEX IF NOT EXISTS idx_game_sessions_booking_id
ON game_sessions(booking_id);

-- Index sur booking_contacts pour les jointures
CREATE INDEX IF NOT EXISTS idx_booking_contacts_booking_id
ON booking_contacts(booking_id);

CREATE INDEX IF NOT EXISTS idx_booking_contacts_contact_id
ON booking_contacts(contact_id);

-- Index sur contacts pour les recherches par téléphone
CREATE INDEX IF NOT EXISTS idx_contacts_branch_phone
ON contacts(branch_id_main, phone);

CREATE INDEX IF NOT EXISTS idx_contacts_branch_status
ON contacts(branch_id_main, status);

-- Index sur orders pour les requêtes par branche
CREATE INDEX IF NOT EXISTS idx_orders_branch_id
ON orders(branch_id);

CREATE INDEX IF NOT EXISTS idx_orders_booking_id
ON orders(booking_id);

CREATE INDEX IF NOT EXISTS idx_orders_branch_status
ON orders(branch_id, status);

-- Index sur activity_logs pour les requêtes par branche et date
CREATE INDEX IF NOT EXISTS idx_activity_logs_branch_created
ON activity_logs(branch_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_activity_logs_created_at
ON activity_logs(created_at DESC);

-- Index sur email_logs pour les requêtes
CREATE INDEX IF NOT EXISTS idx_email_logs_branch_created
ON email_logs(branch_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_email_logs_entity
ON email_logs(entity_type, entity_id);

-- Vérifier les index créés
SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
AND tablename IN ('bookings', 'booking_slots', 'game_sessions', 'booking_contacts', 'contacts', 'orders', 'activity_logs', 'email_logs')
ORDER BY tablename, indexname;
