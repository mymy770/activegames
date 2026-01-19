'use client'

import { useState } from 'react'
import {
  Loader2,
  AlertCircle,
  Plus,
  Edit2,
  Trash2,
  CheckCircle2,
  XCircle,
  Eye,
  Code,
  Lock
} from 'lucide-react'
import { useTranslation } from '@/contexts/LanguageContext'
import { useEmailTemplates } from '@/hooks/useEmailTemplates'
import type { EmailTemplate } from '@/lib/supabase/types'

interface EmailTemplatesSectionProps {
  isDark: boolean
}

export function EmailTemplatesSection({ isDark }: EmailTemplatesSectionProps) {
  const { t } = useTranslation()
  const { templates, loading, error, createTemplate, updateTemplate, deleteTemplate, refresh } = useEmailTemplates()

  const [editingTemplate, setEditingTemplate] = useState<EmailTemplate | null>(null)
  const [showCreateModal, setShowCreateModal] = useState(false)
  const [previewTemplate, setPreviewTemplate] = useState<EmailTemplate | null>(null)
  const [saving, setSaving] = useState(false)

  // Form state
  const [formData, setFormData] = useState({
    code: '',
    name: '',
    description: '',
    subject_template: '',
    body_template: '',
    is_active: true
  })

  const handleEdit = (template: EmailTemplate) => {
    setEditingTemplate(template)
    setFormData({
      code: template.code,
      name: template.name,
      description: template.description || '',
      subject_template: template.subject_template,
      body_template: template.body_template,
      is_active: template.is_active
    })
  }

  const handleCreate = () => {
    setFormData({
      code: '',
      name: '',
      description: '',
      subject_template: '',
      body_template: '',
      is_active: true
    })
    setShowCreateModal(true)
  }

  const handleSave = async () => {
    setSaving(true)

    try {
      if (editingTemplate) {
        // Update existing
        const result = await updateTemplate(editingTemplate.id, {
          name: formData.name,
          description: formData.description || null,
          subject_template: formData.subject_template,
          body_template: formData.body_template,
          is_active: formData.is_active
        })

        if (!result.success) {
          alert(result.error || t('admin.settings.email_templates.save_error'))
          return
        }

        setEditingTemplate(null)
      } else {
        // Create new
        const result = await createTemplate({
          code: formData.code,
          name: formData.name,
          description: formData.description || null,
          subject_template: formData.subject_template,
          body_template: formData.body_template,
          is_active: formData.is_active
        })

        if (!result.success) {
          alert(result.error || t('admin.settings.email_templates.save_error'))
          return
        }

        setShowCreateModal(false)
      }
    } finally {
      setSaving(false)
    }
  }

  const handleDelete = async (template: EmailTemplate) => {
    if (template.is_system) {
      alert(t('admin.settings.email_templates.cannot_delete_system'))
      return
    }

    if (confirm(t('admin.settings.email_templates.delete_confirm', { name: template.name }))) {
      const result = await deleteTemplate(template.id)
      if (!result.success) {
        alert(result.error || t('admin.settings.email_templates.delete_error'))
      }
    }
  }

  const handleToggleActive = async (template: EmailTemplate) => {
    const result = await updateTemplate(template.id, {
      is_active: !template.is_active
    })

    if (!result.success) {
      alert(result.error || t('admin.settings.email_templates.toggle_error'))
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center py-12">
        <Loader2 className="w-8 h-8 animate-spin text-orange-500" />
      </div>
    )
  }

  if (error) {
    return (
      <div className={`p-4 rounded-lg border flex items-start gap-2 ${
        isDark
          ? 'bg-red-500/10 border-red-500/50 text-red-400'
          : 'bg-red-50 border-red-200 text-red-600'
      }`}>
        <AlertCircle className="w-5 h-5 flex-shrink-0 mt-0.5" />
        <span>{error}</span>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h2 className={`text-xl font-bold ${isDark ? 'text-white' : 'text-gray-900'}`}>
            {t('admin.settings.email_templates.title')}
          </h2>
          <p className={`text-sm ${isDark ? 'text-gray-400' : 'text-gray-600'}`}>
            {t('admin.settings.email_templates.subtitle')}
          </p>
        </div>

        <button
          onClick={handleCreate}
          className="flex items-center gap-2 px-4 py-2 bg-orange-600 hover:bg-orange-700 text-white rounded-lg transition-colors"
        >
          <Plus className="w-4 h-4" />
          {t('admin.settings.email_templates.create')}
        </button>
      </div>

      {/* Templates list */}
      <div className={`rounded-lg border overflow-hidden ${
        isDark ? 'bg-gray-800 border-gray-700' : 'bg-white border-gray-200'
      }`}>
        {templates.length === 0 ? (
          <div className={`text-center py-12 ${isDark ? 'text-gray-400' : 'text-gray-500'}`}>
            <Code className="w-12 h-12 mx-auto mb-4 opacity-50" />
            <p>{t('admin.settings.email_templates.no_templates')}</p>
          </div>
        ) : (
          <div className="divide-y divide-gray-700">
            {templates.map((template) => (
              <div
                key={template.id}
                className={`p-4 flex items-center justify-between ${
                  isDark ? 'hover:bg-gray-700/50' : 'hover:bg-gray-50'
                } transition-colors`}
              >
                <div className="flex items-center gap-4">
                  {/* Status indicator */}
                  <div className={`w-2 h-2 rounded-full ${
                    template.is_active ? 'bg-green-500' : 'bg-gray-500'
                  }`} />

                  <div>
                    <div className="flex items-center gap-2">
                      <h3 className={`font-medium ${isDark ? 'text-white' : 'text-gray-900'}`}>
                        {template.name}
                      </h3>
                      {template.is_system && (
                        <span className={`flex items-center gap-1 px-2 py-0.5 rounded text-xs ${
                          isDark ? 'bg-blue-500/20 text-blue-400' : 'bg-blue-100 text-blue-700'
                        }`}>
                          <Lock className="w-3 h-3" />
                          {t('admin.settings.email_templates.system')}
                        </span>
                      )}
                    </div>
                    <p className={`text-sm ${isDark ? 'text-gray-400' : 'text-gray-500'}`}>
                      <code className={`px-1 rounded ${isDark ? 'bg-gray-700' : 'bg-gray-100'}`}>
                        {template.code}
                      </code>
                      {template.description && ` - ${template.description}`}
                    </p>
                  </div>
                </div>

                <div className="flex items-center gap-2">
                  {/* Toggle active */}
                  <button
                    onClick={() => handleToggleActive(template)}
                    className={`p-2 rounded transition-colors ${
                      template.is_active
                        ? isDark
                          ? 'text-green-400 hover:bg-green-500/20'
                          : 'text-green-600 hover:bg-green-100'
                        : isDark
                          ? 'text-gray-500 hover:bg-gray-600'
                          : 'text-gray-400 hover:bg-gray-100'
                    }`}
                    title={template.is_active ? t('admin.settings.email_templates.deactivate') : t('admin.settings.email_templates.activate')}
                  >
                    {template.is_active ? (
                      <CheckCircle2 className="w-5 h-5" />
                    ) : (
                      <XCircle className="w-5 h-5" />
                    )}
                  </button>

                  {/* Preview */}
                  <button
                    onClick={() => setPreviewTemplate(template)}
                    className={`p-2 rounded transition-colors ${
                      isDark
                        ? 'text-gray-400 hover:bg-gray-600 hover:text-white'
                        : 'text-gray-500 hover:bg-gray-100 hover:text-gray-700'
                    }`}
                    title={t('admin.settings.email_templates.preview')}
                  >
                    <Eye className="w-5 h-5" />
                  </button>

                  {/* Edit */}
                  <button
                    onClick={() => handleEdit(template)}
                    className={`p-2 rounded transition-colors ${
                      isDark
                        ? 'text-orange-400 hover:bg-orange-500/20'
                        : 'text-orange-500 hover:bg-orange-100'
                    }`}
                    title={t('admin.settings.email_templates.edit')}
                  >
                    <Edit2 className="w-5 h-5" />
                  </button>

                  {/* Delete */}
                  {!template.is_system && (
                    <button
                      onClick={() => handleDelete(template)}
                      className={`p-2 rounded transition-colors ${
                        isDark
                          ? 'text-red-400 hover:bg-red-500/20'
                          : 'text-red-500 hover:bg-red-100'
                      }`}
                      title={t('admin.settings.email_templates.delete')}
                    >
                      <Trash2 className="w-5 h-5" />
                    </button>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Edit/Create Modal */}
      {(editingTemplate || showCreateModal) && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
          <div
            className="absolute inset-0 bg-black/50"
            onClick={() => {
              setEditingTemplate(null)
              setShowCreateModal(false)
            }}
          />
          <div className={`relative w-full max-w-3xl max-h-[90vh] overflow-y-auto rounded-xl p-6 ${
            isDark ? 'bg-gray-800' : 'bg-white'
          }`}>
            <h3 className={`text-lg font-bold mb-4 ${isDark ? 'text-white' : 'text-gray-900'}`}>
              {editingTemplate
                ? t('admin.settings.email_templates.edit_title')
                : t('admin.settings.email_templates.create_title')}
            </h3>

            <div className="space-y-4">
              {/* Code (only for new templates) */}
              {!editingTemplate && (
                <div>
                  <label className={`block text-sm font-medium mb-1 ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>
                    {t('admin.settings.email_templates.form.code')} *
                  </label>
                  <input
                    type="text"
                    value={formData.code}
                    onChange={(e) => setFormData({ ...formData, code: e.target.value.toLowerCase().replace(/[^a-z0-9_]/g, '_') })}
                    placeholder="booking_confirmation"
                    className={`w-full px-3 py-2 rounded-lg border ${
                      isDark
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'bg-gray-50 border-gray-200 text-gray-900'
                    } focus:outline-none focus:ring-2 focus:ring-orange-500`}
                  />
                  <p className={`text-xs mt-1 ${isDark ? 'text-gray-500' : 'text-gray-400'}`}>
                    {t('admin.settings.email_templates.form.code_help')}
                  </p>
                </div>
              )}

              {/* Name */}
              <div>
                <label className={`block text-sm font-medium mb-1 ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>
                  {t('admin.settings.email_templates.form.name')} *
                </label>
                <input
                  type="text"
                  value={formData.name}
                  onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                  placeholder="Confirmation de réservation"
                  className={`w-full px-3 py-2 rounded-lg border ${
                    isDark
                      ? 'bg-gray-700 border-gray-600 text-white'
                      : 'bg-gray-50 border-gray-200 text-gray-900'
                  } focus:outline-none focus:ring-2 focus:ring-orange-500`}
                />
              </div>

              {/* Description */}
              <div>
                <label className={`block text-sm font-medium mb-1 ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>
                  {t('admin.settings.email_templates.form.description')}
                </label>
                <input
                  type="text"
                  value={formData.description}
                  onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                  placeholder="Email envoyé lors de la confirmation"
                  className={`w-full px-3 py-2 rounded-lg border ${
                    isDark
                      ? 'bg-gray-700 border-gray-600 text-white'
                      : 'bg-gray-50 border-gray-200 text-gray-900'
                  } focus:outline-none focus:ring-2 focus:ring-orange-500`}
                />
              </div>

              {/* Subject */}
              <div>
                <label className={`block text-sm font-medium mb-1 ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>
                  {t('admin.settings.email_templates.form.subject')} *
                </label>
                <input
                  type="text"
                  value={formData.subject_template}
                  onChange={(e) => setFormData({ ...formData, subject_template: e.target.value })}
                  placeholder="Votre réservation est confirmée - Réf. {{booking_reference}}"
                  className={`w-full px-3 py-2 rounded-lg border ${
                    isDark
                      ? 'bg-gray-700 border-gray-600 text-white'
                      : 'bg-gray-50 border-gray-200 text-gray-900'
                  } focus:outline-none focus:ring-2 focus:ring-orange-500`}
                />
                <p className={`text-xs mt-1 ${isDark ? 'text-gray-500' : 'text-gray-400'}`}>
                  {t('admin.settings.email_templates.form.variables_help')}
                </p>
              </div>

              {/* Body */}
              <div>
                <label className={`block text-sm font-medium mb-1 ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>
                  {t('admin.settings.email_templates.form.body')} *
                </label>
                <textarea
                  value={formData.body_template}
                  onChange={(e) => setFormData({ ...formData, body_template: e.target.value })}
                  rows={12}
                  placeholder="<html>...</html>"
                  className={`w-full px-3 py-2 rounded-lg border font-mono text-sm ${
                    isDark
                      ? 'bg-gray-700 border-gray-600 text-white'
                      : 'bg-gray-50 border-gray-200 text-gray-900'
                  } focus:outline-none focus:ring-2 focus:ring-orange-500`}
                />
              </div>

              {/* Active */}
              <div className="flex items-center gap-2">
                <input
                  type="checkbox"
                  id="is_active"
                  checked={formData.is_active}
                  onChange={(e) => setFormData({ ...formData, is_active: e.target.checked })}
                  className="w-4 h-4 rounded border-gray-300 text-orange-600 focus:ring-orange-500"
                />
                <label htmlFor="is_active" className={`text-sm ${isDark ? 'text-gray-300' : 'text-gray-700'}`}>
                  {t('admin.settings.email_templates.form.active')}
                </label>
              </div>
            </div>

            <div className="mt-6 flex justify-end gap-2">
              <button
                onClick={() => {
                  setEditingTemplate(null)
                  setShowCreateModal(false)
                }}
                className={`px-4 py-2 rounded-lg ${
                  isDark
                    ? 'bg-gray-700 hover:bg-gray-600 text-white'
                    : 'bg-gray-100 hover:bg-gray-200 text-gray-700'
                }`}
              >
                {t('admin.common.cancel')}
              </button>
              <button
                onClick={handleSave}
                disabled={saving || !formData.name || !formData.subject_template || !formData.body_template || (!editingTemplate && !formData.code)}
                className="px-4 py-2 rounded-lg bg-orange-600 hover:bg-orange-700 text-white disabled:opacity-50 flex items-center gap-2"
              >
                {saving && <Loader2 className="w-4 h-4 animate-spin" />}
                {t('admin.common.save')}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Preview Modal */}
      {previewTemplate && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
          <div
            className="absolute inset-0 bg-black/50"
            onClick={() => setPreviewTemplate(null)}
          />
          <div className={`relative w-full max-w-4xl max-h-[90vh] overflow-hidden rounded-xl ${
            isDark ? 'bg-gray-800' : 'bg-white'
          }`}>
            <div className={`p-4 border-b flex items-center justify-between ${
              isDark ? 'border-gray-700' : 'border-gray-200'
            }`}>
              <h3 className={`font-bold ${isDark ? 'text-white' : 'text-gray-900'}`}>
                {t('admin.settings.email_templates.preview')}: {previewTemplate.name}
              </h3>
              <button
                onClick={() => setPreviewTemplate(null)}
                className={`p-1 rounded hover:bg-gray-600 ${isDark ? 'text-gray-400' : 'text-gray-500'}`}
              >
                <XCircle className="w-5 h-5" />
              </button>
            </div>

            <div className="p-4">
              <div className={`mb-4 p-3 rounded-lg ${isDark ? 'bg-gray-700' : 'bg-gray-100'}`}>
                <p className={`text-sm ${isDark ? 'text-gray-400' : 'text-gray-500'}`}>
                  {t('admin.settings.email_templates.form.subject')}:
                </p>
                <p className={`font-medium ${isDark ? 'text-white' : 'text-gray-900'}`}>
                  {previewTemplate.subject_template}
                </p>
              </div>

              <div className="border rounded-lg overflow-hidden" style={{ height: '60vh' }}>
                <iframe
                  srcDoc={previewTemplate.body_template}
                  className="w-full h-full bg-white"
                  title="Email preview"
                />
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
