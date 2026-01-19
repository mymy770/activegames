/**
 * Hook pour gérer les templates d'emails
 */

import { useState, useEffect, useCallback } from 'react'
import type { EmailTemplate } from '@/lib/supabase/types'

interface UseEmailTemplatesReturn {
  templates: EmailTemplate[]
  loading: boolean
  error: string | null
  refresh: () => Promise<void>
  createTemplate: (data: Partial<EmailTemplate>) => Promise<{ success: boolean; data?: EmailTemplate; error?: string }>
  updateTemplate: (id: string, data: Partial<EmailTemplate>) => Promise<{ success: boolean; error?: string }>
  deleteTemplate: (id: string) => Promise<{ success: boolean; error?: string }>
  getTemplate: (id: string) => Promise<{ success: boolean; data?: EmailTemplate; error?: string }>
}

export function useEmailTemplates(): UseEmailTemplatesReturn {
  const [templates, setTemplates] = useState<EmailTemplate[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  // Fetch templates
  const fetchTemplates = useCallback(async () => {
    setLoading(true)
    setError(null)

    try {
      const response = await fetch('/api/email-templates')
      const data = await response.json()

      if (!data.success) {
        throw new Error(data.error || 'Failed to fetch templates')
      }

      setTemplates(data.data)

    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to fetch templates'
      setError(message)
      console.error('Error fetching templates:', err)
    } finally {
      setLoading(false)
    }
  }, [])

  // Initial fetch
  useEffect(() => {
    fetchTemplates()
  }, [fetchTemplates])

  // Create template
  const createTemplate = async (data: Partial<EmailTemplate>): Promise<{ success: boolean; data?: EmailTemplate; error?: string }> => {
    try {
      const response = await fetch('/api/email-templates', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      })

      const result = await response.json()

      if (!result.success) {
        return { success: false, error: result.error }
      }

      await fetchTemplates()
      return { success: true, data: result.data }
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to create template'
      return { success: false, error: message }
    }
  }

  // Update template
  const updateTemplate = async (id: string, data: Partial<EmailTemplate>): Promise<{ success: boolean; error?: string }> => {
    try {
      const response = await fetch(`/api/email-templates/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      })

      const result = await response.json()

      if (!result.success) {
        return { success: false, error: result.error }
      }

      await fetchTemplates()
      return { success: true }
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to update template'
      return { success: false, error: message }
    }
  }

  // Delete template
  const deleteTemplate = async (id: string): Promise<{ success: boolean; error?: string }> => {
    try {
      const response = await fetch(`/api/email-templates/${id}`, {
        method: 'DELETE'
      })

      const result = await response.json()

      if (!result.success) {
        return { success: false, error: result.error }
      }

      await fetchTemplates()
      return { success: true }
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to delete template'
      return { success: false, error: message }
    }
  }

  // Get single template
  const getTemplate = async (id: string): Promise<{ success: boolean; data?: EmailTemplate; error?: string }> => {
    try {
      const response = await fetch(`/api/email-templates/${id}`)
      const result = await response.json()

      if (!result.success) {
        return { success: false, error: result.error }
      }

      return { success: true, data: result.data }
    } catch (err) {
      const message = err instanceof Error ? err.message : 'Failed to get template'
      return { success: false, error: message }
    }
  }

  return {
    templates,
    loading,
    error,
    refresh: fetchTemplates,
    createTemplate,
    updateTemplate,
    deleteTemplate,
    getTemplate
  }
}
