import { PrismaClient } from '@prisma/client'

// Prisma 7.2.0 reads DATABASE_URL from environment or prisma.config.ts
// For seed script, we need to ensure DATABASE_URL is set
if (!process.env.DATABASE_URL) {
  process.env.DATABASE_URL = 'file:./dev.db'
}

const prisma = new PrismaClient()

async function main() {
  console.log('🌱 Seeding database...')

  // Créer branches
  const herzliya = await prisma.branch.upsert({
    where: { id: 'branch-herzliya' },
    update: {},
    create: {
      id: 'branch-herzliya',
      name: 'Herzliya',
      address: '123 Herzl Street, Herzliya',
      timezone: 'Asia/Jerusalem',
    },
  })

  const telAviv = await prisma.branch.upsert({
    where: { id: 'branch-telaviv' },
    update: {},
    create: {
      id: 'branch-telaviv',
      name: 'Tel Aviv',
      address: '456 Dizengoff Street, Tel Aviv',
      timezone: 'Asia/Jerusalem',
    },
  })

  console.log('✅ Branches created:', { herzliya: herzliya.name, telAviv: telAviv.name })

  // Créer settings pour Herzliya
  await prisma.settings.upsert({
    where: { branchId: herzliya.id },
    update: {},
    create: {
      branchId: herzliya.id,
      maxConcurrentPlayers: 80,
      slotMinutes: 15,
      gameDurationMinutes: 60,
      eventRoomDurationMinutes: 120,
      eventGameDurationMinutes: 60,
      bufferBeforeMinutes: 30,
      bufferAfterMinutes: 30,
      minEventParticipants: 15,
      eventRoomId: null, // Pour v1.1
      eventRoomCapacity: null, // Pour v1.1
    },
  })

  // Créer settings pour Tel Aviv
  await prisma.settings.upsert({
    where: { branchId: telAviv.id },
    update: {},
    create: {
      branchId: telAviv.id,
      maxConcurrentPlayers: 80,
      slotMinutes: 15,
      gameDurationMinutes: 60,
      eventRoomDurationMinutes: 120,
      eventGameDurationMinutes: 60,
      bufferBeforeMinutes: 30,
      bufferAfterMinutes: 30,
      minEventParticipants: 15,
      eventRoomId: null, // Pour v1.1
      eventRoomCapacity: null, // Pour v1.1
    },
  })

  console.log('✅ Settings created for both branches')
  console.log('🎉 Seeding completed!')
}

main()
  .catch((e) => {
    console.error('❌ Error seeding database:', e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
