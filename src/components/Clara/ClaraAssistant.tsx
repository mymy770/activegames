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
  Sparkles,
  ChevronLeft,
  ChevronRight,
  RotateCcw,
  Mic,
  MicOff
} from 'lucide-react'
import Link from 'next/link'

interface ProposedAction {
  name: string
  params: Record<string, unknown>
  description: string
}

interface ChatMessage {
  id?: string
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
  theme?: 'light' | 'dark'
}

export function ClaraAssistant({
  isOpen,
  onClose,
  position = 'right',
  onPositionChange,
  theme = 'dark'
}: ClaraAssistantProps) {
  const [messages, setMessages] = useState<ChatMessage[]>([])
  const [conversationId, setConversationId] = useState<string | null>(null)
  const [input, setInput] = useState('')
  const [loading, setLoading] = useState(false)
  const [isExpanded, setIsExpanded] = useState(false)
  const [isDetached, setIsDetached] = useState(false)
  const [detachedPosition, setDetachedPosition] = useState({ x: 100, y: 100 })
  const [detachedSize, setDetachedSize] = useState({ width: 400, height: 500 })
  const [isDragging, setIsDragging] = useState(false)
  const [isResizing, setIsResizing] = useState(false)
  const [dragOffset, setDragOffset] = useState({ x: 0, y: 0 })
  const [isListening, setIsListening] = useState(false)
  const [speechSupported, setSpeechSupported] = useState(false)

  const chatEndRef = useRef<HTMLDivElement>(null)
  const inputRef = useRef<HTMLInputElement>(null)
  const panelRef = useRef<HTMLDivElement>(null)
  const recognitionRef = useRef<SpeechRecognitionInstance | null>(null)

  // Thème
  const isDark = theme === 'dark'

  // Check si la reconnaissance vocale est supportée
  useEffect(() => {
    if (typeof window !== 'undefined') {
      const SpeechRecognitionAPI = window.SpeechRecognition || window.webkitSpeechRecognition
      setSpeechSupported(!!SpeechRecognitionAPI)
      if (SpeechRecognitionAPI) {
        recognitionRef.current = new SpeechRecognitionAPI()
        recognitionRef.current.continuous = false
        recognitionRef.current.interimResults = false
        recognitionRef.current.lang = 'fr-FR'

        recognitionRef.current.onresult = (event: SpeechRecognitionEvent) => {
          const transcript = event.results[0][0].transcript
          setInput(prev => prev + ' ' + transcript.trim())
          setIsListening(false)
        }

        recognitionRef.current.onerror = () => {
          setIsListening(false)
        }

        recognitionRef.current.onend = () => {
          setIsListening(false)
        }
      }
    }
  }, [])

  // Charger l'historique de conversation au montage
  useEffect(() => {
    if (isOpen) {
      loadConversation()
    }
  }, [isOpen])

  // Auto-scroll to bottom
  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [messages])

  // Focus input when opening
  useEffect(() => {
    if (isOpen && messages.length > 0) {
      setTimeout(() => inputRef.current?.focus(), 100)
    }
  }, [isOpen, messages.length])

  // Charger la conversation active
  const loadConversation = async () => {
    try {
      const response = await fetch('/api/admin/statistics/ask')
      const data = await response.json()
      if (data.success && data.messages) {
        setConversationId(data.conversationId)
        setMessages(data.messages.map((m: { id: string; role: string; content: string; metadata?: { proposedAction?: ProposedAction; actionResult?: { success: boolean; message: string } } }) => ({
          id: m.id,
          role: m.role as 'user' | 'assistant',
          content: m.content,
          proposedAction: m.metadata?.proposedAction,
          actionExecuted: !!m.metadata?.actionResult,
          actionResult: m.metadata?.actionResult
        })))
      }
    } catch (error) {
      console.error('Error loading conversation:', error)
    }
  }

  // Nouvelle conversation
  const startNewConversation = async () => {
    try {
      await fetch('/api/admin/statistics/ask', { method: 'DELETE' })
      setMessages([])
      setConversationId(null)
      inputRef.current?.focus()
    } catch (error) {
      console.error('Error starting new conversation:', error)
    }
  }

  // Toggle microphone
  const toggleListening = () => {
    if (!recognitionRef.current) return

    if (isListening) {
      recognitionRef.current.stop()
      setIsListening(false)
    } else {
      recognitionRef.current.start()
      setIsListening(true)
    }
  }

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
          conversationId
        })
      })

      const data = await response.json()

      if (data.success) {
        if (data.conversationId) {
          setConversationId(data.conversationId)
        }
        setMessages(prev => [...prev, {
          role: 'assistant',
          content: data.answer || "Hmm, je n'ai pas compris. Tu peux reformuler ?",
          proposedAction: data.proposedAction
        }])
      } else {
        setMessages(prev => [...prev, {
          role: 'assistant',
          content: data.error || "Désolée, j'ai eu un souci. Réessaie !"
        }])
      }
    } catch (error) {
      console.error('Clara error:', error)
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: "Oups ! Je n'arrive pas à me connecter. Vérifie que la clé API est configurée."
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
          conversationId,
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

  // Classes de thème
  const themeClasses = {
    panel: isDark
      ? 'bg-gray-900 border-cyan-500/20'
      : 'bg-white border-gray-200',
    header: isDark
      ? 'border-cyan-500/20 bg-gradient-to-r from-cyan-500/10 to-purple-500/10'
      : 'border-gray-200 bg-gradient-to-r from-cyan-50 to-purple-50',
    headerText: isDark ? 'text-white' : 'text-gray-900',
    headerSubtext: isDark ? 'text-gray-400' : 'text-gray-500',
    iconButton: isDark ? 'hover:bg-white/10 text-gray-400' : 'hover:bg-gray-100 text-gray-500',
    chatBg: isDark ? '' : 'bg-gray-50',
    userBubble: isDark
      ? 'bg-cyan-500/20 text-white'
      : 'bg-cyan-500 text-white',
    assistantBubble: isDark
      ? 'bg-gray-800 text-gray-200'
      : 'bg-white text-gray-800 border border-gray-200 shadow-sm',
    input: isDark
      ? 'bg-gray-800 border-cyan-500/20 text-white placeholder-gray-500'
      : 'bg-white border-gray-300 text-gray-900 placeholder-gray-400',
    actionBox: isDark
      ? 'bg-gray-800/80 border-orange-500/30'
      : 'bg-orange-50 border-orange-200',
    backdrop: isDark ? 'bg-black/50' : 'bg-black/30'
  }

  return (
    <>
      {/* Backdrop for side panel mode */}
      {!isDetached && (
        <div
          className={`fixed inset-0 z-40 ${themeClasses.backdrop}`}
          onClick={onClose}
        />
      )}

      {/* Main Panel */}
      <div
        ref={panelRef}
        style={getPanelStyles()}
        className={`flex flex-col shadow-2xl ${themeClasses.panel} ${
          isDetached ? 'rounded-xl border' : ''
        } ${!isDetached && position === 'left' ? 'border-r' : !isDetached ? 'border-l' : ''}`}
      >
        {/* Header */}
        <div
          className={`flex items-center justify-between px-4 py-3 border-b ${themeClasses.header} ${
            isDetached ? 'cursor-move rounded-t-xl' : ''
          }`}
          onMouseDown={isDetached ? handleMouseDown : undefined}
        >
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 rounded-full bg-gradient-to-r from-cyan-500 to-purple-500 flex items-center justify-center">
              <Sparkles className="w-4 h-4 text-white" />
            </div>
            <div>
              <h3 className={`font-bold text-sm ${themeClasses.headerText}`}>Clara</h3>
              <p className={`text-xs ${themeClasses.headerSubtext}`}>Assistant IA</p>
            </div>
          </div>

          <div className="flex items-center gap-1">
            {/* Nouvelle conversation */}
            <button
              onClick={startNewConversation}
              className={`p-1.5 rounded-lg transition-colors ${themeClasses.iconButton}`}
              title="Nouvelle conversation"
            >
              <RotateCcw className="w-4 h-4" />
            </button>

            {/* Position toggle (only in side panel mode) */}
            {!isDetached && onPositionChange && (
              <button
                onClick={() => onPositionChange(position === 'left' ? 'right' : 'left')}
                className={`p-1.5 rounded-lg transition-colors ${themeClasses.iconButton}`}
                title={position === 'left' ? 'Déplacer à droite' : 'Déplacer à gauche'}
              >
                {position === 'left' ? (
                  <ChevronRight className="w-4 h-4" />
                ) : (
                  <ChevronLeft className="w-4 h-4" />
                )}
              </button>
            )}

            {/* Detach/Attach button */}
            <button
              onClick={() => setIsDetached(!isDetached)}
              className={`p-1.5 rounded-lg transition-colors ${themeClasses.iconButton}`}
              title={isDetached ? 'Attacher au côté' : 'Détacher en fenêtre'}
            >
              <Move className="w-4 h-4" />
            </button>

            {/* Expand/Collapse (only in side panel mode) */}
            {!isDetached && (
              <button
                onClick={() => setIsExpanded(!isExpanded)}
                className={`p-1.5 rounded-lg transition-colors ${themeClasses.iconButton}`}
                title={isExpanded ? 'Réduire' : 'Agrandir'}
              >
                {isExpanded ? (
                  <Minimize2 className="w-4 h-4" />
                ) : (
                  <Maximize2 className="w-4 h-4" />
                )}
              </button>
            )}

            {/* Settings link */}
            <Link
              href="/admin/clara/settings"
              className={`p-1.5 rounded-lg transition-colors ${themeClasses.iconButton}`}
              title="Paramètres de Clara"
            >
              <Settings className="w-4 h-4" />
            </Link>

            {/* Close */}
            <button
              onClick={onClose}
              className={`p-1.5 rounded-lg transition-colors ${themeClasses.iconButton}`}
              title="Fermer"
            >
              <X className="w-4 h-4" />
            </button>
          </div>
        </div>

        {/* Chat Area */}
        <div className={`flex-1 overflow-y-auto p-4 space-y-4 ${themeClasses.chatBg}`}>
          {messages.length === 0 ? (
            // Chat vierge - juste un message de bienvenue simple
            <div className="flex justify-start">
              <div className={`max-w-[85%] rounded-xl px-4 py-3 ${themeClasses.assistantBubble}`}>
                <div className={`flex items-center gap-2 mb-2 text-xs ${isDark ? 'text-cyan-400/70' : 'text-cyan-600'}`}>
                  <Sparkles className="w-3 h-3" />
                  Clara
                </div>
                <p className="text-sm">
                  Salut ! Je suis Clara, ton assistante. Tu peux me poser des questions sur tes stats, me demander de l&apos;aide ou me faire faire des actions. Qu&apos;est-ce que je peux faire pour toi ?
                </p>
              </div>
            </div>
          ) : (
            <>
              {messages.map((msg, i) => (
                <div key={i} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
                  <div className={`max-w-[85%] rounded-xl px-4 py-3 ${
                    msg.role === 'user' ? themeClasses.userBubble : themeClasses.assistantBubble
                  }`}>
                    {msg.role === 'assistant' && (
                      <div className={`flex items-center gap-2 mb-2 text-xs ${isDark ? 'text-cyan-400/70' : 'text-cyan-600'}`}>
                        <Sparkles className="w-3 h-3" />
                        Clara
                      </div>
                    )}
                    <p className="whitespace-pre-wrap text-sm">{msg.content}</p>

                    {/* Proposed Action */}
                    {msg.proposedAction && !msg.actionExecuted && (
                      <div className={`mt-3 p-3 rounded-lg border ${themeClasses.actionBox}`}>
                        <div className="flex items-center gap-2 text-orange-500 text-xs font-medium mb-2">
                          <AlertTriangle className="w-3 h-3" />
                          Action proposée
                        </div>
                        <p className={`text-xs mb-3 ${isDark ? 'text-white' : 'text-gray-700'}`}>
                          {msg.proposedAction.description}
                        </p>
                        <div className="flex gap-2">
                          <button
                            onClick={() => handleExecuteAction(msg.proposedAction!, i)}
                            disabled={loading}
                            className="flex items-center gap-1 px-2 py-1 bg-green-600/20 border border-green-500 rounded text-green-500 text-xs hover:bg-green-600/30 disabled:opacity-50"
                          >
                            <Play className="w-3 h-3" />
                            Exécuter
                          </button>
                          <button
                            onClick={() => handleCancelAction(i)}
                            disabled={loading}
                            className="flex items-center gap-1 px-2 py-1 bg-red-600/20 border border-red-500 rounded text-red-500 text-xs hover:bg-red-600/30 disabled:opacity-50"
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
                          ? 'bg-green-900/20 border-green-500/30 text-green-500'
                          : 'bg-red-900/20 border-red-500/30 text-red-500'
                      }`}>
                        <div className="flex items-center gap-1 mb-1">
                          {msg.actionResult.success ? (
                            <CheckCircle className="w-3 h-3" />
                          ) : (
                            <XCircle className="w-3 h-3" />
                          )}
                          {msg.actionResult.success ? 'Effectuée' : 'Non effectuée'}
                        </div>
                        <p className={isDark ? 'text-gray-300' : 'text-gray-600'}>{msg.actionResult.message}</p>
                      </div>
                    )}
                  </div>
                </div>
              ))}

              {loading && (
                <div className="flex justify-start">
                  <div className={`rounded-xl px-4 py-2 flex items-center gap-2 ${themeClasses.assistantBubble}`}>
                    <Loader2 className="w-4 h-4 animate-spin text-cyan-500" />
                    <span className={`text-sm ${isDark ? 'text-gray-400' : 'text-gray-500'}`}>Clara réfléchit...</span>
                  </div>
                </div>
              )}

              <div ref={chatEndRef} />
            </>
          )}
        </div>

        {/* Input Area */}
        <div className={`p-4 border-t ${isDark ? 'border-cyan-500/20' : 'border-gray-200'}`}>
          <div className="flex gap-2">
            {/* Microphone button */}
            {speechSupported && (
              <button
                onClick={toggleListening}
                disabled={loading}
                className={`p-2 rounded-xl transition-all ${
                  isListening
                    ? 'bg-red-500 text-white animate-pulse'
                    : isDark
                    ? 'bg-gray-800 text-gray-400 hover:text-white hover:bg-gray-700'
                    : 'bg-gray-100 text-gray-500 hover:text-gray-700 hover:bg-gray-200'
                } disabled:opacity-50`}
                title={isListening ? 'Arrêter' : 'Parler'}
              >
                {isListening ? <MicOff className="w-5 h-5" /> : <Mic className="w-5 h-5" />}
              </button>
            )}

            <input
              ref={inputRef}
              type="text"
              value={input}
              onChange={(e) => setInput(e.target.value)}
              onKeyPress={handleKeyPress}
              placeholder="Écris ou parle à Clara..."
              disabled={loading}
              className={`flex-1 border rounded-xl px-4 py-2 text-sm focus:outline-none focus:border-cyan-500 disabled:opacity-50 ${themeClasses.input}`}
            />
            <button
              onClick={sendMessage}
              disabled={loading || !input.trim()}
              className="p-2 bg-gradient-to-r from-cyan-500 to-purple-500 rounded-xl text-white hover:opacity-90 disabled:opacity-50 transition-opacity"
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
            <svg className={`w-4 h-4 ${isDark ? 'text-gray-600' : 'text-gray-400'}`} viewBox="0 0 24 24" fill="currentColor">
              <path d="M22 22H20V20H22V22ZM22 18H18V22H16V18H22V18ZM14 22H12V18H18V16H12V14H18V12H12V10H18V8H12V6H18V4H20V18H22V20H20V22H18V20H16V22H14Z" />
            </svg>
          </div>
        )}
      </div>
    </>
  )
}

// Types pour la reconnaissance vocale (Web Speech API)
interface SpeechRecognitionEvent extends Event {
  results: SpeechRecognitionResultList
}

interface SpeechRecognitionResultList {
  readonly length: number
  [index: number]: SpeechRecognitionResult
}

interface SpeechRecognitionResult {
  readonly length: number
  [index: number]: SpeechRecognitionAlternative
}

interface SpeechRecognitionAlternative {
  readonly transcript: string
  readonly confidence: number
}

interface SpeechRecognitionClass {
  new(): SpeechRecognitionInstance
}

interface SpeechRecognitionInstance {
  continuous: boolean
  interimResults: boolean
  lang: string
  onresult: ((event: SpeechRecognitionEvent) => void) | null
  onerror: ((event: Event) => void) | null
  onend: (() => void) | null
  start: () => void
  stop: () => void
}

declare global {
  interface Window {
    SpeechRecognition: SpeechRecognitionClass
    webkitSpeechRecognition: SpeechRecognitionClass
  }
}
