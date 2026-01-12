export type Locale = 'en' | 'he';

export const defaultLocale: Locale = 'en';
export const locales: Locale[] = ['en', 'he'];

export const localeNames: Record<Locale, string> = {
  en: 'English',
  he: 'עברית',
};
