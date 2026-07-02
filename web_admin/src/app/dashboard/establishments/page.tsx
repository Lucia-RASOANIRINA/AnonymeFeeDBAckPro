import { createClient } from '@/lib/supabase/server';

/** Gestion des établissements / domaines (création & QR à étendre). */
export default async function EstablishmentsPage() {
  const supabase = await createClient();
  const { data } = await supabase
    .from('establishments')
    .select('id, name, sector_id, address, qr_code')
    .order('name');

  const rows = data ?? [];

  return (
    <div className="space-y-4">
      <h2 className="text-2xl font-bold">Établissements</h2>
      <div className="bg-white rounded-2xl border overflow-hidden">
        <table className="w-full text-sm">
          <thead className="bg-gray-50 text-left text-gray-500">
            <tr>
              <th className="p-3">Nom</th>
              <th className="p-3">Secteur</th>
              <th className="p-3">Adresse</th>
              <th className="p-3">QR</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((e) => (
              <tr key={e.id} className="border-t">
                <td className="p-3 font-medium">{e.name}</td>
                <td className="p-3">{e.sector_id}</td>
                <td className="p-3">{e.address ?? '—'}</td>
                <td className="p-3">{e.qr_code ?? '—'}</td>
              </tr>
            ))}
            {rows.length === 0 && (
              <tr>
                <td className="p-6 text-center text-gray-400" colSpan={4}>
                  Aucun établissement.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
