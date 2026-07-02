import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: 'AnonyFeedback Pro — Admin',
  description: 'Plateforme d’administration des retours anonymes',
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
