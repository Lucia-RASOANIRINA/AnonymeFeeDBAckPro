import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: 'FeedbackPro — Admin',
  description: 'Plateforme d’administration des retours anonymes',
  icons: { icon: '/icon.svg' },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="fr">
      <body>{children}</body>
    </html>
  );
}
