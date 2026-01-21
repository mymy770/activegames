'use client'

import { useState, useRef, useEffect, useCallback } from 'react'
import {
  X,
  Send,
  Loader2,
  Maximize2,
  Minimize2,
  Move,
  Settings,
  CheckCircle,
  XCircle,
  AlertTriangle,
  Play,
  Bot,
  Sparkles,
  ChevronLeft,
  ChevronRight
} from 'lucide-react'
import Link from 'next/link'

interface ProposedAction {
  name: string
  params: Record<string, unknown>
  description: string
}

interface ChatMessage {
  role: 'user' | 'assistant'
  content: string
  proposedAction?: ProposedAction
  actionExecuted?: boolean
  actionResult?: {
    success: boolean
    message: string
    details?: Record<string, unknown>
  }
}

interface ClaraAssistantProps {
  isOpen: boolean
  onClose: () => void
  position?: 'left' | 'right'
  onPositionChange?: (position: 'left' | 'right') => void
}

export function ClaraAssistant({ isOpen, onClose, position = 'right', onPositionChange }: ClaraAssistantProps) {
  const [messages, setMessages] = useState<ChatMessage[]>([])
  const [input, setInput] = useState('')
  const [loading, setLoading] = useState(false)
  const [isExpanded, setIsExpanded] = useState(false)
  const [isDetached, setIsDetached] = useState(false)
  const [detachedPosition, setDetachedPosition] = useState({ x: 100, y: 100 })
  const [detachedSize, setDetachedSize] = useState({ width: 400, height: 500 })
  const [isDragging, setIsDragging] = useState(false)
  const [isResizing, setIsResizing] = useState(false)
  const [dragOffset, setDragOffset] = useState({ x: 0, y: 0 })

  const chatEndRef = useRef<HTMLDivElement>(null)
  const inputRef = useRef<HTMLInputElement>(null)
  const panelRef = useRef<HTMLDivElement>(null)

  // Auto-scroll to bottom
  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [messages])

  // Focus input when opening
  useEffect(() => {
    if (isOpen) {
      setTimeout(() => inputRef.current?.focus(), 100)
    }
  }, [isOpen])

  // Handle dragging for detached window
  const handleMouseDown = useCallback((e: React.MouseEvent) => {
    if (!isDetached) return
    setIsDragging(true)
    setDragOffset({
      x: e.clientX - detachedPosition.x,
      y: e.clientY - detachedPosition.y
    })
  }, [isDetached, detachedPosition])

  useEffect(() => {
    if (!isDragging) return

    const handleMouseMove = (e: MouseEvent) => {
      setDetachedPosition({
        x: e.clientX - dragOffset.x,
        y: e.clientY - dragOffset.y
      })
    }

    const handleMouseUp = () => setIsDragging(false)

    window.addEventListener('mousemove', handleMouseMove)
    window.addEventListener('mouseup', handleMouseUp)

    return () => {
      window.removeEventListener('mousemove', handleMouseMove)
      window.removeEventListener('mouseup', handleMouseUp)
    }
  }, [isDragging, dragOffset])

  // Handle resizing for detached window
  const handleResizeStart = useCallback((e: React.MouseEvent) => {
    e.stopPropagation()
    setIsResizing(true)
  }, [])

  useEffect(() => {
    if (!isResizing) return

    const handleMouseMove = (e: MouseEvent) => {
      setDetachedSize({
        width: Math.max(300, e.clientX - detachedPosition.x),
        height: Math.max(300, e.clientY - detachedPosition.y)
      })
    }

    const handleMouseUp = () => setIsResizing(false)

    window.addEventListener('mousemove', handleMouseMove)
    window.addEventListener('mouseup', handleMouseUp)

    return () => {
      window.removeEventListener('mousemove', handleMouseMove)
      window.removeEventListener('mouseup', handleMouseUp)
    }
  }, [isResizing, detachedPosition])

  // Send message to Clara
  const sendMessage = async () => {
    if (!input.trim() || loading) return

    const userMessage = input.trim()
    setInput('')
    setMessages(prev => [...prev, { role: 'user', content: userMessage }])
    setLoading(true)

    try {
      const response = await fetch('/api/admin/statistics/ask', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          question: userMessage,
          dateRange: 'month'
        })
      })

      const data = await response.json()

      if (data.success) {
        setMessages(prev => [...prev, {
          role: 'assistant',
          content: data.answer || "Je n'ai pas pu analyser votre demande.",
          proposedAction: data.proposedAction
        }])
      } else {
        setMessages(prev => [...prev, {
          role: 'assistant',
          content: data.error || "Désolé, une erreur est survenue."
        }])
      }
    } catch (error) {
      console.error('Clara error:', error)
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: "Désolé, je n'ai pas pu me connecter. Vérifiez que la clé API est configurée dans les paramètres."
      }])
    } finally {
      setLoading(false)
    }
  }

  // Execute proposed action
  const handleExecuteAction = async (action: ProposedAction, messageIndex: number) => {
    setLoading(true)
    try {
      const response = await fetch('/api/admin/statistics/ask', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          executeActions: true,
          pendingAction: {
            name: action.name,
            params: action.params
          }
        })
      })

      const data = await response.json()

      setMessages(prev => prev.map((msg, i) => {
        if (i === messageIndex) {
          return {
            ...msg,
            actionExecuted: true,
            actionResult: data.actionResult
          }
        }
        return msg
      }))
    } catch (error) {
      console.error('Action error:', error)
      setMessages(prev => prev.map((msg, i) => {
        if (i === messageIndex) {
          return {
            ...msg,
            actionExecuted: true,
            actionResult: { success: false, message: "Erreur lors de l'exécution" }
          }
        }
        return msg
      }))
    } finally {
      setLoading(false)
    }
  }

  // Cancel action
  const handleCancelAction = (messageIndex: number) => {
    setMessages(prev => prev.map((msg, i) => {
      if (i === messageIndex) {
        return {
          ...msg,
          actionExecuted: true,
          actionResult: { success: false, message: "Action annulée" }
        }
      }
      return msg
    }))
  }

  // Handle key press
  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault()
      sendMessage()
    }
  }

  if (!isOpen) return null

  // Determine panel styles based on mode
  const getPanelStyles = () => {
    if (isDetached) {
      return {
        position: 'fixed' as const,
        left: detachedPosition.x,
        top: detachedPosition.y,
        width: detachedSize.width,
        height: detachedSize.height,
        zIndex: 9999
      }
    }

    const baseStyles = {
      position: 'fixed' as const,
      top: 0,
      bottom: 0,
      zIndex: 50,
      width: isExpanded ? '50vw' : '380px',
      maxWidth: isExpanded ? '800px' : '380px',
      transition: 'width 0.3s ease'
    }

    if (position === 'left') {
      return { ...baseStyles, left: 0 }
    }
    return { ...baseStyles, right: 0 }
  }

  const quickPrompts = [
    { icon: '📊', text: "Résume les stats du mois", category: 'stats' },
    { icon: '💰', text: "Quel est mon CA ce mois ?", category: 'stats' },
    { icon: '⚡', text: "Y a-t-il des problèmes à corriger ?", category: 'action' },
    { icon: '🧹', text: "Ferme les commandes payées", category: 'action' },
    { icon: '❓', text: "Comment créer une commande ?", category: 'help' },
  ]

  return (
    <>
      {/* Backdrop for side panel mode */}
      {!isDetached && (
        <div
          className="fixed inset-0 bg-black/50 z-40"
          onClick={onClose}
        />
      )}

      {/* Main Panel */}
      <div
        ref={panelRef}
        style={getPanelStyles()}
        className={`flex flex-col bg-dark-100 shadow-2xl ${
          isDetached ? 'rounded-xl border border-primary/30' : ''
        } ${!isDetached && position === 'left' ? 'border-r' : !isDetached ? 'border-l' : ''} border-primary/20`}
      >
        {/* Header */}
        <div
          className={`flex items-center justify-between px-4 py-3 border-b border-primary/20 bg-gradient-to-r from-primary/10 to-purple-500/10 ${
            isDetached ? 'cursor-move rounded-t-xl' : ''
          }`}
          onMouseDown={isDetached ? handleMouseDown : undefined}
        >
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-full bg-gradient-to-r from-primary to-purple-500 flex items-center justify-center">
              <Sparkles className="w-4 h-4 text-white" />
            </div>
            <div>
              <h3 className="font-bold text-white text-sm">Clara</h3>
              <p className="text-xs text-gray-400">Assistant IA</p>
            </div>
          </div>

          <div className="flex items-center gap-1">
            {/* Position toggle (only in side panel mode) */}
            {!isDetached && onPositionChange && (
              <button
                onClick={() => onPositionChange(position === 'left' ? 'right' : 'left')}
                className="p-1.5 hover:bg-white/10 rounded-lg transition-colors"
                title={position === 'left' ? 'Déplacer à droite' : 'Déplacer à gauche'}
              >
                {position === 'left' ? (
                  <ChevronRight className="w-4 h-4 text-gray-400" />
                ) : (
                  <ChevronLeft className="w-4 h-4 text-gray-400" />
                )}
              </button>
            )}

            {/* Detach/Attach button */}
            <button
              onClick={() => setIsDetached(!isDetached)}
              className="p-1.5 hover:bg-white/10 rounded-lg transition-colors"
              title={isDetached ? 'Attacher au côté' : 'Détacher en fenêtre'}
            >
              <Move className="w-4 h-4 text-gray-400" />
            </button>

            {/* Expand/Collapse (only in side panel mode) */}
            {!isDetached && (
              <button
                onClick={() => setIsExpanded(!isExpanded)}
                className="p-1.5 hover:bg-white/10 rounded-lg transition-colors"
                title={isExpanded ? 'Réduire' : 'Agrandir'}
              >
                {isExpanded ? (
                  <Minimize2 className="w-4 h-4 text-gray-400" />
                ) : (
                  <Maximize2 className="w-4 h-4 text-gray-400" />
                )}
              </button>
            )}

            {/* Settings link */}
            <Link
              href="/admin/clara/settings"
              className="p-1.5 hover:bg-white/10 rounded-lg transition-colors"
              title="Paramètres de Clara"
            >
              <Settings className="w-4 h-4 text-gray-400" />
            </Link>

            {/* Close */}
            <button
              onClick={onClose}
              className="p-1.5 hover:bg-white/10 rounded-lg transition-colors"
              title="Fermer"
            >
              <X className="w-4 h-4 text-gray-400" />
            </button>
          </div>
        </div>

        {/* Chat Area */}
        <div className="flex-1 overflow-y-auto p-4 space-y-4">
          {messages.length === 0 ? (
            <div className="text-center py-8">
              <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-gradient-to-r from-primary/20 to-purple-500/20 flex items-center justify-center">
                <Bot className="w-8 h-8 text-primary" />
              </div>
              <h4 className="text-white font-medium mb-2">Bonjour ! Je suis Clara</h4>
              <p className="text-gray-400 text-sm mb-6">
                Votre assistante IA. Je peux analyser vos données, effectuer des actions, et vous aider.
              </p>

              {/* Quick prompts */}
              <div className="space-y-2">
                {quickPrompts.map((prompt, i) => (
                  <button
                    key={i}
                    onClick={() => setInput(prompt.text)}
                    className={`w-full text-left px-3 py-2 rounded-lg border transition-colors text-sm ${
                      prompt.category === 'stats'
                        ? 'border-primary/30 hover:border-primary hover:bg-primary/10 text-primary/80'
                        : prompt.category === 'action'
                        ? 'border-orange-500/30 hover:border-orange-500 hover:bg-orange-500/10 text-orange-400/80'
                        : 'border-green-500/30 hover:border-green-500 hover:bg-green-500/10 text-green-400/80'
                    }`}
                  >
                    <span className="mr-2">{prompt.icon}</span>
                    {prompt.text}
                  </button>
                ))}
              </div>
            </div>
          ) : (
            <>
              {messages.map((msg, i) => (
                <div key={i} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
                  <div className={`max-w-[85%] rounded-xl px-4 py-3 ${
                    msg.role === 'user'
                      ? 'bg-primary/20 text-white'
                      : 'bg-dark-200 text-gray-200'
                  }`}>
                    {msg.role === 'assistant' && (
                      <div className="flex items-center gap-2 mb-2 text-xs text-primary/70">
                        <Sparkles className="w-3 h-3" />
                        Clara
                      </div>
                    )}
                    <p className="whitespace-pre-wrap text-sm">{msg.content}</p>

                    {/* Proposed Action */}
                    {msg.proposedAction && !msg.actionExecuted && (
                      <div className="mt-3 p-3 bg-dark-300/80 rounded-lg border border-orange-500/30">
                        <div className="flex items-center gap-2 text-orange-400 text-xs font-medium mb-2">
                          <AlertTriangle className="w-3 h-3" />
                          Action proposée
                        </div>
                        <p className="text-white text-xs mb-3">{msg.proposedAction.description}</p>
                        <div className="flex gap-2">
                          <button
                            onClick={() => handleExecuteAction(msg.proposedAction!, i)}
                            disabled={loading}
                            className="flex items-center gap-1 px-2 py-1 bg-green-600/20 border border-green-500 rounded text-green-400 text-xs hover:bg-green-600/30 disabled:opacity-50"
                          >
                            <Play className="w-3 h-3" />
                            Exécuter
                          </button>
                          <button
                            onClick={() => handleCancelAction(i)}
                            disabled={loading}
                            className="flex items-center gap-1 px-2 py-1 bg-red-600/20 border border-red-500 rounded text-red-400 text-xs hover:bg-red-600/30 disabled:opacity-50"
                          >
                            <XCircle className="w-3 h-3" />
                            Annuler
                          </button>
                        </div>
                      </div>
                    )}

                    {/* Action Result */}
                    {msg.actionExecuted && msg.actionResult && (
                      <div className={`mt-3 p-2 rounded-lg border text-xs ${
                        msg.actionResult.success
                          ? 'bg-green-900/20 border-green-500/30 text-green-400'
                          : 'bg-red-900/20 border-red-500/30 text-red-400'
                      }`}>
                        <div className="flex items-center gap-1 mb-1">
                          {msg.actionResult.success ? (
                            <CheckCircle className="w-3 h-3" />
                          ) : (
                            <XCircle className="w-3 h-3" />
                          )}
                          {msg.actionResult.success ? 'Effectuée' : 'Non effectuée'}
                        </div>
                        <p className="text-gray-300">{msg.actionResult.message}</p>
                      </div>
                    )}
                  </div>
                </div>
              ))}

              {loading && (
                <div className="flex justify-start">
                  <div className="bg-dark-200 rounded-xl px-4 py-2 flex items-center gap-2">
                    <Loader2 className="w-4 h-4 animate-spin text-primary" />
                    <span className="text-sm text-gray-400">Clara réfléchit...</span>
                  </div>
                </div>
              )}

              <div ref={chatEndRef} />
            </>
          )}
        </div>

        {/* Input Area */}
        <div className="p-4 border-t border-primary/20">
          <div className="flex gap-2">
            <input
              ref={inputRef}
              type="text"
              value={input}
              onChange={(e) => setInput(e.target.value)}
              onKeyPress={handleKeyPress}
              placeholder="Posez une question à Clara..."
              disabled={loading}
              className="flex-1 bg-dark-200 border border-primary/20 rounded-xl px-4 py-2 text-white text-sm placeholder-gray-500 focus:outline-none focus:border-primary disabled:opacity-50"
            />
            <button
              onClick={sendMessage}
              disabled={loading || !input.trim()}
              className="p-2 bg-gradient-to-r from-primary to-purple-500 rounded-xl text-white hover:opacity-90 disabled:opacity-50 transition-opacity"
            >
              <Send className="w-5 h-5" />
            </button>
          </div>
        </div>

        {/* Resize handle for detached mode */}
        {isDetached && (
          <div
            className="absolute bottom-0 right-0 w-4 h-4 cursor-se-resize"
            onMouseDown={handleResizeStart}
          >
            <svg className="w-4 h-4 text-gray-600" viewBox="0 0 24 24" fill="currentColor">
              <path d="M22 22H20V20H22V22ZM22 18H18V22H16V18H22V18ZM14 22H12V18H18V16H12V14H18V12H12V10H18V8H12V6H18V4H20V18H22V20H20V22H18V20H16V22H14Z" />
            </svg>
          </div>
        )}
      </div>
    </>
  )
}
