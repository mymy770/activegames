/**
 * Hook pour gérer les emails (historique et envoi)
 */

import { useState, useEffect, useCallback } from 'react'
import type { EmailLog, EmailLogWithRelations } from '@/lib/supabase/types'

interface EmailFilters {
  status?: string
  branchId?: string
  entityType?: string
  search?: string
  dateFrom?: string
  dateTo?: string
}

interface EmailsResponse {
  success: boolean
  data: EmailLog[]
  pagination: {
    total: number
    page: number
    limit: number
    totalPages: number
  }
  error?: string
}

interface UseEmailsReturn {
  emails: EmailLog[]
  loading: boolean
  error: string | null
  pagination: {
    total: number
    page: number
    limit: number
    totalPages: number
  }
  filters: EmailFilters
  setFilters: (filters: EmailFilters) => void
  setPage: (page: number) => void
  refresh: () => Promise<void>
  resendEmail: (emailLogId: string) => Promise<{ success: boolean; error?: string }>
  sendConfirmation: (bookingId: string) => Promise<{ success: boolean; error?: string }>
  deleteEmail: (emailLogId: string) => Promise<{ success: boolean; error?: string }>
  stats: {
    total: number
    sent: number
    failed: number
    pending: number
  }
}

export function useEmails(initialBranchId?: string): UseEmailsReturn {
  const [emails, setEmails] = useState<EmailLog[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [pagination, setPagination] = useState({
    total: 0,
    page: 1,
    limit: 20,
    totalPages: 0
  })
  const [filters, setFilters] = useState<EmailFilters>({
    branchId: initialBranchId
  })

  // Calculate stats from emails
  const stats = {
    total: pagination.total,
    sent: emails.filter(e => e.status === 'sent' || e.status === 'delivered').length,
    failed: emails.filter(e => e.status === 'failed' || e.status === 'bounced').length,
    pending: emails.filter(e => e.status === 'pending').length
  }

  // Fetch emails
  const fetchEmails = useCallback(async () => {
    setLoading(true)
    setError(null)

    try {
      const params = new URLSearchParams()
      params.set('page', pagination.page.toString())
      params.set('limit', pagination.limit.toString())

      if (filters.status) params.set('status', filters.status)
      if (filters.branchId) params.set('branch_id', filters.branchId)
      if (filters.entityType) params.set('entity_type', filters.entityType)
      if (filters.search) params.set('search', filters.search)
      if (filters.dateFrom) params.set('date_from', filters.dateFrom)
      if (filters.dateTo) params.set('date_to', filters.dateTo)

      const response = await fetch(`/api/emails?${params.toString()}`)
      const data: EmailsResponse = await response.json()

      if (!data.success) {
        throw new Error(data.error || 'Failed to fetch emails')
      }

      setEmails(data.data)
      setPagination(data.pagination)

    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to fetch emails'
      setError(message)
      console.error('Error fetching emails:', err)
    } finally {
      setLoading(false)
    }
  }, [pagination.page, pagination.limit, filters])

  // Initial fetch and when filters change
  useEffect(() => {
    fetchEmails()
  }, [fetchEmails])

  // Resend an email
  const resendEmail = async (emailLogId: string): Promise<{ success: boolean; error?: string }> => {
    try {
      const response = await fetch('/api/emails', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'resend', emailLogId })
      })

      const data = await response.json()

      if (!data.success) {
        return { success: false, error: data.error }
      }

      // Refresh the list
      await fetchEmails()

      return { success: true }
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to resend email'
      return { success: false, error: message }
    }
  }

  // Send confirmation email for a booking
  const sendConfirmation = async (bookingId: string): Promise<{ success: boolean; error?: string }> => {
    try {
      const response = await fetch('/api/emails', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ action: 'send_confirmation', bookingId })
      })

      const data = await response.json()

      if (!data.success) {
        return { success: false, error: data.error }
      }

      // Refresh the list
      await fetchEmails()

      return { success: true }
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to send email'
      return { success: false, error: message }
    }
  }

  // Delete an email log
  const deleteEmail = async (emailLogId: string): Promise<{ success: boolean; error?: string }> => {
    try {
      const response = await fetch(`/api/emails/${emailLogId}`, {
        method: 'DELETE'
      })

      const data = await response.json()

      if (!data.success) {
        return { success: false, error: data.error }
      }

      // Refresh the list
      await fetchEmails()

      return { success: true }
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to delete email'
      return { success: false, error: message }
    }
  }

  // Update filters (reset to page 1)
  const updateFilters = (newFilters: EmailFilters) => {
    setFilters(newFilters)
    setPagination(prev => ({ ...prev, page: 1 }))
  }

  // Set page
  const setPage = (page: number) => {
    setPagination(prev => ({ ...prev, page }))
  }

  return {
    emails,
    loading,
    error,
    pagination,
    filters,
    setFilters: updateFilters,
    setPage,
    refresh: fetchEmails,
    resendEmail,
    sendConfirmation,
    deleteEmail,
    stats
  }
}
