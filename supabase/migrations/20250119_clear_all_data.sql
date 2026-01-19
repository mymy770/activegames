-- ============================================================================
-- SCRIPT DE NETTOYAGE COMPLET DES DONNÉES
-- ============================================================================

-- 1. COMPTAGE AVANT SUPPRESSION
SELECT
    'AVANT NETTOYAGE' as status,
    (SELECT COUNT(*) FROM email_logs) as email_logs,
    (SELECT COUNT(*) FROM activity_logs) as activity_logs,
    (SELECT COUNT(*) FROM game_sessions) as game_sessions,
    (SELECT COUNT(*) FROM bookings) as bookings,
    (SELECT COUNT(*) FROM orders) as orders,
    (SELECT COUNT(*) FROM contacts) as contacts;

-- 2. SUPPRESSION DES DONNÉES (ordre respectant les foreign keys)
DELETE FROM email_logs;
DELETE FROM activity_logs;
DELETE FROM game_sessions;
DELETE FROM bookings;
DELETE FROM orders;
DELETE FROM contacts;

-- 3. RAPPORT FINAL
SELECT
    'APRÈS NETTOYAGE' as status,
    (SELECT COUNT(*) FROM email_logs) as email_logs,
    (SELECT COUNT(*) FROM activity_logs) as activity_logs,
    (SELECT COUNT(*) FROM game_sessions) as game_sessions,
    (SELECT COUNT(*) FROM bookings) as bookings,
    (SELECT COUNT(*) FROM orders) as orders,
    (SELECT COUNT(*) FROM contacts) as contacts;
