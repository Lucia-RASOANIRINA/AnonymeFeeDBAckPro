import { createClient } from '@/lib/supabase/server';

/** Alertes intelligentes (feedbacks critiques / notes très basses). */
export default async function AlertsPage() {
  const supabase = await createClient();
  const { data } = await supabase
    .from('alerts')
    .select('id, level, message, is_read, created_at')
    .order('created_at', { ascending: false })
    .limit(100);

  const rows = data ?? [];
  const color = (lvl: string) =>
    lvl === 'critical' ? 'bg-red-100 text-red-700' : lvl === 'warning' ? 'bg-amber-100 text-amber-700' : 'bg-blue-100 text-blue-700';

  return (
    <div className="space-y-4">
      <h2 className="text-2xl font-bold">Alertes</h2>
      <div className="space-y-2">
        {rows.map((a) => (
          <div key={a.id} className="bg-white rounded-xl border p-4 flex items-center gap-3">
            <span className={`px-2 py-1 rounded text-xs font-medium ${color(a.level)}`}>
              {a.level}
            </span>
            <span className="flex-1">{a.message}</span>
            <span className="text-xs text-gray-400">
              {new Date(a.created_at).toLocaleString('fr-FR')}
            </span>
          </div>
        ))}
        {rows.length === 0 && (
          <p className="text-sm text-gray-400">Aucune alerte.</p>
        )}
      </div>
    </div>
  );
}
