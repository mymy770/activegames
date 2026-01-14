'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { type Locale, locales } from '@/i18n';

interface LanguageSwitcherProps {
  currentLocale: Locale;
}

export default function LanguageSwitcher({ currentLocale }: LanguageSwitcherProps) {
  const pathname = usePathname();
  const otherLocale = locales.find((l) => l !== currentLocale) as Locale;

  // Remove current locale from path and add new one
  const newPath = pathname.replace(`/${currentLocale}`, `/${otherLocale}`);

  return (
    <Link
      href={newPath}
      className="flex items-center gap-2 text-sm font-medium hover:text-blue-600 transition-colors"
    >
      <span>{otherLocale === 'he' ? '🇮🇱' : '🇺🇸'}</span>
      <span className="uppercase">{otherLocale}</span>
    </Link>
  );
}
