# Booking Engine - Setup Guide

## Installation

1. Install dependencies:
```bash
npm install
```

2. Generate Prisma Client:
```bash
npm run db:generate
```

3. Run migrations:
```bash
npm run db:migrate
```

4. Seed database (⚠️ Currently has issues with Prisma 7.2.0 - to be fixed):
```bash
npm run db:seed
```

## Environment Variables

Create `.env` file:
```
DATABASE_URL="file:./dev.db"
ADMIN_TOKEN="your-secret-admin-token-here"
```

## Database Schema

The booking system uses Prisma with SQLite (dev) / Postgres (production).

Main models:
- `Branch`: Centers (Herzliya, Tel Aviv)
- `Settings`: Configuration per branch (capacity, durations, etc.)
- `Booking`: Reservations (GAME or EVENT)
- `BookingSlot`: 15-minute slots for capacity management
- `Deposit`: Structure for future deposit system

## Features

### Public Booking Flow
1. Select Branch
2. Select Type (GAME/EVENT)
3. Select Date + Time
4. Enter Participants Count
5. Enter Customer Info
6. Confirm (creates CONFIRMED booking directly)

### Admin
- `/admin/bookings`: List, filter, and cancel bookings
- `/admin/settings`: Edit branch settings

Authentication: Use header `x-admin-token: <ADMIN_TOKEN>`

## Key Rules

- **GAME**: 60 minutes, blocks Game Zone capacity
- **EVENT**: 120 minutes room + 60 minutes Game Zone (with 30min buffers)
- **Capacity**: Max 80 concurrent players per branch (configurable)
- **Slots**: 15-minute intervals
- **Status**: Direct CONFIRMED (no DRAFT in v1)

## Issues

⚠️ **Known Issue**: Seed script has problems with Prisma 7.2.0 client initialization. Manual seed via Prisma Studio recommended until fix.
