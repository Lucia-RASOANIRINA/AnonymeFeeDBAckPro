'use client';

import { createClient } from '@/lib/supabase/client';
import { useEffect, useState, useCallback } from 'react';
import { MessageSquare, Search, X, Trash2, Star } from 'lucide-react';

type Feedback = {
  id: string;
  sector_id: string | null;
  rating_normalized: number | null;
  comment: string | null;
  moderation_status: string | null;
  priority: boolean | null;
  is_critical: boolean | null;
  created_at: string;
  establishment: { name: string | null } | null;
};

const sectorLabels: Record<string, string> = {
  education: 'Éducation',
  health: 'Santé',
  transport: 'Transport',
  administration: 'Administration',
  public_admin: 'Administration',
  commerce: 'Commerce',
  hospitality: 'Restauration',
  energy: 'Énergie',
  water: 'Eau',
  telecom: 'Télécom',
};

const statusColors: Record<string, string> = {
  new: 'bg-blue-100 text-blue-700',
  validated: 'bg-green-100 text-green-700',
  resolved: 'bg-emerald-100 text-emerald-700',
  hidden: 'bg-gray-100 text-gray-500',
};

const statusLabels: Record<string, string> = {
  new: 'Nouveau',
  validated: 'Validé',
  resolved: 'Résolu',
  hidden: 'Masqué',
};

const STATUS_OPTIONS = ['new', 'validated', 'resolved', 'hidden'];

/** Liste et modération des feedbacks (données réelles Supabase). */
export default function FeedbacksPage() {
  const [feedbacks, setFeedbacks] = useState<Feedback[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [filterStatus, setFilterStatus] = useState<string>('all');
  const [searchTerm, setSearchTerm] = useState('');
  const [busyId, setBusyId] = useState<string | null>(null);

  const load = useCallback(async () => {
    setLoading(true);
    const supabase = createClient();
    const { data, error: fetchError } = await supabase
      .from('feedbacks')
      .select(
        'id, sector_id, rating_normalized, comment, moderation_status, priority, is_critical, created_at, establishment:establishment_id(name)'
      )
      .order('created_at', { ascending: false })
      .limit(200);

    if (fetchError) {
      setError(fetchError.message);
      setFeedbacks([]);
    } else {
      setError(null);
      setFeedbacks(((data as unknown) as Feedback[]) ?? []);
    }
    setLoading(false);
  }, []);

  useEffect(() => {
    load();
  }, [load]);

  async function updateStatus(id: string, moderation_status: string) {
    setBusyId(id);
    const supabase = createClient();
    const { error: e } = await supabase
      .from('feedbacks')
      .update({ moderation_status })
      .eq('id', id);
    if (e) setError(e.message);
    else
      setFeedbacks((prev) =>
        prev.map((f) => (f.id === id ? { ...f, moderation_status } : f))
      );
    setBusyId(null);
  }

  async function togglePriority(f: Feedback) {
    setBusyId(f.id);
    const supabase = createClient();
    const next = !f.priority;
    const { error: e } = await supabase
      .from('feedbacks')
      .update({ priority: next })
      .eq('id', f.id);
    if (e) setError(e.message);
    else
      setFeedbacks((prev) =>
        prev.map((x) => (x.id === f.id ? { ...x, priority: next } : x))
      );
    setBusyId(null);
  }

  async function remove(id: string) {
    if (!confirm('Supprimer définitivement ce feedback ?')) return;
    setBusyId(id);
    const supabase = createClient();
    const { error: e } = await supabase.from('feedbacks').delete().eq('id', id);
    if (e) setError(e.message);
    else setFeedbacks((prev) => prev.filter((f) => f.id !== id));
    setBusyId(null);
  }

  const filtered = feedbacks.filter((f) => {
    if (filterStatus === 'critical') {
      if (!(f.is_critical || f.priority)) return false;
    } else if (filterStatus !== 'all' && f.moderation_status !== filterStatus) {
      return false;
    }
    if (searchTerm) {
      const s = searchTerm.toLowerCase();
      return (
        f.comment?.toLowerCase().includes(s) ||
        f.sector_id?.toLowerCase().includes(s) ||
        f.establishment?.name?.toLowerCase().includes(s)
      );
    }
    return true;
  });

  const stats = {
    total: feedbacks.length,
    new: feedbacks.filter((f) => f.moderation_status === 'new').length,
    validated: feedbacks.filter((f) => f.moderation_status === 'validated').length,
    resolved: feedbacks.filter((f) => f.moderation_status === 'resolved').length,
    critical: feedbacks.filter((f) => f.is_critical || f.priority).length,
  };

  const formatDate = (date: string) => {
    try {
      return new Date(date).toLocaleDateString('fr-FR', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
      });
    } catch {
      return date;
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-brand"></div>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-2">
        <h2 className="text-2xl font-bold">Feedbacks</h2>
        <span className="text-xs text-gray-400">{feedbacks.length} au total</span>
      </div>

      {error && (
        <div className="bg-red-50 text-red-700 text-sm rounded-lg p-3 border border-red-200">
          {error}
        </div>
      )}

      {/* Recherche + filtres */}
      <div className="flex flex-col md:flex-row gap-3">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" size={18} />
          <input
            type="text"
            placeholder="Rechercher (commentaire, secteur, établissement)…"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full pl-10 pr-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-brand"
          />
          {searchTerm && (
            <button
              onClick={() => setSearchTerm('')}
              className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
            >
              <X size={16} />
            </button>
          )}
        </div>
        <div className="flex gap-2 overflow-x-auto pb-1">
          {[
            { k: 'all', label: `Tous (${stats.total})` },
            { k: 'new', label: `Nouveaux (${stats.new})` },
            { k: 'validated', label: `Validés (${stats.validated})` },
            { k: 'resolved', label: `Résolus (${stats.resolved})` },
            { k: 'critical', label: `⚠️ Critiques (${stats.critical})` },
          ].map((b) => (
            <button
              key={b.k}
              onClick={() => setFilterStatus(b.k)}
              className={`px-3 py-1 rounded-full text-sm whitespace-nowrap ${
                filterStatus === b.k
                  ? 'bg-brand text-white'
                  : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
              }`}
            >
              {b.label}
            </button>
          ))}
        </div>
      </div>

      {/* Tableau (scroll horizontal sur mobile) */}
      <div className="bg-white rounded-2xl border overflow-hidden">
        {filtered.length === 0 ? (
          <div className="p-8 text-center text-gray-400">
            <MessageSquare size={40} className="mx-auto mb-2 opacity-50" />
            <p>Aucun feedback trouvé</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead className="bg-gray-50 text-left text-gray-500">
                <tr>
                  <th className="p-3">Établissement</th>
                  <th className="p-3">Secteur</th>
                  <th className="p-3">Note</th>
                  <th className="p-3">Commentaire</th>
                  <th className="p-3">Statut</th>
                  <th className="p-3">Prio.</th>
                  <th className="p-3">Date</th>
                  <th className="p-3"></th>
                </tr>
              </thead>
              <tbody>
                {filtered.map((f) => {
                  const sectorLabel = sectorLabels[f.sector_id ?? ''] || f.sector_id;
                  const status = f.moderation_status ?? 'new';
                  const rating = ((f.rating_normalized ?? 0) / 20).toFixed(1);
                  const name = f.establishment?.name || '—';
                  const disabled = busyId === f.id;

                  return (
                    <tr key={f.id} className="border-t hover:bg-gray-50 transition-colors">
                      <td className="p-3">{name}</td>
                      <td className="p-3">
                        <span className="text-xs font-medium px-2 py-0.5 rounded bg-blue-100 text-blue-700">
                          {sectorLabel}
                        </span>
                      </td>
                      <td className="p-3">
                        <span
                          className={`font-medium ${
                            parseFloat(rating) < 2
                              ? 'text-red-600'
                              : parseFloat(rating) < 3
                              ? 'text-yellow-600'
                              : 'text-green-600'
                          }`}
                        >
                          {rating}/5
                        </span>
                      </td>
                      <td className="p-3 max-w-xs truncate" title={f.comment || ''}>
                        {f.comment || '—'}
                      </td>
                      <td className="p-3">
                        <select
                          value={status}
                          disabled={disabled}
                          onChange={(e) => updateStatus(f.id, e.target.value)}
                          className={`text-xs font-medium px-2 py-1 rounded border-0 cursor-pointer ${
                            statusColors[status] || 'bg-gray-100 text-gray-700'
                          }`}
                        >
                          {STATUS_OPTIONS.map((s) => (
                            <option key={s} value={s}>
                              {statusLabels[s]}
                            </option>
                          ))}
                        </select>
                      </td>
                      <td className="p-3">
                        <button
                          onClick={() => togglePriority(f)}
                          disabled={disabled}
                          title="Basculer la priorité"
                          className={f.priority || f.is_critical ? 'text-amber-500' : 'text-gray-300 hover:text-amber-400'}
                        >
                          <Star size={16} fill={f.priority ? 'currentColor' : 'none'} />
                        </button>
                      </td>
                      <td className="p-3 text-xs text-gray-400 whitespace-nowrap">
                        {formatDate(f.created_at)}
                      </td>
                      <td className="p-3">
                        <button
                          onClick={() => remove(f.id)}
                          disabled={disabled}
                          title="Supprimer"
                          className="text-gray-400 hover:text-red-600"
                        >
                          <Trash2 size={16} />
                        </button>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
