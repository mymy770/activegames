-- Manual seed SQL for Prisma Studio or direct SQL execution
-- Run this via Prisma Studio > Execute SQL or sqlite3 dev.db < manual-seed.sql

-- Insert Branches
INSERT INTO "branches" ("id", "name", "address", "timezone", "createdAt", "updatedAt") VALUES
  ('branch-herzliya', 'Herzliya', '123 Herzl Street, Herzliya', 'Asia/Jerusalem', datetime('now'), datetime('now')),
  ('branch-telaviv', 'Tel Aviv', '456 Dizengoff Street, Tel Aviv', 'Asia/Jerusalem', datetime('now'), datetime('now'))
ON CONFLICT DO NOTHING;

-- Insert Settings for Herzliya
INSERT INTO "settings" (
  "id", "branchId", "maxConcurrentPlayers", "slotMinutes", "gameDurationMinutes",
  "eventRoomDurationMinutes", "eventGameDurationMinutes", "bufferBeforeMinutes",
  "bufferAfterMinutes", "minEventParticipants", "eventRoomId", "eventRoomCapacity",
  "createdAt", "updatedAt"
) VALUES (
  'settings-herzliya', 'branch-herzliya', 80, 15, 60, 120, 60, 30, 30, 15, NULL, NULL,
  datetime('now'), datetime('now')
) ON CONFLICT DO NOTHING;

-- Insert Settings for Tel Aviv
INSERT INTO "settings" (
  "id", "branchId", "maxConcurrentPlayers", "slotMinutes", "gameDurationMinutes",
  "eventRoomDurationMinutes", "eventGameDurationMinutes", "bufferBeforeMinutes",
  "bufferAfterMinutes", "minEventParticipants", "eventRoomId", "eventRoomCapacity",
  "createdAt", "updatedAt"
) VALUES (
  'settings-telaviv', 'branch-telaviv', 80, 15, 60, 120, 60, 30, 30, 15, NULL, NULL,
  datetime('now'), datetime('now')
) ON CONFLICT DO NOTHING;
