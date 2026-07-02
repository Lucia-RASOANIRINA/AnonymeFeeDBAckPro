import Link from 'next/link';
import { redirect } from 'next/navigation';
import { createClient } from '@/lib/supabase/server';
import { LayoutDashboard, MessageSquare, Building2, Bell, LogOut } from 'lucide-react';

const nav = [
  { href: '/dashboard', label: 'Tableau de bord', icon: LayoutDashboard },
  { href: '/dashboard/feedbacks', label: 'Feedbacks', icon: MessageSquare },
  { href: '/dashboard/establishments', label: 'Établissements', icon: Building2 },
  { href: '/dashboard/alerts', label: 'Alertes', icon: Bell },
];

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect('/login');

  return (
    <div className="min-h-screen flex">
      {/* Barre latérale */}
      <aside className="w-60 shrink-0 bg-white border-r flex flex-col">
        <div className="p-5 border-b">
          <h1 className="text-lg font-bold text-brand">AnonyFeedback</h1>
        </div>
        <nav className="flex-1 p-3 space-y-1">
          {nav.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className="flex items-center gap-3 rounded-lg px-3 py-2 text-sm text-gray-700 hover:bg-brand-light"
            >
              <item.icon size={18} />
              {item.label}
            </Link>
          ))}
        </nav>
        <form action="/auth/signout" method="post" className="p-3 border-t">
          <button className="flex w-full items-center gap-3 rounded-lg px-3 py-2 text-sm text-red-600 hover:bg-red-50">
            <LogOut size={18} /> Déconnexion
          </button>
        </form>
      </aside>

      <main className="flex-1 p-6 overflow-auto">{children}</main>
    </div>
  );
}
