'use client'

import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { motion, AnimatePresence } from 'framer-motion'
import { MapPin, Calendar, Clock, ChevronRight, ChevronLeft, Check } from 'lucide-react'
import { getTranslations, getDirection, Locale, defaultLocale } from '@/i18n'
import { Header, Footer } from '@/components'

type BookingStep = 1 | 2 | 3

interface BookingData {
  branch: string | null
  date: string | null
  time: string | null
}

export default function ReservationPage() {
  const router = useRouter()
  const [locale, setLocale] = useState<Locale>(defaultLocale)
  const [translations, setTranslations] = useState(getTranslations(defaultLocale))
  const [step, setStep] = useState<BookingStep>(1)
  const [bookingData, setBookingData] = useState<BookingData>({
    branch: null,
    date: null,
    time: null,
  })

  useEffect(() => {
    const savedLocale = localStorage.getItem('locale') as Locale
    if (savedLocale && ['en', 'he'].includes(savedLocale)) {
      setLocale(savedLocale)
      setTranslations(getTranslations(savedLocale))
    }
  }, [])

  const isRTL = locale === 'he'
  const dir = getDirection(locale)

  // Branches from translations
  const branches = translations.branches?.items || []

  // Generate available dates (next 30 days)
  const getAvailableDates = () => {
    const dates: string[] = []
    const today = new Date()
    for (let i = 1; i <= 30; i++) {
      const date = new Date(today)
      date.setDate(today.getDate() + i)
      dates.push(date.toISOString().split('T')[0])
    }
    return dates
  }

  // Generate available time slots (10:00 to 22:00, every hour)
  const getAvailableTimes = () => {
    const times: string[] = []
    for (let hour = 10; hour <= 22; hour++) {
      times.push(`${hour.toString().padStart(2, '0')}:00`)
    }
    return times
  }

  const handleBranchSelect = (branchName: string) => {
    setBookingData({ ...bookingData, branch: branchName })
    setTimeout(() => setStep(2), 300)
  }

  const handleDateSelect = (date: string) => {
    setBookingData({ ...bookingData, date })
    setTimeout(() => setStep(3), 300)
  }

  const handleTimeSelect = (time: string) => {
    setBookingData({ ...bookingData, time })
  }

  const handleNext = () => {
    if (step < 3) {
      setStep((step + 1) as BookingStep)
    }
  }

  const handlePrevious = () => {
    if (step > 1) {
      setStep((step - 1) as BookingStep)
    }
  }

  const handleConfirm = () => {
    // TODO: Submit booking data to backend
    console.log('Booking confirmed:', bookingData)
    alert(`Reservation confirmed!\nBranch: ${bookingData.branch}\nDate: ${bookingData.date}\nTime: ${bookingData.time}`)
    router.push('/')
  }

  const formatDate = (dateString: string) => {
    const date = new Date(dateString + 'T00:00:00')
    const options: Intl.DateTimeFormatOptions = { 
      weekday: 'long', 
      year: 'numeric', 
      month: 'long', 
      day: 'numeric' 
    }
    return date.toLocaleDateString(isRTL ? 'he-IL' : 'en-US', options)
  }

  const availableDates = getAvailableDates()
  const availableTimes = getAvailableTimes()

  const handleLocaleChange = (newLocale: Locale) => {
    setLocale(newLocale)
    setTranslations(getTranslations(newLocale))
    localStorage.setItem('locale', newLocale)
    document.documentElement.dir = getDirection(newLocale)
    document.documentElement.lang = newLocale
  }

  return (
    <div dir={dir}>
      <Header 
        translations={translations} 
        locale={locale} 
        onLocaleChange={handleLocaleChange} 
      />
      <div className="min-h-screen bg-dark text-white pt-24 pb-12">
        <div className="container mx-auto px-4 max-w-4xl">
          {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-center mb-8"
        >
          <h1 className="section-title text-4xl md:text-5xl mb-4">
            {translations.booking?.title || 'Book your session'}
          </h1>
        </motion.div>

        {/* Progress Steps */}
        <div className="flex justify-center items-center mb-12 gap-4">
          {[1, 2, 3].map((s) => (
            <div key={s} className="flex items-center">
              <div
                className={`w-12 h-12 rounded-full flex items-center justify-center font-bold transition-all duration-300 ${
                  step >= s
                    ? 'bg-primary text-dark shadow-[0_0_20px_rgba(0,240,255,0.5)]'
                    : 'bg-dark-200 text-gray-400'
                }`}
              >
                {step > s ? <Check className="w-6 h-6" /> : s}
              </div>
              {s < 3 && (
                <div
                  className={`w-16 h-1 mx-2 transition-all duration-300 ${
                    step > s ? 'bg-primary' : 'bg-dark-200'
                  }`}
                />
              )}
            </div>
          ))}
        </div>

        {/* Steps Content */}
        <AnimatePresence mode="wait">
          {/* Step 1: Select Branch */}
          {step === 1 && (
            <motion.div
              key="step1"
              initial={{ opacity: 0, x: isRTL ? 50 : -50 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: isRTL ? -50 : 50 }}
              className="bg-dark-100/50 backdrop-blur-sm rounded-2xl p-8 border border-primary/30"
            >
              <div className="text-center mb-8">
                <MapPin className="w-16 h-16 text-primary mx-auto mb-4" />
                <h2 className="text-2xl font-bold mb-2" style={{ fontFamily: 'Orbitron, sans-serif' }}>
                  {translations.booking?.step1?.title || 'Select branch'}
                </h2>
                <p className="text-gray-400">{translations.booking?.step1?.subtitle || 'Choose the location where you want to play'}</p>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {branches.map((branch, index) => (
                  <motion.button
                    key={index}
                    onClick={() => handleBranchSelect(branch.name)}
                    className="bg-dark-200/50 hover:bg-dark-200 border-2 border-primary/30 hover:border-primary/70 rounded-xl p-6 text-left transition-all duration-300 hover:shadow-[0_0_20px_rgba(0,240,255,0.3)]"
                    whileHover={{ scale: 1.02 }}
                    whileTap={{ scale: 0.98 }}
                  >
                    <div className="flex items-start gap-4">
                      <MapPin className="w-6 h-6 text-primary flex-shrink-0 mt-1" />
                      <div>
                        <h3 className="text-xl font-bold mb-2" style={{ fontFamily: 'Poppins, sans-serif' }}>
                          {branch.name}
                        </h3>
                        <p className="text-gray-400 text-sm mb-1" style={{ fontFamily: 'Poppins, sans-serif' }}>
                          {branch.address}
                        </p>
                        <p className="text-primary text-sm" style={{ fontFamily: 'Poppins, sans-serif' }}>
                          {branch.venue}
                        </p>
                      </div>
                    </div>
                  </motion.button>
                ))}
              </div>
            </motion.div>
          )}

          {/* Step 2: Select Date */}
          {step === 2 && (
            <motion.div
              key="step2"
              initial={{ opacity: 0, x: isRTL ? 50 : -50 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: isRTL ? -50 : 50 }}
              className="bg-dark-100/50 backdrop-blur-sm rounded-2xl p-8 border border-primary/30"
            >
              <div className="text-center mb-8">
                <Calendar className="w-16 h-16 text-primary mx-auto mb-4" />
                <h2 className="text-2xl font-bold mb-2" style={{ fontFamily: 'Orbitron, sans-serif' }}>
                  {translations.booking?.step2?.title || 'Select date'}
                </h2>
                <p className="text-gray-400">{translations.booking?.step2?.subtitle || 'Choose the day for your session'}</p>
              </div>

              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 max-h-96 overflow-y-auto pr-2">
                {availableDates.map((date) => (
                  <motion.button
                    key={date}
                    onClick={() => handleDateSelect(date)}
                    className={`rounded-xl p-4 border-2 transition-all duration-300 ${
                      bookingData.date === date
                        ? 'bg-primary text-dark border-primary shadow-[0_0_20px_rgba(0,240,255,0.5)]'
                        : 'bg-dark-200/50 border-primary/30 hover:border-primary/70 text-white'
                    }`}
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                  >
                    <div className="text-center">
                      <div className="text-xs text-gray-400 mb-1" style={{ fontFamily: 'Poppins, sans-serif' }}>
                        {new Date(date + 'T00:00:00').toLocaleDateString(isRTL ? 'he-IL' : 'en-US', { weekday: 'short' })}
                      </div>
                      <div className="text-lg font-bold" style={{ fontFamily: 'Poppins, sans-serif' }}>
                        {new Date(date + 'T00:00:00').getDate()}
                      </div>
                      <div className="text-xs text-gray-400" style={{ fontFamily: 'Poppins, sans-serif' }}>
                        {new Date(date + 'T00:00:00').toLocaleDateString(isRTL ? 'he-IL' : 'en-US', { month: 'short' })}
                      </div>
                    </div>
                  </motion.button>
                ))}
              </div>

              {bookingData.date && (
                <div className="mt-6 text-center">
                  <button
                    onClick={handleNext}
                    className="glow-button inline-flex items-center gap-2"
                  >
                    {translations.booking?.next || 'Next'}
                    <ChevronRight className="w-5 h-5" />
                  </button>
                </div>
              )}
            </motion.div>
          )}

          {/* Step 3: Select Time */}
          {step === 3 && (
            <motion.div
              key="step3"
              initial={{ opacity: 0, x: isRTL ? 50 : -50 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: isRTL ? -50 : 50 }}
              className="bg-dark-100/50 backdrop-blur-sm rounded-2xl p-8 border border-primary/30"
            >
              <div className="text-center mb-8">
                <Clock className="w-16 h-16 text-primary mx-auto mb-4" />
                <h2 className="text-2xl font-bold mb-2" style={{ fontFamily: 'Orbitron, sans-serif' }}>
                  {translations.booking?.step3?.title || 'Select time'}
                </h2>
                <p className="text-gray-400">{translations.booking?.step3?.subtitle || 'Choose the time slot'}</p>
              </div>

              <div className="grid grid-cols-3 md:grid-cols-4 gap-4 mb-6">
                {availableTimes.map((time) => (
                  <motion.button
                    key={time}
                    onClick={() => handleTimeSelect(time)}
                    className={`rounded-xl p-4 border-2 transition-all duration-300 ${
                      bookingData.time === time
                        ? 'bg-primary text-dark border-primary shadow-[0_0_20px_rgba(0,240,255,0.5)]'
                        : 'bg-dark-200/50 border-primary/30 hover:border-primary/70 text-white'
                    }`}
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                  >
                    <div className="text-center font-bold" style={{ fontFamily: 'Poppins, sans-serif' }}>
                      {time}
                    </div>
                  </motion.button>
                ))}
              </div>

              {/* Booking Summary */}
              {bookingData.time && (
                <motion.div
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  className="bg-dark-200/50 rounded-xl p-6 mb-6 border border-primary/30"
                >
                  <h3 className="text-xl font-bold mb-4" style={{ fontFamily: 'Orbitron, sans-serif' }}>
                    Booking Summary
                  </h3>
                  <div className="space-y-2" style={{ fontFamily: 'Poppins, sans-serif' }}>
                    <div className="flex justify-between">
                      <span className="text-gray-400">Branch:</span>
                      <span className="font-bold">{bookingData.branch}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-gray-400">Date:</span>
                      <span className="font-bold">{bookingData.date && formatDate(bookingData.date)}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-gray-400">Time:</span>
                      <span className="font-bold">{bookingData.time}</span>
                    </div>
                  </div>
                </motion.div>
              )}
            </motion.div>
          )}
        </AnimatePresence>

        {/* Navigation Buttons */}
        <div className="flex justify-between mt-8">
          <button
            onClick={handlePrevious}
            disabled={step === 1}
            className={`inline-flex items-center gap-2 px-6 py-3 rounded-xl transition-all duration-300 ${
              step === 1
                ? 'bg-dark-200/50 text-gray-500 cursor-not-allowed'
                : 'bg-dark-200/50 hover:bg-dark-200 text-white border border-primary/30 hover:border-primary/70'
            }`}
          >
            <ChevronLeft className="w-5 h-5" />
            {translations.booking?.previous || 'Previous'}
          </button>

          {step === 3 && bookingData.time && (
            <button
              onClick={handleConfirm}
              className="glow-button inline-flex items-center gap-2"
            >
              {translations.booking?.confirm || 'Confirm booking'}
              <Check className="w-5 h-5" />
            </button>
          )}
        </div>
        </div>
      </div>
      <Footer translations={translations} />
    </div>
  )
}
