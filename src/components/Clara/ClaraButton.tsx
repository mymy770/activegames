'use client'

import { Sparkles } from 'lucide-react'

interface ClaraButtonProps {
  onClick: () => void
  isOpen?: boolean
}

export function ClaraButton({ onClick, isOpen }: ClaraButtonProps) {
  return (
    <button
      onClick={onClick}
      className={`relative flex items-center justify-center w-10 h-10 rounded-full transition-all duration-300 ${
        isOpen
          ? 'bg-gradient-to-r from-primary to-purple-500 shadow-lg shadow-primary/30'
          : 'bg-dark-200 hover:bg-gradient-to-r hover:from-primary/50 hover:to-purple-500/50 border border-primary/30 hover:border-primary'
      }`}
      title="Clara - Assistant IA"
    >
      <Sparkles className={`w-5 h-5 ${isOpen ? 'text-white' : 'text-primary'}`} />

      {/* Pulse animation when not open */}
      {!isOpen && (
        <span className="absolute -top-0.5 -right-0.5 flex h-3 w-3">
          <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-primary opacity-75"></span>
          <span className="relative inline-flex rounded-full h-3 w-3 bg-primary"></span>
        </span>
      )}
    </button>
  )
}
