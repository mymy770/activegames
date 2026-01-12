'use client'

import Image from 'next/image'
import Link from 'next/link'

interface FooterProps {
  translations: {
    footer: {
      games_title: string
      concept_title: string
      pricing_title: string
    }
    games: {
      items: Record<string, { name: string }>
    }
  }
}

export default function Footer({ translations }: FooterProps) {
  // 8 jeux du franchisé (sans control)
  const gameNames = ['grid', 'arena', 'push', 'basketball', 'climbing', 'hide', 'flash', 'laser']

  return (
    <footer className="bg-dark border-t border-dark-200 py-12">
      <div className="container mx-auto px-4">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Logo + Laser City */}
          <div className="space-y-4">
            <Link href="/">
              <Image
                src="/images/logo.png"
                alt="Active Games"
                width={150}
                height={40}
                className="h-10 w-auto"
              />
            </Link>
            <a 
              href="http://www.laser-city.co.il" 
              target="_blank" 
              rel="noopener noreferrer"
              className="block opacity-60 hover:opacity-100 transition-opacity"
            >
              <p className="text-gray-500 text-xs">Powered by</p>
              <p className="text-gray-400 text-sm font-medium">Laser City</p>
            </a>
          </div>

          {/* Games Links */}
          <div>
            <h4 className="text-white font-bold mb-4 text-sm uppercase tracking-wider">
              <a href="#games" className="hover:text-primary transition-colors">
                {translations.footer.games_title}
              </a>
            </h4>
            <ul className="space-y-2">
              {gameNames.slice(0, 4).map((gameKey) => {
                const game = translations.games.items[gameKey]
                if (!game) return null
                return (
                  <li key={gameKey}>
                    <a
                      href="#games"
                      className="text-gray-400 hover:text-primary transition-colors text-sm"
                    >
                      {game.name}
                    </a>
                  </li>
                )
              })}
            </ul>
          </div>

          {/* More Games */}
          <div>
            <h4 className="text-white font-bold mb-4 text-sm uppercase tracking-wider opacity-0">
              More
            </h4>
            <ul className="space-y-2">
              {gameNames.slice(4).map((gameKey) => {
                const game = translations.games.items[gameKey]
                if (!game) return null
                return (
                  <li key={gameKey}>
                    <a
                      href="#games"
                      className="text-gray-400 hover:text-primary transition-colors text-sm"
                    >
                      {game.name}
                    </a>
                  </li>
                )
              })}
            </ul>
          </div>

          {/* Navigation Links */}
          <div>
            <h4 className="text-white font-bold mb-4 text-sm uppercase tracking-wider">
              Navigation
            </h4>
            <ul className="space-y-2">
              <li>
                <a
                  href="#concept"
                  className="text-gray-400 hover:text-primary transition-colors text-sm"
                >
                  {translations.footer.concept_title}
                </a>
              </li>
              <li>
                <a
                  href="#pricing"
                  className="text-gray-400 hover:text-primary transition-colors text-sm"
                >
                  {translations.footer.pricing_title}
                </a>
              </li>
              <li>
                <a
                  href="#contact"
                  className="text-gray-400 hover:text-primary transition-colors text-sm"
                >
                  Contact
                </a>
              </li>
            </ul>
          </div>
        </div>

        {/* Copyright */}
        <div className="border-t border-dark-200 mt-8 pt-8 text-center">
          <p className="text-gray-500 text-sm">
            © {new Date().getFullYear()} Active Games Rishon LeZion. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  )
}
