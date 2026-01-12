'use client'

import { useState, useEffect } from 'react'
import { Calendar, Clock, Users, MapPin, Phone, Mail, Search, Filter, X, Ban, CheckCircle, ChevronDown, ChevronUp, ChevronLeft, ChevronRight, Grid, CalendarDays, Sun, Moon, Settings } from 'lucide-react'
import { Reservation } from '@/lib/reservations'

type SortField = 'reservationNumber' | 'date' | 'time' | 'firstName' | 'lastName' | 'phone' | 'branch' | 'type' | 'players' | 'status'
type SortDirection = 'asc' | 'desc' | null
type ViewMode = 'table' | 'agenda'
type AgendaView = 'week' | 'day'
type Theme = 'light' | 'dark'

type SimpleAppointment = {
  id: string
  date: string // 'YYYY-MM-DD'
  hour: number // 10, 11, 12...
  title: string
  branch?: string
  eventType?: string
  durationMinutes?: number
  color?: string
  eventNotes?: string
  customerFirstName?: string
  customerLastName?: string
  customerPhone?: string
  customerEmail?: string
  customerNotes?: string
  gameDurationMinutes?: number
  participants?: number
}

export default function AdminPage() {
  const [password, setPassword] = useState('')
  const [authenticated, setAuthenticated] = useState(false)
  const [theme, setTheme] = useState<Theme>('light')
  const [reservations, setReservations] = useState<Reservation[]>([])
  const [allReservations, setAllReservations] = useState<Reservation[]>([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [searchQuery, setSearchQuery] = useState('')
  const [sortField, setSortField] = useState<SortField>('date')
  const [sortDirection, setSortDirection] = useState<SortDirection>('desc')
  const [viewMode, setViewMode] = useState<ViewMode>('table')
  const [agendaView, setAgendaView] = useState<AgendaView>('day')
  const [selectedDate, setSelectedDate] = useState<Date>(() => {
    const today = new Date()
    today.setHours(0, 0, 0, 0)
    return today
  })
  const [showCalendarModal, setShowCalendarModal] = useState(false)
  const [calendarMonth, setCalendarMonth] = useState(new Date().getMonth())
  const [calendarYear, setCalendarYear] = useState(new Date().getFullYear())
  const [showSettingsPanel, setShowSettingsPanel] = useState(false)
  const [rowHeight, setRowHeight] = useState(60) // Hauteur des lignes en pixels
  const [currentWeekStart, setCurrentWeekStart] = useState(() => {
    const today = new Date()
    const day = today.getDay()
    const diff = today.getDate() - day + (day === 0 ? -6 : 1) // Lundi
    const monday = new Date(today.setDate(diff))
    monday.setHours(0, 0, 0, 0)
    return monday
  })
  const [columnFilters, setColumnFilters] = useState<{
    status?: 'confirmed' | 'cancelled' | 'all'
    branch?: string
    type?: 'game' | 'event' | 'all'
  }>({
    status: 'all',
    branch: 'all',
    type: 'all',
  })
  const [appointments, setAppointments] = useState<SimpleAppointment[]>([])
  const [showAppointmentModal, setShowAppointmentModal] = useState(false)
  const [editingAppointment, setEditingAppointment] = useState<SimpleAppointment | null>(null)
  const [appointmentTitle, setAppointmentTitle] = useState('')
  const [appointmentHour, setAppointmentHour] = useState<number | null>(null)
  const [appointmentDate, setAppointmentDate] = useState('')
  const [appointmentBranch, setAppointmentBranch] = useState('')
  const [appointmentEventType, setAppointmentEventType] = useState('')
  const [appointmentDuration, setAppointmentDuration] = useState<number | null>(60)
  const [appointmentColor, setAppointmentColor] = useState('#3b82f6')
  const [appointmentEventNotes, setAppointmentEventNotes] = useState('')
  const [appointmentCustomerFirstName, setAppointmentCustomerFirstName] = useState('')
  const [appointmentCustomerLastName, setAppointmentCustomerLastName] = useState('')
  const [appointmentCustomerPhone, setAppointmentCustomerPhone] = useState('')
  const [appointmentCustomerEmail, setAppointmentCustomerEmail] = useState('')
  const [appointmentCustomerNotes, setAppointmentCustomerNotes] = useState('')
  const [appointmentGameDuration, setAppointmentGameDuration] = useState<number | null>(60)
  const [appointmentParticipants, setAppointmentParticipants] = useState<number | null>(null)

  const presetColors = ['#3b82f6', '#22c55e', '#f97316', '#ef4444', '#a855f7', '#eab308']

  // Position et taille du modal de rendez-vous (draggable / redimensionnable)
  const [appointmentModalWidth, setAppointmentModalWidth] = useState(900)
  const [appointmentModalHeight, setAppointmentModalHeight] = useState(600)
  const [appointmentModalX, setAppointmentModalX] = useState<number | null>(null)
  const [appointmentModalY, setAppointmentModalY] = useState<number | null>(null)
  const [isDraggingModal, setIsDraggingModal] = useState(false)
  const [dragOffset, setDragOffset] = useState({ x: 0, y: 0 })
  const [isResizingModal, setIsResizingModal] = useState(false)
  const [resizeStart, setResizeStart] = useState<{ mouseX: number; mouseY: number; width: number; height: number } | null>(null)

  // Vérifier si déjà authentifié, charger thème + rendez-vous simples + config modal
  useEffect(() => {
    const auth = localStorage.getItem('admin_authenticated')
    if (auth === 'true') {
      setAuthenticated(true)
      loadReservations()
    }
    const savedTheme = localStorage.getItem('admin_theme') as Theme
    if (savedTheme) {
      setTheme(savedTheme)
    }

    const storedAppointments = localStorage.getItem('admin_simple_appointments')
    if (storedAppointments) {
      try {
        const parsed: SimpleAppointment[] = JSON.parse(storedAppointments)
        // Sécuriser les anciens rendez-vous avec valeurs par défaut
        setAppointments(
          parsed.map((a) => ({
            ...a,
            color: a.color || '#3b82f6',
            durationMinutes: a.durationMinutes ?? 60,
          })),
        )
      } catch {
        setAppointments([])
      }
    }

    const storedModal = localStorage.getItem('admin_appointment_modal')
    if (storedModal) {
      try {
        const parsed = JSON.parse(storedModal) as {
          width?: number
          height?: number
          x?: number
          y?: number
        }
        if (parsed.width) setAppointmentModalWidth(parsed.width)
        if (parsed.height) setAppointmentModalHeight(parsed.height)
        if (typeof parsed.x === 'number') setAppointmentModalX(parsed.x)
        if (typeof parsed.y === 'number') setAppointmentModalY(parsed.y)
      } catch {
        // ignore
      }
    }
  }, [])

  // Sauvegarde config modal
  useEffect(() => {
    const data = {
      width: appointmentModalWidth,
      height: appointmentModalHeight,
      x: appointmentModalX,
      y: appointmentModalY,
    }
    localStorage.setItem('admin_appointment_modal', JSON.stringify(data))
  }, [appointmentModalWidth, appointmentModalHeight, appointmentModalX, appointmentModalY])

  // Sauvegarde des rendez-vous simples
  useEffect(() => {
    localStorage.setItem('admin_simple_appointments', JSON.stringify(appointments))
  }, [appointments])

  const toggleTheme = () => {
    const newTheme = theme === 'light' ? 'dark' : 'light'
    setTheme(newTheme)
    localStorage.setItem('admin_theme', newTheme)
  }

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault()
    
    try {
      const response = await fetch('/api/admin/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ password }),
      })
      
      const result = await response.json()
      
      if (result.success) {
        setAuthenticated(true)
        localStorage.setItem('admin_authenticated', 'true')
        loadReservations()
      } else {
        alert(result.error || 'Mot de passe incorrect')
      }
    } catch (error) {
      alert('Erreur lors de la connexion')
    }
  }

  const handleLogout = () => {
    setAuthenticated(false)
    localStorage.removeItem('admin_authenticated')
    setReservations([])
    setAllReservations([])
  }

  const loadReservations = async () => {
    setLoading(true)
    setError(null)
    try {
      const response = await fetch('/api/reservations')
      const result = await response.json()
      
      if (result.success) {
        setAllReservations(result.reservations)
        
        let filtered = result.reservations
        
        // Filtre par statut
        if (columnFilters.status && columnFilters.status !== 'all') {
          filtered = filtered.filter((r: Reservation) => r.status === columnFilters.status)
        }
        
        // Filtre par branch
        if (columnFilters.branch && columnFilters.branch !== 'all') {
          filtered = filtered.filter((r: Reservation) => r.branch === columnFilters.branch)
        }
        
        // Filtre par type
        if (columnFilters.type && columnFilters.type !== 'all') {
          filtered = filtered.filter((r: Reservation) => r.type === columnFilters.type)
        }
        
        // Recherche
        if (searchQuery) {
          const searchLower = searchQuery.toLowerCase()
          filtered = filtered.filter((r: Reservation) => 
            r.firstName.toLowerCase().includes(searchLower) ||
            r.lastName.toLowerCase().includes(searchLower) ||
            r.phone.includes(searchLower) ||
            (r.email && r.email.toLowerCase().includes(searchLower)) ||
            r.reservationNumber.toLowerCase().includes(searchLower)
          )
        }
        
        // Tri
        if (sortField && sortDirection) {
          filtered.sort((a: Reservation, b: Reservation) => {
            let aVal: any
            let bVal: any
            
            switch (sortField) {
              case 'date':
                aVal = new Date(a.date + 'T00:00:00').getTime()
                bVal = new Date(b.date + 'T00:00:00').getTime()
                break
              case 'time':
                aVal = a.time
                bVal = b.time
                break
              case 'firstName':
                aVal = a.firstName.toLowerCase()
                bVal = b.firstName.toLowerCase()
                break
              case 'lastName':
                aVal = a.lastName.toLowerCase()
                bVal = b.lastName.toLowerCase()
                break
              case 'phone':
                aVal = a.phone
                bVal = b.phone
                break
              case 'branch':
                aVal = a.branch
                bVal = b.branch
                break
              case 'type':
                aVal = a.type
                bVal = b.type
                break
              case 'players':
                aVal = a.players
                bVal = b.players
                break
              case 'status':
                aVal = a.status
                bVal = b.status
                break
              case 'reservationNumber':
                aVal = a.reservationNumber
                bVal = b.reservationNumber
                break
              default:
                return 0
            }
            
            if (aVal < bVal) return sortDirection === 'asc' ? -1 : 1
            if (aVal > bVal) return sortDirection === 'asc' ? 1 : -1
            return 0
          })
        }
        
        setReservations(filtered)
      } else {
        setError(result.error || 'Erreur lors du chargement des réservations')
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Erreur lors du chargement')
    } finally {
      setLoading(false)
    }
  }

  const handleCancelReservation = async (id: string) => {
    if (!confirm('Êtes-vous sûr de vouloir annuler cette réservation ?')) {
      return
    }

    try {
      const response = await fetch(`/api/reservations/${id}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ status: 'cancelled' }),
      })

      const result = await response.json()
      
      if (result.success) {
        loadReservations()
      } else {
        alert('Erreur lors de l\'annulation')
      }
    } catch (err) {
      alert('Erreur lors de l\'annulation')
    }
  }

  const handleSort = (field: SortField) => {
    if (sortField === field) {
      if (sortDirection === 'asc') {
        setSortDirection('desc')
      } else if (sortDirection === 'desc') {
        setSortDirection(null)
        setSortField('date')
        setSortDirection('desc')
      } else {
        setSortDirection('asc')
      }
    } else {
      setSortField(field)
      setSortDirection('asc')
    }
  }

  const handleColumnFilter = (field: 'status' | 'branch' | 'type', value: string) => {
    setColumnFilters({ ...columnFilters, [field]: value })
  }

  const handlePreviousWeek = () => {
    const newDate = new Date(currentWeekStart)
    newDate.setDate(newDate.getDate() - 7)
    setCurrentWeekStart(newDate)
  }

  const handleNextWeek = () => {
    const newDate = new Date(currentWeekStart)
    newDate.setDate(newDate.getDate() + 7)
    setCurrentWeekStart(newDate)
  }

  const handlePreviousDay = () => {
    const newDate = new Date(selectedDate)
    newDate.setDate(newDate.getDate() - 1)
    setSelectedDate(newDate)
    // Mettre à jour la semaine si nécessaire
    const day = newDate.getDay()
    const diff = newDate.getDate() - day + (day === 0 ? -6 : 1)
    const monday = new Date(newDate)
    monday.setDate(diff)
    monday.setHours(0, 0, 0, 0)
    setCurrentWeekStart(monday)
  }

  const handleNextDay = () => {
    const newDate = new Date(selectedDate)
    newDate.setDate(newDate.getDate() + 1)
    setSelectedDate(newDate)
    // Mettre à jour la semaine si nécessaire
    const day = newDate.getDay()
    const diff = newDate.getDate() - day + (day === 0 ? -6 : 1)
    const monday = new Date(newDate)
    monday.setDate(diff)
    monday.setHours(0, 0, 0, 0)
    setCurrentWeekStart(monday)
  }

  const handleToday = () => {
    const today = new Date()
    today.setHours(0, 0, 0, 0)
    setSelectedDate(today)
    const day = today.getDay()
    const diff = today.getDate() - day + (day === 0 ? -6 : 1)
    const monday = new Date(today)
    monday.setDate(diff)
    monday.setHours(0, 0, 0, 0)
    setCurrentWeekStart(monday)
  }

  const handleDayClick = (date: Date) => {
    setSelectedDate(date)
  }

  const handleWeekDayClick = (date: Date) => {
    setSelectedDate(date)
  }

  const handleCalendarDateClick = (date: Date) => {
    setSelectedDate(date)
    // Mettre à jour la semaine
    const day = date.getDay()
    const diff = date.getDate() - day + (day === 0 ? -6 : 1)
    const monday = new Date(date)
    monday.setDate(diff)
    monday.setHours(0, 0, 0, 0)
    setCurrentWeekStart(monday)
    setShowCalendarModal(false)
  }

  const handlePreviousMonth = () => {
    if (calendarMonth === 0) {
      setCalendarMonth(11)
      setCalendarYear(calendarYear - 1)
    } else {
      setCalendarMonth(calendarMonth - 1)
    }
  }

  const handleNextMonth = () => {
    if (calendarMonth === 11) {
      setCalendarMonth(0)
      setCalendarYear(calendarYear + 1)
    } else {
      setCalendarMonth(calendarMonth + 1)
    }
  }

  const handlePreviousYear = () => {
    setCalendarYear(calendarYear - 1)
  }

  const handleNextYear = () => {
    setCalendarYear(calendarYear + 1)
  }

  // Recharger quand les filtres ou la recherche changent
  useEffect(() => {
    if (authenticated) {
      const timer = setTimeout(() => {
        loadReservations()
      }, 300)
      return () => clearTimeout(timer)
    }
  }, [searchQuery, columnFilters.status, columnFilters.branch, columnFilters.type, sortField, sortDirection])

  const formatDate = (dateString: string) => {
    const date = new Date(dateString + 'T00:00:00')
    return date.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
    })
  }

  const formatDateShort = (date: Date) => {
    return date.toLocaleDateString('fr-FR', {
      day: '2-digit',
      month: 'short',
    })
  }

  const formatDateLong = (date: Date) => {
    return date.toLocaleDateString('fr-FR', {
      weekday: 'long',
      day: 'numeric',
      month: 'long',
    })
  }

  const formatDateFull = (date: Date) => {
    return date.toLocaleDateString('fr-FR', {
      weekday: 'long',
      day: 'numeric',
      month: 'long',
      year: 'numeric',
    })
  }

  const getSortIcon = (field: SortField) => {
    const iconColor = theme === 'light' ? 'text-gray-900' : 'text-primary'
    if (sortField !== field) {
      return <ChevronDown className={`w-4 h-4 opacity-30 ${iconColor}`} />
    }
    if (sortDirection === 'asc') {
      return <ChevronUp className={`w-4 h-4 ${iconColor}`} />
    }
    if (sortDirection === 'desc') {
      return <ChevronDown className={`w-4 h-4 ${iconColor}`} />
    }
    return <ChevronDown className={`w-4 h-4 opacity-30 ${iconColor}`} />
  }

  // Générer les jours de la semaine
  const getWeekDays = () => {
    const days = []
    for (let i = 0; i < 7; i++) {
      const date = new Date(currentWeekStart)
      date.setDate(date.getDate() + i)
      days.push(date)
    }
    return days
  }

  // Générer les slots de temps (10:00, 11:00, 12:00, ...) pour l'affichage agenda
  const getTimeSlots = () => {
    const slots: Array<{ hour: number; label: string }> = []
    for (let h = 10; h <= 22; h++) {
      slots.push({ hour: h, label: `${String(h).padStart(2, '0')}:00` })
    }
    return slots
  }

  // Obtenir les rendez-vous simples pour une HEURE donnée (agenda visuel)
  const getAppointmentsForHour = (date: Date, hour: number) => {
    const year = date.getFullYear()
    const month = String(date.getMonth() + 1).padStart(2, '0')
    const day = String(date.getDate()).padStart(2, '0')
    const dateStr = `${year}-${month}-${day}`

    return appointments.filter(a => a.date === dateStr && a.hour === hour)
  }

  const openNewAppointmentModal = (hour: number) => {
    setEditingAppointment(null)
    setAppointmentTitle('')
    setAppointmentHour(hour)
    const year = selectedDate.getFullYear()
    const month = String(selectedDate.getMonth() + 1).padStart(2, '0')
    const day = String(selectedDate.getDate()).padStart(2, '0')
    setAppointmentDate(`${year}-${month}-${day}`)
    setAppointmentBranch('')
    setAppointmentEventType('')
    setAppointmentDuration(60)
    setAppointmentColor('#3b82f6')
    setAppointmentEventNotes('')
    setAppointmentCustomerFirstName('')
    setAppointmentCustomerLastName('')
    setAppointmentCustomerPhone('')
    setAppointmentCustomerEmail('')
    setAppointmentCustomerNotes('')
    setAppointmentGameDuration(60)
    setAppointmentParticipants(null)
    setShowAppointmentModal(true)
  }

  const openEditAppointmentModal = (appointment: SimpleAppointment) => {
    setEditingAppointment(appointment)
    setAppointmentTitle(appointment.title)
    setAppointmentHour(appointment.hour)
    setAppointmentDate(appointment.date)
    setAppointmentBranch(appointment.branch || '')
    setAppointmentEventType(appointment.eventType || '')
    setAppointmentDuration(appointment.durationMinutes ?? 60)
    setAppointmentColor(appointment.color || '#3b82f6')
    setAppointmentEventNotes(appointment.eventNotes || '')
    setAppointmentCustomerFirstName(appointment.customerFirstName || '')
    setAppointmentCustomerLastName(appointment.customerLastName || '')
    setAppointmentCustomerPhone(appointment.customerPhone || '')
    setAppointmentCustomerEmail(appointment.customerEmail || '')
    setAppointmentCustomerNotes(appointment.customerNotes || '')
    setAppointmentGameDuration(appointment.gameDurationMinutes ?? 60)
    setAppointmentParticipants(appointment.participants ?? null)
    setShowAppointmentModal(true)
  }

  const saveAppointment = () => {
    if (!appointmentTitle.trim() || appointmentHour === null || !appointmentDate) {
      return
    }
    const dateStr = appointmentDate

    if (editingAppointment) {
      setAppointments(prev =>
        prev.map(a =>
          a.id === editingAppointment.id
            ? {
                ...a,
                title: appointmentTitle.trim(),
                hour: appointmentHour,
                date: dateStr,
                branch: appointmentBranch || undefined,
                eventType: appointmentEventType || undefined,
                durationMinutes: appointmentDuration ?? undefined,
                color: appointmentColor || '#3b82f6',
                eventNotes: appointmentEventNotes || undefined,
                customerFirstName: appointmentCustomerFirstName || undefined,
                customerLastName: appointmentCustomerLastName || undefined,
                customerPhone: appointmentCustomerPhone || undefined,
                customerEmail: appointmentCustomerEmail || undefined,
                customerNotes: appointmentCustomerNotes || undefined,
                gameDurationMinutes: appointmentGameDuration ?? undefined,
                participants: appointmentParticipants ?? undefined,
              }
            : a,
        ),
      )
    } else {
      const newAppointment: SimpleAppointment = {
        id: `app-${Date.now()}-${Math.random().toString(36).slice(2, 8)}`,
        title: appointmentTitle.trim(),
        hour: appointmentHour,
        date: dateStr,
        branch: appointmentBranch || undefined,
        eventType: appointmentEventType || undefined,
        durationMinutes: appointmentDuration ?? undefined,
        color: appointmentColor || '#3b82f6',
        eventNotes: appointmentEventNotes || undefined,
        customerFirstName: appointmentCustomerFirstName || undefined,
        customerLastName: appointmentCustomerLastName || undefined,
        customerPhone: appointmentCustomerPhone || undefined,
        customerEmail: appointmentCustomerEmail || undefined,
        customerNotes: appointmentCustomerNotes || undefined,
        gameDurationMinutes: appointmentGameDuration ?? undefined,
        participants: appointmentParticipants ?? undefined,
      }
      setAppointments(prev => [...prev, newAppointment])
    }

    setShowAppointmentModal(false)
    setEditingAppointment(null)
    setAppointmentTitle('')
    setAppointmentHour(null)
    setAppointmentDate('')
    setAppointmentBranch('')
    setAppointmentEventType('')
    setAppointmentDuration(60)
    setAppointmentColor('#3b82f6')
    setAppointmentEventNotes('')
    setAppointmentCustomerFirstName('')
    setAppointmentCustomerLastName('')
    setAppointmentCustomerPhone('')
    setAppointmentCustomerEmail('')
    setAppointmentCustomerNotes('')
    setAppointmentGameDuration(60)
    setAppointmentParticipants(null)
  }

  const deleteAppointment = (id: string) => {
    setAppointments(prev => prev.filter(a => a.id !== id))
    setShowAppointmentModal(false)
    setEditingAppointment(null)
  }

  // Gestion du drag du modal
  const startDragModal = (e: React.MouseEvent<HTMLDivElement>) => {
    e.preventDefault()
    e.stopPropagation()
    const modal = (e.currentTarget.closest('[data-appointment-modal]') as HTMLElement) || null
    if (!modal) return
    const rect = modal.getBoundingClientRect()
    setIsDraggingModal(true)
    setDragOffset({
      x: e.clientX - rect.left,
      y: e.clientY - rect.top,
    })
    if (appointmentModalX === null || appointmentModalY === null) {
      setAppointmentModalX(rect.left)
      setAppointmentModalY(rect.top)
    }
  }

  const startResizeModal = (e: React.MouseEvent<HTMLDivElement>) => {
    e.preventDefault()
    e.stopPropagation()
    setIsResizingModal(true)
    setResizeStart({
      mouseX: e.clientX,
      mouseY: e.clientY,
      width: appointmentModalWidth,
      height: appointmentModalHeight,
    })
  }

  useEffect(() => {
    const handleMouseMove = (e: MouseEvent) => {
      if (isDraggingModal) {
        const newX = e.clientX - dragOffset.x
        const newY = e.clientY - dragOffset.y
        // Laisser la fenêtre aller vraiment partout, mais garder un minimum visible
        const minX = -appointmentModalWidth + 80
        const maxX = window.innerWidth - 80
        const minY = 0
        const maxY = window.innerHeight - 80
        setAppointmentModalX(Math.min(Math.max(minX, newX), maxX))
        setAppointmentModalY(Math.min(Math.max(minY, newY), maxY))
      } else if (isResizingModal && resizeStart) {
        const deltaX = e.clientX - resizeStart.mouseX
        const deltaY = e.clientY - resizeStart.mouseY
        const minWidth = 600
        const minHeight = 400
        const maxWidth = window.innerWidth - 32
        const maxHeight = window.innerHeight - 64
        setAppointmentModalWidth(
          Math.min(Math.max(minWidth, resizeStart.width + deltaX), maxWidth)
        )
        setAppointmentModalHeight(
          Math.min(Math.max(minHeight, resizeStart.height + deltaY), maxHeight)
        )
      }
    }

    const handleMouseUp = () => {
      if (isDraggingModal) setIsDraggingModal(false)
      if (isResizingModal) {
        setIsResizingModal(false)
        setResizeStart(null)
      }
    }

    window.addEventListener('mousemove', handleMouseMove)
    window.addEventListener('mouseup', handleMouseUp)
    return () => {
      window.removeEventListener('mousemove', handleMouseMove)
      window.removeEventListener('mouseup', handleMouseUp)
    }
  }, [isDraggingModal, dragOffset, isResizingModal, resizeStart, appointmentModalWidth, appointmentModalHeight])

  // Générer le calendrier pour le modal
  const getCalendarDays = () => {
    const firstDay = new Date(calendarYear, calendarMonth, 1)
    const lastDay = new Date(calendarYear, calendarMonth + 1, 0)
    const daysInMonth = lastDay.getDate()
    const startDay = firstDay.getDay()
    const days = []
    
    // Jours vides avant le premier jour
    for (let i = 0; i < (startDay === 0 ? 6 : startDay - 1); i++) {
      days.push(null)
    }
    
    // Jours du mois
    for (let i = 1; i <= daysInMonth; i++) {
      days.push(new Date(calendarYear, calendarMonth, i))
    }
    
    return days
  }

  // Classes CSS conditionnelles selon le thème
  const bgMain = theme === 'light' ? 'bg-gray-50' : 'bg-gradient-to-b from-dark via-dark-100 to-dark-200'
  const bgCard = theme === 'light' ? 'bg-white' : 'bg-dark-100/50'
  const bgCardHover = theme === 'light' ? 'bg-gray-100' : 'bg-dark-200/30'
  const bgHeader = theme === 'light' ? 'bg-gray-100' : 'bg-dark-200/50'
  const textMain = theme === 'light' ? 'text-gray-900' : 'text-white'
  const textSecondary = theme === 'light' ? 'text-gray-600' : 'text-gray-400'
  const textPrimary = theme === 'light' ? 'text-gray-900' : 'text-primary'
  const borderColor = theme === 'light' ? 'border-gray-300' : 'border-primary/30'
  const inputBg = theme === 'light' ? 'bg-white' : 'bg-dark-200/50'
  const inputBorder = theme === 'light' ? 'border-gray-300' : 'border-primary/30'

  // Page de login
  if (!authenticated) {
    return (
      <div className={`min-h-screen ${bgMain} ${textMain} flex items-center justify-center py-12 px-4`}>
        <div className="max-w-md w-full">
          <div className={`${bgCard} backdrop-blur-sm rounded-2xl p-8 border-2 ${borderColor}`}>
            <h1 className="text-3xl font-bold mb-6 text-center" style={{ fontFamily: 'Orbitron, sans-serif' }}>
              Admin - Back Office
            </h1>
            <form onSubmit={handleLogin} className="space-y-4">
              <div>
                <label className={`block ${textMain} mb-2 text-base font-medium`}>Mot de passe</label>
                <input
                  type="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="Entrez le mot de passe"
                  required
                  autoFocus
                  className={`w-full px-4 py-3 ${inputBg} border ${inputBorder} rounded-lg ${textMain} text-base placeholder-gray-500 focus:border-primary/70 focus:outline-none`}
                />
              </div>
              <button
                type="submit"
                className="glow-button w-full inline-flex items-center justify-center gap-2 px-6 py-3 text-base"
              >
                <CheckCircle className="w-5 h-5" />
                Connexion
              </button>
            </form>
          </div>
        </div>
      </div>
    )
  }

  const weekDays = getWeekDays()
  const timeSlots = getTimeSlots()
  const calendarDays = getCalendarDays()
  const monthNames = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre']

  // Page admin
  return (
    <div className={`min-h-screen ${bgMain} ${textMain} py-12 px-4`}>
      <div className="max-w-[1800px] mx-auto">
        {/* Header */}
        <div className="mb-8 flex justify-between items-start">
          <div>
            <h1 className="text-4xl font-bold mb-2" style={{ fontFamily: 'Orbitron, sans-serif' }}>
              Back Office - Réservations
            </h1>
            <p className={textSecondary + ' text-base'}>Gestion des réservations</p>
          </div>
          <div className="flex gap-2">
            <button
              onClick={toggleTheme}
              className={`p-2 ${bgCard} border ${borderColor} rounded-lg hover:${bgCardHover} transition-all`}
              title={theme === 'light' ? 'Mode sombre' : 'Mode clair'}
            >
              {theme === 'light' ? (
                <Moon className="w-5 h-5 text-gray-700" />
              ) : (
                <Sun className="w-5 h-5 text-yellow-400" />
              )}
            </button>
            <button
              onClick={handleLogout}
              className={`px-4 py-2 ${bgCard} border ${borderColor} rounded-lg hover:${bgCardHover} transition-all text-base`}
            >
              Déconnexion
            </button>
          </div>
        </div>

        {/* Onglets Table/Agenda */}
        <div className="mb-6 flex gap-2">
          <button
            onClick={() => setViewMode('table')}
            className={`px-6 py-3 rounded-lg border transition-all flex items-center gap-2 ${
              viewMode === 'table'
                ? 'bg-primary/20 border-primary text-primary'
                : `${bgCard} ${borderColor} ${textMain} hover:${bgCardHover}`
            }`}
          >
            <Grid className="w-5 h-5" />
            <span className="text-base font-medium">Tableau</span>
          </button>
          <button
            onClick={() => setViewMode('agenda')}
            className={`px-6 py-3 rounded-lg border transition-all flex items-center gap-2 ${
              viewMode === 'agenda'
                ? 'bg-primary/20 border-primary text-primary'
                : `${bgCard} ${borderColor} ${textMain} hover:${bgCardHover}`
            }`}
          >
            <CalendarDays className="w-5 h-5" />
            <span className="text-base font-medium">Agenda</span>
          </button>
        </div>

        {/* Barre de recherche */}
        <div className={`${bgCard} backdrop-blur-sm rounded-2xl p-6 border ${borderColor} mb-6`}>
          <div className="flex items-center gap-4">
            <div className="flex-1 relative">
              <Search className={`absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 ${textSecondary}`} />
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                placeholder="Rechercher par nom, téléphone, email, numéro de réservation..."
                className={`w-full pl-10 pr-4 py-3 ${inputBg} border ${inputBorder} rounded-lg ${textMain} text-base placeholder-gray-500 focus:border-primary/70 focus:outline-none`}
              />
            </div>
          </div>
        </div>

        {/* Statistiques */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <div className={`${bgCard} backdrop-blur-sm rounded-xl p-4 border ${borderColor}`}>
            <div className={`${textSecondary} text-base mb-1`}>Total</div>
            <div className={`text-3xl font-bold ${textPrimary}`}>{reservations.length}</div>
          </div>
          <div className={`${bgCard} backdrop-blur-sm rounded-xl p-4 border ${borderColor}`}>
            <div className={`${textSecondary} text-base mb-1`}>Confirmées</div>
            <div className="text-3xl font-bold text-green-500">
              {reservations.filter(r => r.status === 'confirmed').length}
            </div>
          </div>
          <div className={`${bgCard} backdrop-blur-sm rounded-xl p-4 border ${borderColor}`}>
            <div className={`${textSecondary} text-base mb-1`}>Annulées</div>
            <div className="text-3xl font-bold text-red-500">
              {reservations.filter(r => r.status === 'cancelled').length}
            </div>
          </div>
        </div>

        {/* Erreur */}
        {error && (
          <div className={`mb-6 p-4 bg-red-500/20 border border-red-500 rounded-lg text-red-400 text-base`}>
            {error}
          </div>
        )}

        {/* Vue Tableau */}
        {viewMode === 'table' && (
          <div className={`${bgCard} backdrop-blur-sm rounded-2xl border ${borderColor} overflow-hidden`}>
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className={`${bgHeader} border-b ${borderColor}`}>
                  <tr>
                    <th className="px-4 py-4 text-left">
                      <button
                        onClick={() => handleSort('reservationNumber')}
                        className={`flex items-center gap-2 text-base font-bold ${textPrimary} hover:opacity-80 transition-colors`}
                      >
                        <span>Numéro</span>
                        {getSortIcon('reservationNumber')}
                      </button>
                    </th>
                    <th className="px-4 py-4 text-left">
                      <button
                        onClick={() => handleSort('date')}
                        className={`flex items-center gap-2 text-base font-bold ${textPrimary} hover:opacity-80 transition-colors`}
                      >
                        <span>Date</span>
                        {getSortIcon('date')}
                      </button>
                    </th>
                    <th className="px-4 py-4 text-left">
                      <button
                        onClick={() => handleSort('time')}
                        className={`flex items-center gap-2 text-base font-bold ${textPrimary} hover:opacity-80 transition-colors`}
                      >
                        <span>Heure</span>
                        {getSortIcon('time')}
                      </button>
                    </th>
                    <th className="px-4 py-4 text-left">
                      <button
                        onClick={() => handleSort('lastName')}
                        className={`flex items-center gap-2 text-base font-bold ${textPrimary} hover:opacity-80 transition-colors`}
                      >
                        <span>Client</span>
                        {getSortIcon('lastName')}
                      </button>
                    </th>
                    <th className="px-4 py-4 text-left">
                      <button
                        onClick={() => handleSort('phone')}
                        className={`flex items-center gap-2 text-base font-bold ${textPrimary} hover:opacity-80 transition-colors`}
                      >
                        <span>Téléphone</span>
                        {getSortIcon('phone')}
                      </button>
                    </th>
                    <th className="px-4 py-4 text-left">
                      <div className="flex flex-col gap-2">
                        <button
                          onClick={() => handleSort('branch')}
                          className={`flex items-center gap-2 text-base font-bold ${textPrimary} hover:opacity-80 transition-colors`}
                        >
                          <span>Branch</span>
                          {getSortIcon('branch')}
                        </button>
                        <select
                          value={columnFilters.branch || 'all'}
                          onChange={(e) => handleColumnFilter('branch', e.target.value)}
                          onClick={(e) => e.stopPropagation()}
                          className={`text-sm ${inputBg} border ${inputBorder} rounded px-2 py-1.5 ${textMain} focus:border-primary/50 focus:outline-none`}
                        >
                          <option value="all">Toutes</option>
                          <option value="Rishon LeZion">Rishon</option>
                          <option value="Petah Tikva">Petah Tikva</option>
                        </select>
                      </div>
                    </th>
                    <th className="px-4 py-4 text-left">
                      <div className="flex flex-col gap-2">
                        <button
                          onClick={() => handleSort('type')}
                          className={`flex items-center gap-2 text-base font-bold ${textPrimary} hover:opacity-80 transition-colors`}
                        >
                          <span>Type</span>
                          {getSortIcon('type')}
                        </button>
                        <select
                          value={columnFilters.type || 'all'}
                          onChange={(e) => handleColumnFilter('type', e.target.value)}
                          onClick={(e) => e.stopPropagation()}
                          className={`text-sm ${inputBg} border ${inputBorder} rounded px-2 py-1.5 ${textMain} focus:border-primary/50 focus:outline-none`}
                        >
                          <option value="all">Tous</option>
                          <option value="game">Game</option>
                          <option value="event">Event</option>
                        </select>
                      </div>
                    </th>
                    <th className="px-4 py-4 text-left">
                      <button
                        onClick={() => handleSort('players')}
                        className={`flex items-center gap-2 text-base font-bold ${textPrimary} hover:opacity-80 transition-colors`}
                      >
                        <span>Participants</span>
                        {getSortIcon('players')}
                      </button>
                    </th>
                    <th className="px-4 py-4 text-left">
                      <div className="flex flex-col gap-2">
                        <button
                          onClick={() => handleSort('status')}
                          className={`flex items-center gap-2 text-base font-bold ${textPrimary} hover:opacity-80 transition-colors`}
                        >
                          <span>Statut</span>
                          {getSortIcon('status')}
                        </button>
                        <select
                          value={columnFilters.status || 'all'}
                          onChange={(e) => handleColumnFilter('status', e.target.value)}
                          onClick={(e) => e.stopPropagation()}
                          className={`text-sm ${inputBg} border ${inputBorder} rounded px-2 py-1.5 ${textMain} focus:border-primary/50 focus:outline-none`}
                        >
                          <option value="all">Tous</option>
                          <option value="confirmed">Confirmées</option>
                          <option value="cancelled">Annulées</option>
                        </select>
                      </div>
                    </th>
                    <th className={`px-4 py-4 text-left text-base font-bold ${textPrimary}`}>
                      Actions
                    </th>
                  </tr>
                </thead>
                <tbody>
                  {loading ? (
                    <tr>
                      <td colSpan={10} className={`px-4 py-12 text-center text-base ${textSecondary}`}>
                        Chargement...
                      </td>
                    </tr>
                  ) : reservations.length === 0 ? (
                    <tr>
                      <td colSpan={10} className={`px-4 py-12 text-center text-base ${textSecondary}`}>
                        Aucune réservation trouvée
                      </td>
                    </tr>
                  ) : (
                    reservations.map((reservation) => (
                      <tr
                        key={reservation.id}
                        className={`border-b ${borderColor} hover:${bgCardHover} transition-colors`}
                      >
                        <td className="px-4 py-4">
                          <div className={`text-base font-mono ${textSecondary} whitespace-nowrap`}>
                            {reservation.reservationNumber}
                          </div>
                        </td>
                        <td className="px-4 py-4">
                          <div className={`text-base ${textMain} whitespace-nowrap`}>
                            {formatDate(reservation.date)}
                          </div>
                        </td>
                        <td className="px-4 py-4">
                          <div className={`text-base ${textMain} whitespace-nowrap`}>
                            {reservation.time}
                          </div>
                        </td>
                        <td className="px-4 py-4">
                          <div className={`text-base ${textMain} whitespace-nowrap`}>
                            {reservation.firstName} {reservation.lastName}
                          </div>
                          {reservation.email && (
                            <div className={`text-sm ${textSecondary} mt-1`}>
                              {reservation.email}
                            </div>
                          )}
                        </td>
                        <td className="px-4 py-4">
                          <div className={`text-base ${textMain} whitespace-nowrap`}>
                            {reservation.phone}
                          </div>
                        </td>
                        <td className="px-4 py-4">
                          <div className={`text-base ${textMain} whitespace-nowrap`}>
                            {reservation.branch}
                          </div>
                        </td>
                        <td className="px-4 py-4">
                          <span
                            className={`inline-block px-3 py-1.5 rounded text-sm font-bold whitespace-nowrap ${
                              reservation.type === 'game'
                                ? 'bg-blue-500/20 text-blue-400'
                                : 'bg-purple-500/20 text-purple-400'
                            }`}
                          >
                            {reservation.type === 'game' ? 'GAME' : 'EVENT'}
                          </span>
                        </td>
                        <td className="px-4 py-4">
                          <div className={`text-base ${textMain} whitespace-nowrap`}>
                            {reservation.players}
                          </div>
                        </td>
                        <td className="px-4 py-4">
                          <span
                            className={`inline-block px-3 py-1.5 rounded text-sm font-bold whitespace-nowrap ${
                              reservation.status === 'confirmed'
                                ? 'bg-green-500/20 text-green-400'
                                : 'bg-red-500/20 text-red-400'
                            }`}
                          >
                            {reservation.status === 'confirmed' ? 'Confirmée' : 'Annulée'}
                          </span>
                        </td>
                        <td className="px-4 py-4">
                          {reservation.status === 'confirmed' && (
                            <button
                              onClick={() => handleCancelReservation(reservation.id)}
                              className="p-2 bg-red-500/20 border border-red-500/30 rounded hover:bg-red-500/30 transition-all"
                              title="Annuler la réservation"
                            >
                              <Ban className="w-5 h-5 text-red-400" />
                            </button>
                          )}
                        </td>
                      </tr>
                    ))
                  )}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* Vue Agenda */}
        {viewMode === 'agenda' && (
          <div className={`${bgCard} backdrop-blur-sm rounded-2xl border ${borderColor}`}>
            {/* Barre supérieure : Bouton paramètres + Icône calendrier + Date centrée + Jours de la semaine à droite */}
            <div className={`${bgHeader} border-b ${borderColor} px-4 py-3`}>
              <div className="flex items-center justify-between gap-4">
                {/* Bouton Paramètres tout à gauche, avec espace avant le calendrier/agenda */}
                <div className="relative mr-6">
                  <button
                    onClick={() => setShowSettingsPanel(!showSettingsPanel)}
                    className={`p-2 ${bgCard} border ${borderColor} rounded-lg hover:${bgCardHover} transition-all`}
                    title="Paramètres de l'agenda"
                  >
                    <Settings className={`w-5 h-5 ${textPrimary}`} />
                  </button>

                  {/* Panneau Paramètres */}
                  {showSettingsPanel && (
                    <>
                      <div
                        className="fixed inset-0 z-40"
                        onClick={() => setShowSettingsPanel(false)}
                      />
                      <div className={`absolute left-0 top-12 z-50 ${bgCard} border ${borderColor} rounded-lg shadow-xl p-4 min-w-[250px]`}>
                        <div className={`text-base font-bold ${textPrimary} mb-4`}>Paramètres de l'agenda</div>
                        
                        <div className="space-y-4">
                          <div>
                            <label className={`block ${textSecondary} text-sm mb-2`}>
                              Hauteur des lignes: {rowHeight}px
                            </label>
                            <input
                              type="range"
                              min="40"
                              max="120"
                              step="5"
                              value={rowHeight}
                              onChange={(e) => setRowHeight(Number(e.target.value))}
                              className="w-full"
                            />
                            <div className="flex justify-between text-xs mt-1">
                              <span className={textSecondary}>40px</span>
                              <span className={textSecondary}>120px</span>
                            </div>
                          </div>

                          <div className="flex gap-2">
                            <button
                              onClick={() => {
                                setRowHeight(60)
                                setShowSettingsPanel(false)
                              }}
                              className={`flex-1 px-3 py-2 ${bgCardHover} border ${borderColor} rounded hover:opacity-80 transition-all text-sm`}
                            >
                              Réinitialiser
                            </button>
                            <button
                              onClick={() => setShowSettingsPanel(false)}
                              className={`flex-1 px-3 py-2 bg-primary/20 border border-primary rounded hover:bg-primary/30 transition-all text-sm font-bold`}
                            >
                              Valider
                            </button>
                          </div>
                        </div>
                      </div>
                    </>
                  )}
                </div>

                {/* Icône calendrier à côté du bouton Paramètres */}
                <div className="relative mr-4">
                  <button
                    onClick={() => setShowCalendarModal(!showCalendarModal)}
                    className={`p-2 ${bgCard} border ${borderColor} rounded-lg hover:${bgCardHover} transition-all`}
                    title="Ouvrir le calendrier"
                  >
                    <Calendar className={`w-5 h-5 ${textPrimary}`} />
                  </button>

                  {/* Modal Calendrier */}
                  {showCalendarModal && (
                    <>
                      <div
                        className="fixed inset-0 z-40"
                        onClick={() => setShowCalendarModal(false)}
                      />
                      <div className={`absolute left-0 top-12 z-50 ${bgCard} border ${borderColor} rounded-lg shadow-xl p-4 min-w-[280px]`}>
                        {/* Navigation Mois/Année */}
                        <div className="flex items-center justify-between mb-4">
                          <button
                            onClick={handlePreviousYear}
                            className={`p-1 ${bgCardHover} rounded hover:opacity-80 transition-all`}
                            title="Année précédente"
                          >
                            <div className="relative w-4 h-4">
                              <ChevronLeft className={`w-4 h-4 ${textPrimary} absolute`} />
                              <ChevronLeft className={`w-4 h-4 ${textPrimary} absolute left-1`} />
                            </div>
                          </button>
                          <button
                            onClick={handlePreviousMonth}
                            className={`p-1 ${bgCardHover} rounded hover:opacity-80 transition-all`}
                            title="Mois précédent"
                          >
                            <ChevronLeft className={`w-4 h-4 ${textPrimary}`} />
                          </button>
                          <div className={`text-base font-bold ${textPrimary} px-4`}>
                            {monthNames[calendarMonth]} {calendarYear}
                          </div>
                          <button
                            onClick={handleNextMonth}
                            className={`p-1 ${bgCardHover} rounded hover:opacity-80 transition-all`}
                            title="Mois suivant"
                          >
                            <ChevronRight className={`w-4 h-4 ${textPrimary}`} />
                          </button>
                          <button
                            onClick={handleNextYear}
                            className={`p-1 ${bgCardHover} rounded hover:opacity-80 transition-all`}
                            title="Année suivante"
                          >
                            <div className="relative w-4 h-4">
                              <ChevronRight className={`w-4 h-4 ${textPrimary} absolute`} />
                              <ChevronRight className={`w-4 h-4 ${textPrimary} absolute left-1`} />
                            </div>
                          </button>
                        </div>

                        {/* Grille calendrier */}
                        <div className="grid grid-cols-7 gap-1">
                          {/* En-têtes jours */}
                          {['L', 'M', 'M', 'J', 'V', 'S', 'D'].map((day, i) => (
                            <div key={i} className={`text-xs ${textSecondary} text-center p-1 font-bold`}>
                              {day}
                            </div>
                          ))}
                          {/* Jours */}
                          {calendarDays.map((date, i) => {
                            if (!date) {
                              return <div key={`empty-${i}`} className="p-2"></div>
                            }
                            const isToday = date.toDateString() === new Date().toDateString()
                            const isSelected = date.toDateString() === selectedDate.toDateString()
                            const isInWeek = weekDays.some(d => d.toDateString() === date.toDateString())
                            
                            return (
                              <button
                                key={i}
                                onClick={() => handleCalendarDateClick(date)}
                                className={`p-2 rounded text-sm transition-all ${
                                  isSelected
                                    ? 'bg-primary/30 text-primary font-bold'
                                    : isToday
                                    ? 'bg-primary/20 text-primary'
                                    : isInWeek
                                    ? `${bgCardHover} ${textMain}`
                                    : `${textMain} hover:${bgCardHover}`
                                }`}
                              >
                                {date.getDate()}
                              </button>
                            )
                          })}
                        </div>
                      </div>
                    </>
                  )}
                </div>

                {/* Date centrée avec flèches + bouton Aujourd'hui */}
                <div className="flex items-center gap-2 flex-1 justify-center">
                  <button
                    onClick={handlePreviousDay}
                    className={`p-2 ${bgCard} border ${borderColor} rounded-lg hover:${bgCardHover} transition-all`}
                  >
                    <ChevronLeft className={`w-5 h-5 ${textPrimary}`} />
                  </button>
                  <div className={`text-lg font-bold ${textPrimary} min-w-[200px] text-center`}>
                    {formatDateFull(selectedDate)}
                  </div>
                  <button
                    onClick={handleNextDay}
                    className={`p-2 ${bgCard} border ${borderColor} rounded-lg hover:${bgCardHover} transition-all`}
                  >
                    <ChevronRight className={`w-5 h-5 ${textPrimary}`} />
                  </button>
                  <button
                    onClick={handleToday}
                    className={`px-3 py-2 bg-primary/20 border ${borderColor} rounded-lg hover:bg-primary/30 transition-all text-sm ml-2`}
                  >
                    Aujourd'hui
                  </button>
                </div>

                {/* Jours de la semaine (clic rapide) à droite */}
                <div className="flex gap-2">
                  {weekDays.map((day, index) => {
                    const isToday = day.toDateString() === new Date().toDateString()
                    const isSelected = day.toDateString() === selectedDate.toDateString()
                    return (
                      <button
                        key={index}
                        onClick={() => handleWeekDayClick(day)}
                        className={`px-3 py-2 rounded-lg border text-sm font-medium transition-all ${
                          isSelected
                            ? `bg-primary/20 border-primary ${textPrimary} font-bold`
                            : isToday
                            ? `bg-primary/10 border-primary/30 ${textPrimary}`
                            : `${bgCard} ${borderColor} ${textMain} hover:${bgCardHover}`
                        }`}
                      >
                        <div className={`text-xs ${textSecondary} leading-tight`}>
                          {day.toLocaleDateString('fr-FR', { weekday: 'short' })}
                        </div>
                        <div className="text-sm font-bold leading-tight">
                          {day.getDate()}
                        </div>
                      </button>
                    )
                  })}
                </div>
              </div>
            </div>

            {/* Vue journalière en bas avec tous les créneaux horaires */}
            <div className="flex">
              {/* Colonne Heure - Ajustée (1 ligne = 1 heure) */}
              <div className={`w-24 ${bgHeader} border-r ${borderColor} sticky left-0 flex-shrink-0`}>
                <div
                  className={`px-2 ${bgHeader} border-b ${borderColor} text-center flex items-center justify-center`}
                  style={{ height: `${rowHeight}px`, minHeight: `${rowHeight}px` }}
                >
                  <div className={`text-sm font-bold ${textPrimary}`}>Heure</div>
                </div>
                {timeSlots.map((slot) => (
                  <button
                    key={slot.hour}
                    type="button"
                    onClick={() => openNewAppointmentModal(slot.hour)}
                    className={`w-full px-2 border-b ${borderColor} text-center flex items-center justify-center hover:${bgCardHover} transition-colors`}
                    style={{ height: `${rowHeight}px`, minHeight: `${rowHeight}px` }}
                  >
                    <div className={`text-sm font-bold ${textPrimary}`}>
                      {slot.label}
                    </div>
                  </button>
                ))}
              </div>

              {/* Colonne Réservations */}
              <div className="flex-1">
                  <div
                    className={`p-4 ${bgHeader} border-b ${borderColor} text-center flex items-center justify-center`}
                    style={{ height: `${rowHeight}px`, minHeight: `${rowHeight}px` }}
                  >
                    <div className={`text-base font-bold ${textPrimary}`}>
                      Réservations - {formatDateShort(selectedDate)}
                    </div>
                  </div>
                  {timeSlots.map((slot) => {
                    const slotAppointments = getAppointmentsForHour(selectedDate, slot.hour)
                    const count = slotAppointments.length || 1
                    const widthPercent = 100 / count

                    return (
                      <div
                        key={slot.hour}
                        className={`px-3 border-b ${borderColor} ${bgCard} flex items-center cursor-pointer hover:${bgCardHover} transition-colors`}
                        style={{ height: `${rowHeight}px`, minHeight: `${rowHeight}px` }}
                        onClick={(e) => {
                          // Éviter d'ouvrir le modal si on clique sur un rendez-vous existant
                          if ((e.target as HTMLElement).closest('[data-appointment-card]')) return
                          openNewAppointmentModal(slot.hour)
                        }}
                      >
                        {slotAppointments.length > 0 ? (
                          <div className="flex w-full h-full gap-1">
                            {slotAppointments.map((appointment) => (
                              <div
                                key={appointment.id}
                                data-appointment-card
                                onClick={() => openEditAppointmentModal(appointment)}
                                className="h-full rounded border border-primary bg-primary/10 text-xs sm:text-sm font-medium hover:bg-primary/20 transition-all overflow-hidden flex flex-col justify-center px-2"
                                style={{ width: `${widthPercent}%` }}
                                title={appointment.title}
                              >
                                <div className="flex items-center justify-between gap-1 mb-0.5">
                                  <span className={`${textMain} truncate`}>{appointment.title}</span>
                                  <span className={`text-[10px] sm:text-xs ${textSecondary} whitespace-nowrap`}>
                                    {String(appointment.hour).padStart(2, '0')}:00
                                  </span>
                                </div>
                              </div>
                            ))}
                          </div>
                        ) : (
                          <div className={`text-sm ${textSecondary} w-full`}>
                            Cliquez pour ajouter un rendez-vous
                          </div>
                        )}
                      </div>
                    )
                  })}
              </div>
            </div>

            {/* Modal création / édition de rendez-vous simples */}
            {showAppointmentModal && (
              <>
                <div
                  className="fixed inset-0 bg-black/40 z-40"
                  onClick={() => {
                    setShowAppointmentModal(false)
                    setEditingAppointment(null)
                    setAppointmentTitle('')
                    setAppointmentHour(null)
                    setAppointmentDate('')
                  }}
                />
                {/* Fenêtre pop-up indépendante, centrée écran */}
                <div className="fixed inset-0 z-50 flex items-center justify-center px-4 py-8">
                  <div
                    className={`${bgCard} border ${borderColor} rounded-2xl shadow-xl w-full max-w-4xl max-h-[85vh] flex flex-col`}
                    onClick={(e) => e.stopPropagation()}
                  >
                    {/* Header */}
                    <div className="flex items-center justify-between px-6 py-4 border-b border-gray-600">
                      <h3 className={`text-xl font-bold ${textPrimary}`}>
                        {editingAppointment ? 'Modifier le rendez-vous' : 'Nouveau rendez-vous'}
                      </h3>
                    </div>

                    {/* Contenu scrollable */}
                    <div className="flex-1 overflow-y-auto px-6 pt-4 pb-4 space-y-6">
                      {/* Section 1 : Informations Événement */}
                      <div>
                        <h4 className={`text-base font-semibold mb-3 ${textPrimary}`}>Informations de l'événement</h4>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                          <div>
                            <label className={`block text-sm mb-1 ${textSecondary}`}>Branche</label>
                            <select
                              value={appointmentBranch}
                              onChange={(e) => setAppointmentBranch(e.target.value)}
                              className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                            >
                              <option value="">Sélectionner une branche</option>
                              <option value="Rishon LeZion">Rishon LeZion</option>
                              <option value="Petah Tikva">Petah Tikka</option>
                            </select>
                          </div>

                          <div>
                            <label className={`block text-sm mb-1 ${textSecondary}`}>Type d'événement</label>
                            <select
                              value={appointmentEventType}
                              onChange={(e) => setAppointmentEventType(e.target.value)}
                              className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                            >
                              <option value="">Sélectionner un type</option>
                              <option value="birthday">Anniversaire</option>
                              <option value="bar_bat_mitzvah">Bar/Bat Mitzvah</option>
                              <option value="corporate">Corporate</option>
                              <option value="party">Soirée</option>
                              <option value="other">Autre</option>
                            </select>
                          </div>

                          <div>
                            <label className={`block text-sm mb-1 ${textSecondary}`}>Date</label>
                            <input
                              type="date"
                              value={appointmentDate}
                              onChange={(e) => setAppointmentDate(e.target.value)}
                              className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                            />
                          </div>

                          <div className="grid grid-cols-2 gap-2">
                            <div>
                              <label className={`block text-sm mb-1 ${textSecondary}`}>Heure</label>
                              <select
                                value={appointmentHour ?? ''}
                                onChange={(e) => setAppointmentHour(Number(e.target.value))}
                                className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                              >
                                <option value="">Sélectionner une heure</option>
                                {timeSlots.map((slot) => (
                                  <option key={slot.hour} value={slot.hour}>
                                    {slot.label}
                                  </option>
                                ))}
                              </select>
                            </div>
                            <div>
                              <label className={`block text-sm mb-1 ${textSecondary}`}>Durée (min)</label>
                              <input
                                type="number"
                                min={15}
                                step={15}
                                value={appointmentDuration ?? ''}
                                onChange={(e) =>
                                  setAppointmentDuration(e.target.value ? Number(e.target.value) : null)
                                }
                                className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                              />
                            </div>
                          </div>

                          <div>
                            <label className={`block text-sm mb-1 ${textSecondary}`}>Titre / Nom de l'événement</label>
                            <input
                              type="text"
                              value={appointmentTitle}
                              onChange={(e) => setAppointmentTitle(e.target.value)}
                              className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                              placeholder="Anniversaire Emma, Équipe marketing, etc."
                            />
                          </div>

                          <div>
                            <label className={`block text-sm mb-1 ${textSecondary}`}>Couleur</label>
                            <div className="flex items-center gap-3 flex-wrap">
                              {presetColors.map((color) => (
                                <button
                                  key={color}
                                  type="button"
                                  onClick={() => setAppointmentColor(color)}
                                  className={`w-8 h-8 rounded-full border-2 transition-all ${
                                    appointmentColor === color ? 'border-white ring-2 ring-offset-2 ring-primary' : 'border-gray-300'
                                  }`}
                                  style={{ backgroundColor: color }}
                                />
                              ))}
                              <span className={`text-xs ${textSecondary}`}>Couleur de l'événement dans l'agenda</span>
                            </div>
                          </div>
                        </div>

                        <div className="mt-4">
                          <label className={`block text-sm mb-1 ${textSecondary}`}>
                            Notes internes sur l'événement (pour le vendeur)
                          </label>
                          <textarea
                            value={appointmentEventNotes}
                            onChange={(e) => setAppointmentEventNotes(e.target.value)}
                            rows={3}
                            className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                            placeholder="Contraintes particulières de salle, déco, timing, etc."
                          />
                        </div>
                      </div>

                      {/* Section 2 : Informations Client & Jeu */}
                      <div>
                        <h4 className={`text-base font-semibold mb-3 ${textPrimary}`}>Informations client & jeu</h4>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                          <div>
                            <label className={`block text-sm mb-1 ${textSecondary}`}>Prénom</label>
                            <input
                              type="text"
                              value={appointmentCustomerFirstName}
                              onChange={(e) => setAppointmentCustomerFirstName(e.target.value)}
                              className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                            />
                          </div>
                          <div>
                            <label className={`block text-sm mb-1 ${textSecondary}`}>Nom</label>
                            <input
                              type="text"
                              value={appointmentCustomerLastName}
                              onChange={(e) => setAppointmentCustomerLastName(e.target.value)}
                              className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                            />
                          </div>

                          <div>
                            <label className={`block text-sm mb-1 ${textSecondary}`}>Téléphone</label>
                            <input
                              type="tel"
                              value={appointmentCustomerPhone}
                              onChange={(e) => setAppointmentCustomerPhone(e.target.value)}
                              className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                            />
                          </div>
                          <div>
                            <label className={`block text-sm mb-1 ${textSecondary}`}>Email</label>
                            <input
                              type="email"
                              value={appointmentCustomerEmail}
                              onChange={(e) => setAppointmentCustomerEmail(e.target.value)}
                              className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                            />
                          </div>

                          <div className="grid grid-cols-2 gap-2">
                            <div>
                              <label className={`block text-sm mb-1 ${textSecondary}`}>Durée de jeu (min)</label>
                              <input
                                type="number"
                                min={15}
                                step={15}
                                value={appointmentGameDuration ?? ''}
                                onChange={(e) =>
                                  setAppointmentGameDuration(e.target.value ? Number(e.target.value) : null)
                                }
                                className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                              />
                            </div>
                            <div>
                              <label className={`block text-sm mb-1 ${textSecondary}`}>Participants</label>
                              <input
                                type="number"
                                min={1}
                                value={appointmentParticipants ?? ''}
                                onChange={(e) =>
                                  setAppointmentParticipants(e.target.value ? Number(e.target.value) : null)
                                }
                                className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                              />
                            </div>
                          </div>
                        </div>

                        <div className="mt-4">
                          <label className={`block text-sm mb-1 ${textSecondary}`}>
                            Notes client / demandes particulières
                          </label>
                          <textarea
                            value={appointmentCustomerNotes}
                            onChange={(e) => setAppointmentCustomerNotes(e.target.value)}
                            rows={3}
                            className={`w-full px-3 py-2 rounded border ${borderColor} ${inputBg} ${textMain} text-sm focus:outline-none focus:border-primary`}
                            placeholder="Allergies, langage, demandes spéciales, etc."
                          />
                        </div>
                      </div>
                    </div>

                    {/* Footer avec de l'air autour */}
                    <div className="px-6 py-4 flex justify-between gap-4 border-t border-gray-700">
                      {editingAppointment ? (
                        <button
                          onClick={() => deleteAppointment(editingAppointment.id)}
                          className="px-4 py-2 rounded-lg border border-red-500 text-red-500 text-sm hover:bg-red-500/10 transition-all"
                        >
                          Supprimer
                        </button>
                      ) : (
                        <span />
                      )}

                      <div className="flex gap-3">
                        <button
                          onClick={() => {
                            setShowAppointmentModal(false)
                            setEditingAppointment(null)
                            setAppointmentTitle('')
                            setAppointmentHour(null)
                            setAppointmentDate('')
                          }}
                          className={`px-4 py-2 rounded-lg border ${borderColor} text-sm ${textSecondary} hover:${bgCardHover} transition-all min-w-[120px]`}
                        >
                          Annuler
                        </button>
                        <button
                          onClick={saveAppointment}
                          disabled={!appointmentTitle.trim() || appointmentHour === null || !appointmentDate}
                          className="px-4 py-2 rounded-lg bg-primary text-white text-sm font-semibold disabled:opacity-50 disabled:cursor-not-allowed transition-all min-w-[140px]"
                        >
                          Enregistrer
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </>
            )}
          </div>
        )}
      </div>
    </div>
  )
}
