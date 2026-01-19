'use client'

import { useEffect, useState, useRef } from 'react'
import { useRouter, usePathname } from 'next/navigation'
import { getClient } from '@/lib/supabase/client'
import { Loader2 } from 'lucide-react'
import { LanguageProvider, useTranslation } from '@/contexts/LanguageContext'

function AdminLayoutContent({
  children,
}: {
  children: React.ReactNode
}) {
  const { t } = useTranslation()
  const router = useRouter()
  const pathname = usePathname()
  const [isAuthenticated, setIsAuthenticated] = useState<boolean | null>(null)
  const [isChecking, setIsChecking] = useState(true)
  const hasCheckedRef = useRef(false)

  // Vérification initiale d'authentification - seulement une fois
  useEffect(() => {
    // Skip auth check for login page
    if (pathname === '/admin/login') {
      setIsAuthenticated(true)
      setIsChecking(false)
      return
    }

    // Éviter les vérifications multiples
    if (hasCheckedRef.current && isAuthenticated === true) {
      setIsChecking(false)
      return
    }

    const checkAuth = async () => {
      const supabase = getClient()

      try {
        // Utiliser getUser() qui est plus fiable que getSession()
        // getUser() vérifie le token auprès du serveur Supabase
        const { data: { user }, error } = await supabase.auth.getUser()

        if (error || !user) {
          // Pas d'utilisateur valide
          setIsAuthenticated(false)
        } else {
          setIsAuthenticated(true)
          hasCheckedRef.current = true
        }
      } catch {
        setIsAuthenticated(false)
      } finally {
        setIsChecking(false)
      }
    }

    checkAuth()
  }, [pathname, isAuthenticated])

  // Écouter les changements d'authentification (login/logout)
  useEffect(() => {
    if (pathname === '/admin/login') {
      return
    }

    const supabase = getClient()

    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      (event, session) => {
        if (event === 'SIGNED_IN') {
          setIsAuthenticated(true)
          hasCheckedRef.current = true
        } else if (event === 'SIGNED_OUT') {
          setIsAuthenticated(false)
          hasCheckedRef.current = false
        }
        // Ne pas réagir à TOKEN_REFRESHED pour éviter les déconnexions intempestives
      }
    )

    return () => {
      subscription.unsubscribe()
    }
  }, [pathname])

  // Redirection vers login si non authentifié
  useEffect(() => {
    if (!isChecking && isAuthenticated === false && pathname !== '/admin/login') {
      router.push('/admin/login')
    }
  }, [isChecking, isAuthenticated, pathname, router])

  // Pendant la vérification de l'auth ou redirection en cours
  if (isChecking || isAuthenticated === false) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-900">
        <div className="flex flex-col items-center gap-4">
          <Loader2 className="w-8 h-8 animate-spin text-cyan-500" />
          <p className="text-gray-400">{t('admin.common.loading')}</p>
        </div>
      </div>
    )
  }

  // Authentifié - afficher le contenu
  return <>{children}</>
}

export default function AdminLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <LanguageProvider isAdmin={true}>
      <AdminLayoutContent>{children}</AdminLayoutContent>
    </LanguageProvider>
  )
}
