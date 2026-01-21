'use client'

import { createContext, useContext, useState, useCallback, ReactNode } from 'react'
import { ClaraAssistant } from './ClaraAssistant'

interface ClaraContextType {
  isOpen: boolean
  openClara: () => void
  closeClara: () => void
  toggleClara: () => void
  position: 'left' | 'right'
  setPosition: (position: 'left' | 'right') => void
}

const ClaraContext = createContext<ClaraContextType | undefined>(undefined)

export function ClaraProvider({ children }: { children: ReactNode }) {
  const [isOpen, setIsOpen] = useState(false)
  const [position, setPosition] = useState<'left' | 'right'>('right')

  const openClara = useCallback(() => setIsOpen(true), [])
  const closeClara = useCallback(() => setIsOpen(false), [])
  const toggleClara = useCallback(() => setIsOpen(prev => !prev), [])

  return (
    <ClaraContext.Provider value={{
      isOpen,
      openClara,
      closeClara,
      toggleClara,
      position,
      setPosition
    }}>
      {children}
      <ClaraAssistant
        isOpen={isOpen}
        onClose={closeClara}
        position={position}
        onPositionChange={setPosition}
      />
    </ClaraContext.Provider>
  )
}

export function useClara() {
  const context = useContext(ClaraContext)
  if (context === undefined) {
    throw new Error('useClara must be used within a ClaraProvider')
  }
  return context
}
