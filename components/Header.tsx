'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useState, useEffect } from 'react';
import { type Locale, locales } from '@/i18n';

interface HeaderProps {
  locale: Locale;
}

export default function Header({ locale }: HeaderProps) {
  const pathname = usePathname();
  const [isLanguageMenuOpen, setIsLanguageMenuOpen] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [isMobile, setIsMobile] = useState(false);

  useEffect(() => {
    const checkMobile = () => {
      setIsMobile(window.innerWidth < 768);
      if (window.innerWidth >= 768) {
        setIsMobileMenuOpen(false);
      }
    };
    
    checkMobile();
    window.addEventListener('resize', checkMobile);
    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (isMobile && isMobileMenuOpen) {
        const target = event.target as HTMLElement;
        if (!target.closest('header') && !target.closest('nav')) {
          setIsMobileMenuOpen(false);
        }
      }
    };

    if (isMobileMenuOpen) {
      document.addEventListener('click', handleClickOutside);
      return () => document.removeEventListener('click', handleClickOutside);
    }
  }, [isMobile, isMobileMenuOpen]);
  
  const menuItems = [
    { href: '#concept', label: locale === 'he' ? 'קונספט' : 'CONCEPT' },
    { href: '#games', label: locale === 'he' ? 'משחקים' : 'GAMES' },
    { href: '#price', label: locale === 'he' ? 'מחיר' : 'PRICING' },
    { href: '#contact', label: locale === 'he' ? 'צור קשר' : 'CONTACT' },
  ];

  const getLocalizedPath = (newLocale: Locale) => {
    const pathSegments = pathname.split('/');
    pathSegments[1] = newLocale;
    return pathSegments.join('/');
  };

  const languageOptions = [
    { code: 'en' as Locale, flag: '🇺🇸', label: 'English' },
    { code: 'he' as Locale, flag: '🇮🇱', label: 'עברית' },
  ];

  return (
    <header className="fixed top-0 left-0 right-0" style={{
      background: 'rgba(26, 26, 46, 0.95)',
      backdropFilter: 'blur(10px)',
      borderBottom: '1px solid rgba(8, 247, 254, 0.3)',
      zIndex: 30,
      height: '65px',
      boxShadow: '0 2px 10px rgba(0, 0, 0, 0.3)',
      width: '100%'
    }}>
      <nav style={{
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        width: '100%',
        height: '65px',
        paddingLeft: 'clamp(20px, 4vw, 60px)',
        paddingRight: 'clamp(20px, 4vw, 60px)',
        position: 'relative',
        maxWidth: '100%',
        boxSizing: 'border-box'
      }}>
        <Link href={`/${locale}`} style={{ 
          display: 'flex', 
          alignItems: 'center', 
          flexShrink: 0, 
          height: '65px',
          minWidth: 'fit-content'
        }}>
          <img
            src={locale === 'he' ? '/images/logo-empty-active-games-hebrew.png' : '/images/Logo-1.png'}
            alt="Active Games Logo"
            style={{ 
              height: 'clamp(35px, 5vw, 50px)',
              width: 'auto',
              display: 'block',
              objectFit: 'contain',
              filter: 'drop-shadow(0 2px 4px rgba(0,0,0,0.5))',
              maxWidth: '100%'
            }}
            onError={(e) => {
              console.error('Logo failed to load:', e.currentTarget.src);
            }}
          />
        </Link>
        
        {/* Desktop Menu */}
        {!isMobile && (
          <div style={{ 
            display: 'flex', 
            alignItems: 'center', 
            justifyContent: 'flex-end',
            gap: '0px',
            height: '65px',
            marginRight: '0',
            flexWrap: 'nowrap',
            flexShrink: 0
          }}>
            {menuItems.map((item) => (
              <a
                key={item.href}
                href={`/${locale}${item.href}`}
                className="uppercase transition-all"
                style={{
                  fontFamily: 'Roboto, sans-serif',
                  fontSize: 'clamp(14px, 2vw, 24px)',
                  fontWeight: 700,
                  lineHeight: '10px',
                  letterSpacing: '0.8px',
                  color: '#05f6f7',
                  paddingLeft: 'clamp(8px, 1.5vw, 18px)',
                  paddingRight: 'clamp(8px, 1.5vw, 18px)',
                  paddingTop: '11px',
                  paddingBottom: '11px',
                  position: 'relative',
                  backgroundImage: 'linear-gradient(to right, #00F0FF, #F000F0)',
                  backgroundPosition: 'bottom left',
                  backgroundRepeat: 'no-repeat',
                  backgroundSize: '0% 3px',
                  transition: 'background-size 0.3s ease, color 0.3s ease',
                  textDecoration: 'none',
                  whiteSpace: 'nowrap'
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.backgroundSize = '100% 3px';
                  e.currentTarget.style.color = '#C7D0FF';
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.backgroundSize = '0% 3px';
                  e.currentTarget.style.color = '#05f6f7';
                }}
                onClick={(e) => {
                  e.preventDefault();
                  const element = document.querySelector(item.href);
                  element?.scrollIntoView({ behavior: 'smooth' });
                }}
              >
                {item.label}
              </a>
            ))}
            <div 
              className="relative" 
              style={{ marginLeft: '8px' }}
              onMouseEnter={() => setIsLanguageMenuOpen(true)}
              onMouseLeave={() => setIsLanguageMenuOpen(false)}
            >
              <button
                onClick={() => setIsLanguageMenuOpen(!isLanguageMenuOpen)}
                style={{
                  backgroundColor: 'transparent',
                  color: '#05f6f7',
                  border: 'none',
                  fontSize: 'clamp(14px, 2vw, 24px)',
                  fontFamily: 'Roboto, sans-serif',
                  fontWeight: 700,
                  cursor: 'pointer',
                  padding: '11px clamp(8px, 1.5vw, 18px)',
                  outline: 'none',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '4px',
                  transition: 'color 0.3s ease'
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.color = '#C7D0FF';
                }}
                onMouseLeave={(e) => {
                  if (!isLanguageMenuOpen) {
                    e.currentTarget.style.color = '#05f6f7';
                  }
                }}
              >
                <span>{locale === 'en' ? '🇺🇸' : '🇮🇱'}</span>
                <svg style={{ width: '12px', height: '12px', fill: 'currentColor', transition: 'transform 0.3s ease', transform: isLanguageMenuOpen ? 'rotate(180deg)' : 'rotate(0deg)' }} xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                  <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
                </svg>
              </button>
              {isLanguageMenuOpen && (
                <div 
                  onMouseEnter={() => setIsLanguageMenuOpen(true)}
                  onMouseLeave={() => setIsLanguageMenuOpen(false)}
                  style={{
                  position: 'absolute',
                  top: 'calc(100% + 2px)',
                  right: '0',
                  backgroundColor: 'rgba(26, 26, 46, 0.95)',
                  backdropFilter: 'blur(10px)',
                  borderRadius: '4px',
                  border: '1px solid rgba(8, 247, 254, 0.3)',
                  boxShadow: '0 4px 15px rgba(0, 0, 0, 0.5)',
                  zIndex: 1000,
                  minWidth: '120px',
                  padding: '4px 0'
                }}>
                  {languageOptions.map((option) => (
                    <button
                      key={option.code}
                      onClick={() => {
                        window.location.replace(getLocalizedPath(option.code));
                      }}
                      style={{
                        width: '100%',
                        backgroundColor: 'transparent',
                        color: locale === option.code ? '#C7D0FF' : '#05f6f7',
                        border: 'none',
                        fontSize: 'clamp(14px, 2vw, 24px)',
                        fontFamily: 'Roboto, sans-serif',
                        fontWeight: locale === option.code ? 700 : 400,
                        cursor: 'pointer',
                        padding: '10px 16px',
                        textAlign: 'left',
                        outline: 'none',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '8px',
                        transition: 'background-color 0.3s ease, color 0.3s ease',
                        whiteSpace: 'nowrap'
                      }}
                      onMouseEnter={(e) => {
                        e.currentTarget.style.backgroundColor = 'rgba(8, 247, 254, 0.1)';
                        e.currentTarget.style.color = '#C7D0FF';
                      }}
                      onMouseLeave={(e) => {
                        e.currentTarget.style.backgroundColor = 'transparent';
                        e.currentTarget.style.color = locale === option.code ? '#C7D0FF' : '#05f6f7';
                      }}
                    >
                      <span style={{ fontSize: '18px' }}>{option.flag}</span>
                      <span style={{ fontSize: '14px', fontWeight: 400 }}>{option.label}</span>
                    </button>
                  ))}
                </div>
              )}
            </div>
          </div>
        )}

        {/* Mobile Hamburger Menu */}
        {isMobile && (
          <div style={{ 
            display: 'flex', 
            alignItems: 'center', 
            gap: '12px',
            height: '65px',
            flexShrink: 0
          }}>
            <button
              onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
              style={{
                backgroundColor: 'transparent',
                border: 'none',
                cursor: 'pointer',
                padding: '8px',
                display: 'flex',
                flexDirection: 'column',
                gap: '5px',
                outline: 'none'
              }}
              aria-label="Toggle menu"
            >
              <span style={{
                display: 'block',
                width: '25px',
                height: '3px',
                backgroundColor: '#05f6f7',
                borderRadius: '2px',
                transition: 'all 0.3s ease',
                transform: isMobileMenuOpen ? 'rotate(45deg) translate(8px, 8px)' : 'none'
              }}></span>
              <span style={{
                display: 'block',
                width: '25px',
                height: '3px',
                backgroundColor: '#05f6f7',
                borderRadius: '2px',
                transition: 'all 0.3s ease',
                opacity: isMobileMenuOpen ? 0 : 1
              }}></span>
              <span style={{
                display: 'block',
                width: '25px',
                height: '3px',
                backgroundColor: '#05f6f7',
                borderRadius: '2px',
                transition: 'all 0.3s ease',
                transform: isMobileMenuOpen ? 'rotate(-45deg) translate(7px, -7px)' : 'none'
              }}></span>
            </button>
          </div>
        )}

        {/* Mobile Dropdown Menu */}
        {isMobile && isMobileMenuOpen && (
          <div style={{
            position: 'fixed',
            top: '65px',
            left: 0,
            right: 0,
            backgroundColor: 'rgba(26, 26, 46, 0.98)',
            backdropFilter: 'blur(10px)',
            borderBottom: '1px solid rgba(8, 247, 254, 0.3)',
            boxShadow: '0 4px 15px rgba(0, 0, 0, 0.5)',
            zIndex: 1000,
            padding: '20px',
            display: 'flex',
            flexDirection: 'column',
            gap: '16px'
          }}>
            {menuItems.map((item) => (
              <a
                key={item.href}
                href={`/${locale}${item.href}`}
                onClick={(e) => {
                  e.preventDefault();
                  setIsMobileMenuOpen(false);
                  const element = document.querySelector(item.href);
                  element?.scrollIntoView({ behavior: 'smooth' });
                }}
                style={{
                  fontFamily: 'Roboto, sans-serif',
                  fontSize: '20px',
                  fontWeight: 700,
                  letterSpacing: '0.8px',
                  color: '#05f6f7',
                  textDecoration: 'none',
                  padding: '12px 0',
                  borderBottom: '1px solid rgba(8, 247, 254, 0.2)',
                  transition: 'color 0.3s ease'
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.color = '#C7D0FF';
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.color = '#05f6f7';
                }}
              >
                {item.label}
              </a>
            ))}
            <div style={{
              display: 'flex',
              gap: '16px',
              paddingTop: '12px',
              borderTop: '1px solid rgba(8, 247, 254, 0.2)'
            }}>
              {languageOptions.map((option) => (
                <button
                  key={option.code}
                  onClick={() => {
                    window.location.replace(getLocalizedPath(option.code));
                  }}
                  style={{
                    backgroundColor: 'transparent',
                    color: locale === option.code ? '#C7D0FF' : '#05f6f7',
                    border: '1px solid rgba(8, 247, 254, 0.3)',
                    borderRadius: '4px',
                    fontSize: '16px',
                    fontFamily: 'Roboto, sans-serif',
                    fontWeight: locale === option.code ? 700 : 400,
                    cursor: 'pointer',
                    padding: '10px 16px',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '8px',
                    transition: 'all 0.3s ease'
                  }}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.backgroundColor = 'rgba(8, 247, 254, 0.1)';
                    e.currentTarget.style.color = '#C7D0FF';
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.backgroundColor = 'transparent';
                    e.currentTarget.style.color = locale === option.code ? '#C7D0FF' : '#05f6f7';
                  }}
                >
                  <span style={{ fontSize: '20px' }}>{option.flag}</span>
                  <span>{option.label}</span>
                </button>
              ))}
            </div>
          </div>
        )}
      </nav>
    </header>
  );
}
