'use client'

import { useState } from 'react'
import { motion } from 'framer-motion'
import Image from 'next/image'
import { Send, Mail, Phone, MapPin, Building } from 'lucide-react'

interface ContactSectionProps {
  translations: {
    contact: {
      title: string
      subtitle: string
      form: {
        name: string
        email: string
        message: string
        send: string
      }
      info: {
        address: string
        venue: string
        phone: string
        email: string
      }
    }
  }
}

export default function ContactSection({ translations }: ContactSectionProps) {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    message: '',
  })

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    // Form submission will be handled later
    console.log('Form submitted:', formData)
  }

  return (
    <section id="contact" className="py-10 md:py-16 relative overflow-hidden" style={{
      background: 'linear-gradient(135deg, rgba(0, 240, 255, 0.7) 0%, rgba(0, 240, 255, 0.6) 25%, rgba(0, 200, 255, 0.7) 50%, rgba(0, 240, 255, 0.6) 75%, rgba(0, 240, 255, 0.8) 100%)'
    }}>
      {/* Wave separator from previous section */}
      <div className="absolute top-0 left-0 right-0" style={{ transform: 'translateY(-100%)' }}>
        <svg viewBox="0 0 1200 120" preserveAspectRatio="none" style={{ width: '100%', height: '60px', display: 'block' }}>
          <path d="M0,60 Q300,20 600,60 T1200,60 L1200,120 L0,120 Z" fill="rgba(0, 240, 255, 0.7)" />
        </svg>
      </div>
      
      {/* Background decorative elements */}
      <div className="absolute inset-0 opacity-95">
        <div className="absolute top-0 right-1/4 w-[700px] h-[700px] bg-primary/60 rounded-full blur-[250px] animate-pulse" style={{ animationDuration: '4s', animationDelay: '1s' }} />
        <div className="absolute bottom-0 left-1/4 w-[700px] h-[700px] bg-primary/50 rounded-full blur-[250px] animate-pulse" style={{ animationDuration: '5s' }} />
        <div className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-[900px] h-[900px] bg-primary/40 rounded-full blur-[350px]" />
      </div>
      
      <div className="container mx-auto px-4 relative z-10">
        {/* Section Header */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="text-center mb-6"
        >
          <h2 className="section-title">{translations.contact.title}</h2>
          <p className="text-white max-w-2xl mx-auto text-lg" style={{ fontFamily: 'Poppins, sans-serif', textShadow: '0 2px 4px rgba(0,0,0,0.3)' }}>
            {translations.contact.subtitle}
          </p>
        </motion.div>

        <div className="max-w-6xl mx-auto">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
            {/* Contact Info */}
            <motion.div
              initial={{ opacity: 0, x: -30 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              className="space-y-6 w-full"
            >
            {/* Address */}
            <div className="flex items-start gap-4 p-4 bg-dark-100/90 backdrop-blur-sm rounded-xl border border-primary/30 hover:border-primary/50 transition-all duration-300">
              <div className="w-12 h-12 bg-primary/20 rounded-full flex items-center justify-center flex-shrink-0">
                <MapPin className="w-6 h-6 text-primary" />
              </div>
              <div>
                <p className="text-white font-medium" style={{ fontFamily: 'Poppins, sans-serif' }}>{translations.contact.info.address}</p>
                <p className="text-gray-400 text-sm mt-1" style={{ fontFamily: 'Poppins, sans-serif' }}>{translations.contact.info.venue}</p>
              </div>
            </div>

            {/* Phone */}
            <a
              href={`tel:${translations.contact.info.phone.replace(/\s/g, '')}`}
              className="flex items-center gap-4 p-4 bg-dark-100/90 backdrop-blur-sm rounded-xl border border-secondary/30 hover:border-secondary/50 transition-all duration-300 group"
            >
              <div className="w-12 h-12 bg-secondary/20 rounded-full flex items-center justify-center group-hover:bg-secondary/30 transition-colors">
                <Phone className="w-6 h-6 text-secondary" />
              </div>
              <div>
                <p className="text-gray-400 text-sm" style={{ fontFamily: 'Poppins, sans-serif' }}>Phone</p>
                <p className="text-white font-medium text-lg" style={{ fontFamily: 'Poppins, sans-serif' }}>{translations.contact.info.phone}</p>
              </div>
            </a>

            {/* Email */}
            <a
              href={`mailto:${translations.contact.info.email}`}
              className="flex items-center gap-4 p-4 bg-dark-100/90 backdrop-blur-sm rounded-xl border border-primary/30 hover:border-primary/50 transition-all duration-300 group"
            >
              <div className="w-12 h-12 bg-primary/20 rounded-full flex items-center justify-center group-hover:bg-primary/30 transition-colors">
                <Mail className="w-6 h-6 text-primary" />
              </div>
              <div>
                <p className="text-gray-400 text-sm" style={{ fontFamily: 'Poppins, sans-serif' }}>Email</p>
                <p className="text-white font-medium" style={{ fontFamily: 'Poppins, sans-serif' }}>{translations.contact.info.email}</p>
              </div>
            </a>

            {/* Laser City Partner Logo */}
            <div className="pt-6 border-t border-dark-200">
              <a 
                href="http://www.laser-city.co.il" 
                target="_blank" 
                rel="noopener noreferrer"
                className="flex items-center gap-3 opacity-60 hover:opacity-100 transition-opacity"
              >
                <Building className="w-5 h-5 text-white" />
                <span className="text-white text-sm" style={{ fontFamily: 'Poppins, sans-serif', textShadow: '0 2px 4px rgba(0,0,0,0.3)' }}>Powered by Laser City</span>
              </a>
            </div>
          </motion.div>

            {/* Contact Form */}
            <motion.div
              initial={{ opacity: 0, x: 30 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              className="w-full"
            >
            <form onSubmit={handleSubmit} className="space-y-6">
              {/* Name */}
              <div>
                <label htmlFor="name" className="block text-white mb-2 text-sm" style={{ fontFamily: 'Poppins, sans-serif', textShadow: '0 2px 4px rgba(0,0,0,0.3)' }}>
                  {translations.contact.form.name}
                </label>
                <input
                  type="text"
                  id="name"
                  value={formData.name}
                  onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                  className="form-input bg-dark-100/90 backdrop-blur-sm border-primary/30"
                  required
                  style={{ fontFamily: 'Poppins, sans-serif' }}
                />
              </div>

              {/* Email */}
              <div>
                <label htmlFor="email" className="block text-white mb-2 text-sm" style={{ fontFamily: 'Poppins, sans-serif', textShadow: '0 2px 4px rgba(0,0,0,0.3)' }}>
                  {translations.contact.form.email}
                </label>
                <input
                  type="email"
                  id="email"
                  value={formData.email}
                  onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                  className="form-input bg-dark-100/90 backdrop-blur-sm border-primary/30"
                  required
                  style={{ fontFamily: 'Poppins, sans-serif' }}
                />
              </div>

              {/* Message */}
              <div>
                <label htmlFor="message" className="block text-white mb-2 text-sm" style={{ fontFamily: 'Poppins, sans-serif', textShadow: '0 2px 4px rgba(0,0,0,0.3)' }}>
                  {translations.contact.form.message}
                </label>
                <textarea
                  id="message"
                  value={formData.message}
                  onChange={(e) => setFormData({ ...formData, message: e.target.value })}
                  rows={5}
                  className="form-input bg-dark-100/90 backdrop-blur-sm border-primary/30 resize-none"
                  required
                  style={{ fontFamily: 'Poppins, sans-serif' }}
                />
              </div>

              {/* Submit Button */}
              <div className="flex justify-center">
                <button
                  type="submit"
                  className="glow-button w-auto px-8 flex items-center justify-center gap-2 text-dark font-semibold"
                  style={{ fontFamily: 'Poppins, sans-serif' }}
                >
                  <Send size={18} />
                  {translations.contact.form.send}
                </button>
              </div>
            </form>
          </motion.div>
          </div>
        </div>
      </div>
    </section>
  )
}
