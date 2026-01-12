/**
 * Script pour générer des réservations fictives pour tester l'agenda
 * Semaine du 12 au 18 janvier 2026
 */

import { writeFile, readFile } from 'fs/promises'
import { join } from 'path'
import { Reservation } from '../src/lib/reservations'

const RESERVATIONS_FILE = join(process.cwd(), 'data', 'reservations.json')

const branches = ['Rishon LeZion', 'Petah Tikva']
const firstNames = [
  'Jean', 'Marie', 'Pierre', 'Sophie', 'Antoine', 'Julie', 'Thomas', 'Emma',
  'Lucas', 'Lea', 'Nicolas', 'Camille', 'Alexandre', 'Sarah', 'David', 'Laura',
  'Michael', 'Chloe', 'Daniel', 'Clara', 'Benjamin', 'Eva', 'Samuel', 'Anna',
  'Hugo', 'Lucie', 'Raphael', 'Amelie', 'Louis', 'Julia', 'Paul', 'Manon'
]
const lastNames = [
  'Martin', 'Bernard', 'Thomas', 'Petit', 'Robert', 'Richard', 'Durand', 'Dubois',
  'Moreau', 'Laurent', 'Simon', 'Michel', 'Lefebvre', 'Leroy', 'Roux', 'David',
  'Bertrand', 'Morel', 'Fournier', 'Girard', 'Bonnet', 'Dupont', 'Lambert', 'Fontaine',
  'Rousseau', 'Vincent', 'Muller', 'Lefevre', 'Faure', 'Andre', 'Mercier', 'Blanc'
]
const eventTypes = ['birthday', 'bar_mitzvah', 'corporate', 'party', 'other']

// Générer des réservations pour la semaine du 12 au 18 janvier 2026
const generateReservations = (): Reservation[] => {
  const reservations: Reservation[] = []
  const startDate = new Date('2026-01-12T00:00:00')
  
  // Générer pour chaque jour de la semaine (lundi 12 à dimanche 18)
  for (let dayOffset = 0; dayOffset < 7; dayOffset++) {
    const date = new Date(startDate)
    date.setDate(startDate.getDate() + dayOffset)
    const dateStr = date.toISOString().split('T')[0]
    
    // Heures possibles : 10:00 à 22:00 (30 min d'intervalle)
    const hours = [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22]
    
    hours.forEach((hour) => {
      // Probabilité d'avoir une réservation : 40% le week-end, 60% en semaine
      const isWeekend = dayOffset === 5 || dayOffset === 6
      const probability = isWeekend ? 0.4 : 0.6
      
      if (Math.random() < probability) {
        // Type : 70% GAME, 30% EVENT
        const isEvent = Math.random() < 0.3
        const type = isEvent ? 'event' : 'game'
        
        const branch = branches[Math.floor(Math.random() * branches.length)]
        const firstName = firstNames[Math.floor(Math.random() * firstNames.length)]
        const lastName = lastNames[Math.floor(Math.random() * lastNames.length)]
        
        // Participants
        const players = isEvent 
          ? Math.floor(Math.random() * 20) + 15 // Event: 15-35
          : Math.floor(Math.random() * 8) + 2 // Game: 2-10
        
        const time = `${String(hour).padStart(2, '0')}:${Math.random() < 0.5 ? '00' : '30'}`
        
        // Générer numéro de réservation
        const now = new Date()
        const dateStrRes = dateStr.replace(/-/g, '')
        const timeStrRes = time.replace(':', '')
        const randomStr = Math.random().toString(36).substr(2, 4).toUpperCase()
        const reservationNumber = `AG-${dateStrRes}-${timeStrRes}-${randomStr}`
        
        // Générer ID unique
        const id = `res-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`
        
        const reservation: Reservation = {
          id,
          branch,
          type: type as 'game' | 'event',
          players,
          date: dateStr,
          time,
          firstName,
          lastName,
          phone: `0${Math.floor(Math.random() * 9) + 1}${Math.floor(Math.random() * 100000000).toString().padStart(8, '0')}`,
          email: Math.random() < 0.7 ? `${firstName.toLowerCase()}.${lastName.toLowerCase()}@email.com` : null,
          specialRequest: Math.random() < 0.3 ? 'Demande spéciale pour cette réservation' : null,
          eventType: isEvent ? eventTypes[Math.floor(Math.random() * eventTypes.length)] : null,
          eventAge: isEvent && (Math.random() < 0.4) ? Math.floor(Math.random() * 50) + 10 : null,
          reservationNumber,
          createdAt: new Date(Date.now() - Math.random() * 7 * 24 * 60 * 60 * 1000).toISOString(),
          status: 'confirmed',
        }
        
        reservations.push(reservation)
      }
      
      // Parfois ajouter une 2ème réservation au même créneau (même branch)
      if (Math.random() < 0.15) {
        const branchSecond = branches[Math.floor(Math.random() * branches.length)]
        const firstNameSecond = firstNames[Math.floor(Math.random() * firstNames.length)]
        const lastNameSecond = lastNames[Math.floor(Math.random() * lastNames.length)]
        
        const isEventSecond = Math.random() < 0.3
        const typeSecond = isEventSecond ? 'event' : 'game'
        const playersSecond = isEventSecond 
          ? Math.floor(Math.random() * 20) + 15
          : Math.floor(Math.random() * 8) + 2
        
        const timeSecond = `${String(hour).padStart(2, '0')}:${Math.random() < 0.5 ? '00' : '30'}`
        const dateStrRes = dateStr.replace(/-/g, '')
        const timeStrRes = timeSecond.replace(':', '')
        const randomStr = Math.random().toString(36).substr(2, 4).toUpperCase()
        const reservationNumber = `AG-${dateStrRes}-${timeStrRes}-${randomStr}`
        const id = `res-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`
        
        const reservation: Reservation = {
          id,
          branch: branchSecond,
          type: typeSecond as 'game' | 'event',
          players: playersSecond,
          date: dateStr,
          time: timeSecond,
          firstName: firstNameSecond,
          lastName: lastNameSecond,
          phone: `0${Math.floor(Math.random() * 9) + 1}${Math.floor(Math.random() * 100000000).toString().padStart(8, '0')}`,
          email: Math.random() < 0.7 ? `${firstNameSecond.toLowerCase()}.${lastNameSecond.toLowerCase()}@email.com` : null,
          specialRequest: null,
          eventType: isEventSecond ? eventTypes[Math.floor(Math.random() * eventTypes.length)] : null,
          eventAge: isEventSecond && (Math.random() < 0.4) ? Math.floor(Math.random() * 50) + 10 : null,
          reservationNumber,
          createdAt: new Date(Date.now() - Math.random() * 7 * 24 * 60 * 60 * 1000).toISOString(),
          status: 'confirmed',
        }
        
        reservations.push(reservation)
      }
    })
  }
  
  return reservations
}

async function main() {
  try {
    console.log('Génération des réservations fictives...')
    
    // Lire les réservations existantes
    let existingReservations: Reservation[] = []
    try {
      const data = await readFile(RESERVATIONS_FILE, 'utf-8')
      existingReservations = JSON.parse(data)
    } catch (error) {
      // Fichier n'existe pas, on commence avec un tableau vide
      console.log('Aucune réservation existante trouvée')
    }
    
    // Générer les nouvelles réservations
    const newReservations = generateReservations()
    
    // Filtrer les réservations existantes pour ne garder que celles qui ne sont pas dans la semaine du 12-18 janvier
    const weekStart = new Date('2026-01-12T00:00:00')
    const weekEnd = new Date('2026-01-19T00:00:00')
    
    const filteredExisting = existingReservations.filter(res => {
      const resDate = new Date(res.date + 'T00:00:00')
      return resDate < weekStart || resDate >= weekEnd
    })
    
    // Combiner les réservations existantes (hors semaine) avec les nouvelles
    const allReservations = [...filteredExisting, ...newReservations]
    
    // Trier par date/heure
    allReservations.sort((a, b) => {
      const dateA = new Date(a.date + 'T' + a.time).getTime()
      const dateB = new Date(b.date + 'T' + b.time).getTime()
      return dateA - dateB
    })
    
    // Sauvegarder
    await writeFile(RESERVATIONS_FILE, JSON.stringify(allReservations, null, 2), 'utf-8')
    
    console.log(`✅ ${newReservations.length} réservations générées pour la semaine du 12-18 janvier 2026`)
    console.log(`📊 Total: ${allReservations.length} réservations dans le fichier`)
    console.log(`🏢 Branches: ${branches.join(', ')}`)
    console.log(`📅 Dates: 12/01/2026 au 18/01/2026`)
  } catch (error) {
    console.error('Erreur lors de la génération:', error)
    process.exit(1)
  }
}

main()
